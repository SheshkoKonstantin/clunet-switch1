# Main program name
PRG              = main

# AVRDUDE's config options for 'program' target
LFUSE            = E4
HFUSE            = D9
PROGRAMMER_MCU   = m8
PROGRAMMER_TYPE  = usbasp
PROGRAMMER_PORT  = usb

# Config options of CLUNET flash tool for optional 'program' target
CLUNET_PATH      = .
CLUNET_FLASHER   = /home/kosta/dev/clunet-gw/flash_util/util
CLUNET_IP        = 192.168.88.14
CLUNET_PORT      = 8888
CLUNET_DEVICE_ID = 100

# MCU
MCU_TARGET       = atmega8

# Main frequency
F_CPU            = 8000000UL

# GCC optimize level
OPTIMIZE = s

DEFS             = 
LIBS             = $(CLUNET_PATH)/clunet.c

# You should not have to change anything below here.

OBJ              = $(PRG).o

CC               = avr-gcc

# Override is only needed by avr-lib build system.

override CFLAGS        = -g -Wall -Wextra -O$(OPTIMIZE) -mmcu=$(MCU_TARGET) $(DEFS) -DF_CPU=$(F_CPU) -I. -I$(CLUNET_PATH)
override LDFLAGS       = -Wl,-Map,$(PRG).map

OBJCOPY        = avr-objcopy
OBJDUMP        = avr-objdump

all: $(PRG).elf lst text eeprom

$(PRG).elf: $(OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)

# dependency:
main.o: main.c

clean:
	rm -rf *.o $(PRG).elf *.eps *.png *.pdf *.bak 
	rm -rf *.lst *.map $(EXTRA_CLEAN_FILES)

lst:  $(PRG).lst

%.lst: %.elf
	$(OBJDUMP) -h -S $< > $@

# Rules for building the .text rom images

text: hex bin srec

hex:  $(PRG).hex
bin:  $(PRG).bin
srec: $(PRG).srec

%.hex: %.elf
	$(OBJCOPY) -j .text -j .data -O ihex $< $@

%.srec: %.elf
	$(OBJCOPY) -j .text -j .data -O srec $< $@

%.bin: %.elf
	$(OBJCOPY) -j .text -j .data -O binary $< $@

# Rules for building the .eeprom rom images

eeprom: ehex ebin esrec

ehex:  $(PRG)_eeprom.hex
ebin:  $(PRG)_eeprom.bin
esrec: $(PRG)_eeprom.srec

%_eeprom.hex: %.elf
	$(OBJCOPY) -j .eeprom --change-section-lma .eeprom=0 -O ihex $< $@ \
	|| { echo empty $@ not generated; exit 0; }

%_eeprom.srec: %.elf
	$(OBJCOPY) -j .eeprom --change-section-lma .eeprom=0 -O srec $< $@ \
	|| { echo empty $@ not generated; exit 0; }

%_eeprom.bin: %.elf
	$(OBJCOPY) -j .eeprom --change-section-lma .eeprom=0 -O binary $< $@ \
	|| { echo empty $@ not generated; exit 0; }

# Every thing below here is used by avr-libc's build system and can be ignored
# by the casual user.

FIG2DEV                 = fig2dev
EXTRA_CLEAN_FILES       = *.hex *.bin *.srec

dox: eps png pdf

eps: $(PRG).eps
png: $(PRG).png
pdf: $(PRG).pdf

%.eps: %.fig
	$(FIG2DEV) -L eps $< $@

%.pdf: %.fig
	$(FIG2DEV) -L pdf $< $@

%.png: %.fig
	$(FIG2DEV) -L png $< $@

program: hex
#	$(CLUNET_FLASHER) $(CLUNET_IP) $(CLUNET_PORT) $(CLUNET_DEVICE_ID) $(PRG).hex
	avrdude -V -p $(PROGRAMMER_MCU) -c $(PROGRAMMER_TYPE) -P $(PROGRAMMER_PORT) -U flash:w:$(PRG).hex -U lfuse:w:0x$(LFUSE):m -U hfuse:w:0x$(HFUSE):m

prog: hex
	$(CLUNET_FLASHER) $(PRG).hex $(CLUNET_DEVICE_ID) $(CLUNET_IP):$(CLUNET_PORT)
