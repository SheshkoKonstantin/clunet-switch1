/**************************************************************************************
The MIT License (MIT)
Copyright (c) 2016 Sergey V. DUDANOV
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*****************************************************************************************/

#include <avr/boot.h>
#include <avr/interrupt.h>
#include <util/crc16.h>
#include "clunet.h"

#define COMMAND_FIRMWARE_UPDATE_START	0	// Информируем сеть, что мы в загрузчике
#define COMMAND_FIRMWARE_UPDATE_INIT	1	// Субкоманда инициализации процедуры загрузки прошивки
#define COMMAND_FIRMWARE_UPDATE_READY	2	// Информируем, что мы в режиме прошивки
#define COMMAND_FIRMWARE_UPDATE_WRITE	3	// Субкоманда записи данных во флеш-память (отправитель внешнее устройство)
#define COMMAND_FIRMWARE_UPDATE_WRITTEN	4	// Подтверждение выполнения команды записи (отправитель мы)
#define COMMAND_FIRMWARE_UPDATE_DONE	5	// Субкоманда окончания записи и выполнения записанной программы (отправитель внешнее устройство)

#define APP_END (FLASHEND - (BOOTSIZE * 2))

#define RECEIVED_COMMAND buffer[CLUNET_OFFSET_COMMAND]
#define RECEIVED_SUB_COMMAND buffer[CLUNET_OFFSET_DATA]
#define FLASHER_ADDRESS buffer[CLUNET_OFFSET_SRC_ADDRESS]

/* Вспомогательные макросы для передачи пакетов */
#define PAUSE(t) { CLUNET_TIMER_REG = 0; while (CLUNET_TIMER_REG < (t * CLUNET_T)); }

// Максимальный размер страницы
#if SPM_PAGESIZE > 128
 #define MY_SPM_PAGESIZE 128
#else
 #define MY_SPM_PAGESIZE SPM_PAGESIZE
#endif

// Таймаут ожидания приемки пакета в циклах переполнения таймера
#define BOOTLOADER_TIMEOUT_OVERFLOWS ((uint16_t)(((float)BOOTLOADER_TIMEOUT / 1000.0f) * ((float)F_CPU / (float)CLUNET_TIMER_PRESCALER / 256.0f)))


static uint8_t buffer[MY_SPM_PAGESIZE + 11];

static void (*jump_to_app)(void) = 0x0000;

static uint8_t
control_command[5] =		{
					CLUNET_DEVICE_ID,
					CLUNET_BROADCAST_ADDRESS,
					CLUNET_COMMAND_BOOT_CONTROL,	// команда
					1,				// размер данных
					0				// субкоманда
				};

static uint8_t update_init_response[6] =	{
					CLUNET_DEVICE_ID,
					CLUNET_BROADCAST_ADDRESS,
					CLUNET_COMMAND_BOOT_CONTROL,	// команда
					2,				// размер данных
					COMMAND_FIRMWARE_UPDATE_READY,	// субкоманда
					MY_SPM_PAGESIZE			// размер страницы
				};

// Максимально допустимая рассинхронизация между устройствами сети
const uint8_t max_delta = (uint8_t)((float)CLUNET_T * 0.3f);

static uint8_t
ibutton_crc(const uint8_t* data, const uint8_t size)
{
	uint8_t crc = 0;
	uint8_t idx = 0;
	while (idx < size)
		crc = _crc_ibutton_update(crc, data[idx++]);
	return crc;
}

/*	Функция ожидания межкадрового интервала длительностью 8Т.
	Блокирует управление до обнаружения интервала или начала передачи от другого устройства в пределах допустимой рассинхронизации.
*/
static uint8_t wait_interframe(void) {	//
	uint8_t delta;
	uint16_t overflows = BOOTLOADER_TIMEOUT_OVERFLOWS; //
_clear:
	CLUNET_TIMER_OVERFLOW_CLEAR; //
	CLUNET_TIMER_REG = 0;
	do {
		delta = (8 * CLUNET_T) - CLUNET_TIMER_REG;
		if (CLUNET_READING) {
			if (!(--overflows)) return 1; //
			if (delta > max_delta) goto _clear;
			break;
		}
	}
	while (delta);
	return 0;
}


/*	Функция ожидания начала кадра (доминантного бита) в течении таймаута,
	заданном в Makefile параметром BOOTLOADER_TIMEOUT (в милисекундах).
	Возвращает: 0 при успехе, 1 при прошедшем таймауте ожидания (так никто и не начал передачу)
*/
static uint8_t
wait_for_start(void)
{
	CLUNET_TIMER_REG = 0;
	uint16_t overflows = BOOTLOADER_TIMEOUT_OVERFLOWS;
_clear:
	CLUNET_TIMER_OVERFLOW_CLEAR;
	while (!CLUNET_READING) {
		if (CLUNET_TIMER_OVERFLOW) {
			if (--overflows)
				goto _clear;
			return 1;
		}
	}
	return 0;
}

/*	Функция чтения битовой задержки до заданного типа сигнала.
	Если signal == 0, то ждем рецессивный (измеряем доминантные биты), иначе наоборот).
	Возвращает количество прочитанных бит, 0 - при ошибке.
*/
static uint8_t
read_signal(const uint8_t signal)
{
	CLUNET_TIMER_REG = 0;
	uint8_t bitNum = 0;
	uint8_t period = CLUNET_T / 2;
	uint8_t state;
	do
	{
		if (CLUNET_TIMER_REG >= period)
		{
			// Ошибка: не может быть больше 5 бит
			if (++bitNum > 5)
				return 0;
			period += CLUNET_T;
		}
		state = CLUNET_READING;
	}
	while ((state && !signal) || (!state && signal));
	return bitNum;
}

static void send(const uint8_t* data, const uint8_t size) {
	const uint8_t crc = ibutton_crc(data, size);
_repeat:
	// Ждем освобождения линии и межкадровое пространство 8Т в блокирующем режиме (в конце концов замкнутая накоротко линия это ненормально)
	if (wait_interframe() != 0) return; //
	//wait_interframe();
	CLUNET_SEND_1;
	uint8_t bit_index, byte_index, line_pullup;
	bit_index = byte_index = line_pullup = 0;
	uint8_t data_byte = *data;
	uint8_t bit_task = 4;
	do {
		CLUNET_TIMER_REG = 0; // Reset timer
		while (((data_byte << bit_index) & 0x80) ^ line_pullup) {
			bit_task++;
			if (++bit_index & 8) {
				if (++byte_index < size)
					data_byte = data[byte_index];
				else if (byte_index == size)
					data_byte = crc;
				else break; // End of data
				bit_index = 0;
			}
			if (bit_task == 5)
				break;
		}

		// Задержка по количеству передаваемых бит и проверка на конфликт с синхронизацией при передаче
		uint8_t delta;
		const uint8_t stop = bit_task * CLUNET_T;
		do
		{
			const uint8_t now = CLUNET_TIMER_REG;
			delta = stop - now;
			if (line_pullup && (now > max_delta) && CLUNET_READING)
			{
				if (delta > max_delta)
					goto _repeat;
				break;
			}
		}
		while (delta);

		if (line_pullup ^= 0x80)
			CLUNET_SEND_0;
		else
			CLUNET_SEND_1;

		bit_task = (bit_task == 5);
	}
	while (!(bit_index & 8));

	// Если линию на финише прижали, то через 1Т отпустим ее
	if (!line_pullup)
	{
		PAUSE(1);
		CLUNET_SEND_0;
	}
}

/*
	ЧТЕНИЕ СИСТЕМНЫХ ПАКЕТОВ ОБНОВЛЕНИЯ
	static uint8_t read(void)
	
	Блокирует управление пока линия прижата, при освобождении ожидает межкадровый интервал длительностью 7Т,
	переходит в состояние чтения пакета, читает, проверяет контрольную сумму, удостоверяется что этот пакет системный и предназначен для нас.
	Возвращает длину принятого пакета, в случае ошибки - 0.
*/

static uint8_t read(void) {
	// Ждем освобождения линии и межкадровое пространство в блокирующем режиме (в конце концов замкнутая накоротко линия это ненормально)
	if (wait_interframe()!=0) return 0;
	//wait_interframe();
	
	// Ожидаем начала передачи в течении таймаута, заданном в defines.h в параметре BOOTLOADER_TIMEOUT (в милисекундах)
	// Если не дожидаемся - выходим
	if (wait_for_start())
		return 0;
	// Читаем доминантные биты
	uint8_t num_bits = read_signal(0);
	if (!(num_bits & 4))
		return 0;

	uint8_t bit_index, bit_stuff;
	bit_index = bit_stuff = num_bits & 1; // Если приняли 5 бит, то битовый индекс и битстаффинг = 1, иначе 0;
	uint8_t byte_index = 0;
	uint8_t line_pullup = buffer[0] = 255;

	while (1)
	{
		num_bits = read_signal(line_pullup);
			
		if (!num_bits)
			return 0;

		const uint8_t mask = 255 >> bit_index;
		line_pullup = ~line_pullup;
		if (line_pullup)
			buffer[byte_index] |= mask;
		else
			buffer[byte_index] &= ~mask;

		// Обновим битовый индекс с учетом битстаффинга
		bit_index += num_bits - bit_stuff;

		if (bit_index & 8)
		{
			/* Пакет прочитан полностью, выходим из цикла, проверяем и возвращаем управление */
			if ((++byte_index > CLUNET_OFFSET_SIZE) && (byte_index > buffer[CLUNET_OFFSET_SIZE] + CLUNET_OFFSET_DATA))
				break;

				/* Если данные прочитаны не полностью и мы не выходим за пределы буфера, то присвоим очередной байт и подготовим битовый индекс */
			else if (byte_index < CLUNET_READ_BUFFER_SIZE)
			{
				bit_index &= 7;
				buffer[byte_index] = line_pullup;
			}

			/* Иначе ошибка: нехватка приемного буфера -> игнорируем пакет */
			else return 0;
		}

		// Смотрим надо ли применять битстаффинг
		bit_stuff = (num_bits == 5);
	}
	// Пакет принят
	if ((buffer[CLUNET_OFFSET_DST_ADDRESS] == CLUNET_DEVICE_ID) && (RECEIVED_COMMAND == CLUNET_COMMAND_BOOT_CONTROL)
		&& !ibutton_crc(buffer, byte_index))
			return byte_index;
	return 0;
}


static void
#if (FLASHEND > USHRT_MAX)
write_flash_page(uint32_t address, uint8_t* pagebuffer)
#else
write_flash_page(uint16_t address, uint8_t* pagebuffer)
#endif
{

	eeprom_busy_wait();

#if MY_SPM_PAGESIZE != SPM_PAGESIZE
	if (!(address % SPM_PAGESIZE))
#endif
	{
		boot_page_erase(address);
		boot_spm_busy_wait();		// Wait until the memory is erased.
	}

	uint8_t i;
	for (i = 0; i < MY_SPM_PAGESIZE; i += 2)
		boot_page_fill(address + i, *((uint16_t*)(pagebuffer + i)));

		boot_page_write(address);	// Store buffer in flash page.
		boot_spm_busy_wait();		// Wait until the memory is written.

		boot_rww_enable();
}

static inline void send_firmware_command(const uint8_t sub_command) {
	control_command[CLUNET_OFFSET_DATA] = sub_command;
	send(control_command, sizeof(control_command));
}

int main(void) {
	cli();
 	CLUNET_TIMER_INIT;
	CLUNET_PIN_INIT;
	// Делаем 5 попыток получить в ответ служебный пакет, при успехе переходим в режим прошивки, иначе загружаем основную программу
	uint8_t packets = 5;
	do {
		// Посылаем широковещательный пакет, что мы в загрузчике
		send_firmware_command(COMMAND_FIRMWARE_UPDATE_START);
		uint8_t rr = read();
		//if (rr==06)
		//send_firmware_command(RECEIVED_SUB_COMMAND);
		//send_firmware_command(rr);
		//send_firmware_command(COMMAND_FIRMWARE_UPDATE_INIT);
		//send_firmware_command(RECEIVED_SUB_COMMAND);
		
		if (rr && (RECEIVED_SUB_COMMAND == COMMAND_FIRMWARE_UPDATE_INIT)) {
			const uint8_t flasher_address = FLASHER_ADDRESS; // Запомним, кто инициировал обновление, с тем и будем дальше работать
			// Теперь работаем только с конкретным устройством
			update_init_response[CLUNET_OFFSET_DST_ADDRESS] = flasher_address;
			control_command[CLUNET_OFFSET_DST_ADDRESS] = flasher_address;
			// Говорим устройству, что мы в режиме прошивки и сообщаем наш размер страницы памяти
			send(update_init_response, sizeof(update_init_response));
			while (1)
			{
				// Если системный пакет получен и он от нужного устройства, то обработаем его
				if (read() && FLASHER_ADDRESS == flasher_address)
				{
					const uint8_t subCmd = RECEIVED_SUB_COMMAND;
					switch (subCmd)
					{
						case COMMAND_FIRMWARE_UPDATE_WRITE:
						{
							#if (FLASHEND > USHRT_MAX)
							uint32_t address = *((uint32_t*)(buffer + (CLUNET_OFFSET_DATA + 1)));
							#else
							uint16_t address = *((uint16_t*)(buffer + (CLUNET_OFFSET_DATA + 1)));	// Адрес страницы памяти берем начиная с 6-го байта (смещение +5). Размер фиксирован - 32 бит.
							#endif
							uint8_t* pagebuffer = buffer + (CLUNET_OFFSET_DATA + 5); // с 10-го байта в пакете (смещение +9) начинаются данные. Размер - MY_SPM_PAGESIZE байт.
							write_flash_page(address, pagebuffer); // Пишем во флеш-память
							send_firmware_command(COMMAND_FIRMWARE_UPDATE_WRITTEN);	// Отправляем подтверждение записи
						}
						break;
						case COMMAND_FIRMWARE_UPDATE_INIT:
							send(update_init_response, sizeof(update_init_response));
							break;
						case COMMAND_FIRMWARE_UPDATE_DONE:
							goto _done;
					}
				}
			}
		}
	}
	while (--packets);

_done:

	jump_to_app();

	return 0;
}
