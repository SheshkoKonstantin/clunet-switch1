/*******************************************************
Тестовый код
*******************************************************/

#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <avr/sleep.h>
//#include <avr/wdt.h>
#include "clunet.h"


// Первый светодиод
#define red1_on() PORTB |= _BV(PB2)
#define red1_off() PORTB &= ~_BV(PB2)
#define green1_on() PORTB |= _BV(PB1)
#define green1_off() PORTB &= ~_BV(PB1)
#define blue1_on() PORTB  |= _BV(PB0)
#define blue1_off() PORTB&= ~_BV(PB0)

// Второй светодиод
#define red2_on() PORTB  |=  _BV(PB5)
#define red2_off() PORTB &= ~_BV(PB5)
#define green2_on() PORTC|=  _BV(PC1)
#define green2_off() PORTC&=~_BV(PC1)
#define blue2_on() PORTC |=  _BV(PC0)
#define blue2_off() PORTC &=~_BV(PC0)

// Третий светодиод
#define red3_on() PORTC  |=  _BV(PC3)
#define red3_off() PORTC &= ~_BV(PC3)
#define green3_on() PORTC|=  _BV(PC4)
#define green3_off() PORTC&=~_BV(PC4)
#define blue3_on() PORTC |=  _BV(PC5)
#define blue3_off() PORTC &=~_BV(PC5)

// Первое реле
#define rel1_1_on() PORTD   |= _BV(PD6)
#define rel1_1_off() PORTD &= ~_BV(PD6)
#define rel1_2_on() PORTD   |= _BV(PD7)
#define rel1_2_off() PORTD &= ~_BV(PD7)

// Второе реле
#define rel2_1_on() PORTD   |= _BV(PD5)
#define rel2_1_off() PORTD &= ~_BV(PD5)
#define rel2_2_on() PORTB   |= _BV(PB7)
#define rel2_2_off() PORTB &= ~_BV(PB7)

// Кнопки
#define BUT1	(PINB & _BV(PB3))
#define BUT2	(PINB & _BV(PB4))
#define BUT3	(PINC & _BV(PC2))

// Динамик
#define SPK_ON()	PORTB |= _BV(PB6)
#define SPK_OFF()	PORTB &=~_BV(PB6)


#define BUT_CNT 100


uint8_t sk_r_min[3]={0,0,0};
uint8_t sk_g_min[3]={0,0,1};
uint8_t sk_b_min[3]={2,2,0};
uint8_t sk_r_max[3]={2,0,1};
uint8_t sk_g_max[3]={0,1,1};
uint8_t sk_b_max[3]={2,2,0};
uint8_t sk_r[3];
uint8_t sk_g[3];
uint8_t sk_b[3];
char sk_r_speed[3]={1,1,1};
char sk_g_speed[3]={1,1,1};
char sk_b_speed[3]={1,2,1};


void leds_off() {
    red1_off();
    red2_off();
    red3_off();
    green1_off();
    green2_off();
    green3_off();
    blue1_off();
    blue2_off();
    blue3_off();
    return;
}

uint8_t stats=0;
#define stat_r1 0x01
#define stat_r2 0x02
#define RELAY_RELAY 100


void tone1() {
    for (uint8_t i=0;i<128;++i) {
	_delay_us(300);
	SPK_ON();
	_delay_us(30);
	SPK_OFF();
    }
    return;
}

void alarm1() {
    for (uint8_t i=0;i<8;++i) {
	_delay_ms(50);
	tone1();
    }
    
    return;
}

void relay1_on() {
    leds_off();
    rel1_1_on();
    _delay_ms(RELAY_RELAY);
    rel1_1_off();
    stats |= stat_r1;
    return;
}

void relay1_off() {
    leds_off();
    rel1_2_on();
    _delay_ms(RELAY_RELAY);
    rel1_2_off();
    stats &= ~stat_r1;
    return;
}

void relay1_switch() {
    if (stats&stat_r1) {
	relay1_off();
    } else {
	relay1_on();
    }
    return;
}

void relay2_on() {
    leds_off();
    rel2_2_on();
    _delay_ms(RELAY_RELAY);
    rel2_2_off();
    stats |= stat_r2;
    return;
}

void relay2_off() {
    leds_off();
    rel2_1_on();
    _delay_ms(RELAY_RELAY);
    rel2_1_off();
    stats &= ~stat_r2;
    return;
}

void relay2_switch() {
    if (stats&stat_r2) {
	relay2_off();
    } else {
	relay2_on();
    }
    return;
}


uint8_t light_state=0;
void light_touch() {
    ++light_state;
    switch (light_state) {
	    case 1:
		relay2_on();
		break;
	    case 2:
		relay2_off();
		relay1_on();
		break;
	    case 3:
		relay2_on();
		break;
	    case 4:
		relay2_off();
		break;
	    case 5:
		relay1_off();
		relay2_on();
		break;
	    case 6:
		relay2_off();
		light_state=0;
		break;
    	    default:
		light_state=0;
		break;
    }
    clunet_send(0xff,3,0xa1, (char *)(&light_state), 1);
    return;
}

void button1_event() {
    relay1_switch();
    tone1();
    clunet_send(0xff,3,101,0,0);
    return;
}

void button2_event() {
    relay2_switch();
    tone1();
    clunet_send(0xff,3,102,0,0);
    return;
}

void button3_event() {
    light_touch();
    tone1();
    clunet_send(0xff,3,103,0,0);
    return;
}




/* СДЕЛАТЬ НОРМАЛЬНО! */
uint8_t hex2uchar (uint8_t ch, uint8_t cl) {
    uint8_t byte=0;
    if ((cl>='0')&&(cl<='9')) {
    byte+=(cl-'0');
    }
    if ((cl>='a')&&(cl<='f')) {
    byte+=(cl-'a'+10);
    }
    if ((ch>='0')&&(ch<='9')) {
    byte+=((ch-'0')*16);
    }
    if ((ch>='a')&&(ch<='f')) {
    byte+=((ch-'a'+10)*16);
    }
    return byte;
}

void data_received (uint8_t src_address, uint8_t command, char* data, uint8_t size) {
    if (command==51) {
	tone1();
    } else
    if ((size>0) && (command==0x50)) {
	if (data[0]=='c') {
	    //clunet_send(src_address,3,50,0,0);
	    switch (data[1]) {
		case 'r':
		    //if (hex2uchar(data[2],data[3])!=0) red1_on(); else red1_off();
		    //sk_r1_max=hex2uchar(data[2],data[3]);
		    break;
		case 'g':
		    ///if (hex2uchar(data[2],data[3])!=0) green1_on(); else green1_off();
		    //sk_g1_max=hex2uchar(data[2],data[3]);
		    break;
		case 'b':
		    //if (hex2uchar(data[2],data[3])!=0) blue1_on(); else blue1_off();
		    //sk_b1_max=hex2uchar(data[2],data[3]);
		    break;
		case 'z':
		    //if (data[2]=='0') {b1_on(); _delay_ms(100); b1_off();}
		    //if (data[2]=='1') {b2_on(); _delay_ms(100); b2_off();}
		    break;
		case 'x':
		    //if (data[2]=='0') {b3_on(); _delay_ms(100); b3_off();}
		    //if (data[2]=='1') {b4_on(); _delay_ms(100); b4_off();}
		    break;
		default:
		    break;
	    }
	} else
	if (data[0]=='r') {
	    clunet_send(src_address,3,0xaa,0,0);
	    switch (data[1]) {
		case 0x01:
		    relay1_switch();
		    break;
		case 0x02:
		    relay2_switch();
		    break;
		case 0x05:
		    light_touch();
		    break;
		case 0x06:
		    alarm1();
		    break;
		default:
		    break;
	    }
	} else 
	if ((data[0]==0x73)&&(size==5)) {
	    clunet_send(src_address,3,0xbb,0,0);
	    
	    uint8_t n=data[1];
	    if (n>2) return;
	    sk_r_max[n]=data[2];
	    sk_g_max[n]=data[3];
	    sk_b_max[n]=data[4];
	    sk_r_min[n]=data[2];
	    sk_g_min[n]=data[3];
	    sk_b_min[n]=data[4];
	    sk_r[n]=data[2];
	    sk_g[n]=data[3];
	    sk_b[n]=data[4];
	}


    }
    return;
}

int main (void)
{


	DDRB= 0b11100111;
	PORTB=0b00011000;
	DDRC= 0b11111011;
	PORTC=0b00000100;
	DDRD= 0b11111111;
	PORTD=0b00000000;


	clunet_init();
	clunet_set_on_data_received(data_received);
	sei();
	
	
	//while (1) {}

	uint16_t skc=0;


	for (uint8_t i=0;i<3;++i) {
	    sk_r[i]=sk_r_min[i];
	    sk_g[i]=sk_g_min[i];
	    sk_b[i]=sk_b_min[i];
	}

	uint8_t btn_cnt[3]={0,0,0};

	unsigned int cnt=0, cnt2=0;
	while (1)
	{
	    if (BUT1) {
	    	++btn_cnt[0];
	    	if (btn_cnt[0]>=BUT_CNT) btn_cnt[0]=BUT_CNT;
	    } else {
		if (btn_cnt[0]==BUT_CNT) {
		    btn_cnt[0]=0;
		    button1_event();
		}
		if (btn_cnt[0]>0) --btn_cnt[0];
	    }

	    if (BUT2) {
	    	++btn_cnt[1];
	    	if (btn_cnt[1]>=BUT_CNT) btn_cnt[1]=BUT_CNT;
	    } else {
		if (btn_cnt[1]==BUT_CNT) {
		    btn_cnt[1]=0;
		    button2_event();
		}
		if (btn_cnt[1]>0) --btn_cnt[1];
	    }

	    if (BUT3) {
	    	++btn_cnt[2];
	    	if (btn_cnt[2]>=BUT_CNT) btn_cnt[2]=BUT_CNT;
	    } else {
		if (btn_cnt[2]==BUT_CNT) {
		    btn_cnt[2]=0;
		    button3_event();
		}
		if (btn_cnt[2]>0) --btn_cnt[2];
	    }


	
	    if (skc==0) {
		if (sk_r[0]!=0) red1_on();
		if (sk_g[0]!=0) green1_on();
		if (sk_b[0]!=0) blue1_on();
		if (sk_r[1]!=0) red2_on();
		if (sk_g[1]!=0) green2_on();
		if (sk_b[1]!=0) blue2_on();
		if (sk_r[2]!=0) red3_on();
		if (sk_g[2]!=0) green3_on();
		if (sk_b[2]!=0) blue3_on();
	    }
	
	    if (skc==sk_r[0]) red1_off();
	    if (skc==sk_g[0]) green1_off();
	    if (skc==sk_b[0]) blue1_off();
	    if (skc==sk_r[1]) red2_off();
	    if (skc==sk_g[1]) green2_off();
	    if (skc==sk_b[1]) blue2_off();
	    if (skc==sk_r[2]) red3_off();
	    if (skc==sk_g[2]) green3_off();
	    if (skc==sk_b[2]) blue3_off();




	    ++cnt2;
	    if (cnt2>2500) {
		cnt2=0; ++cnt;
	    }
	    if (cnt>250) {
		for (uint8_t i=0;i<3;++i) {
	    	    if (sk_r_max[i]!=sk_r_min[i]) sk_r[i]+=sk_r_speed[i];
		    if ((sk_r[i]<=sk_r_min[i])||(sk_r[i]>=sk_r_max[i])) {sk_r_speed[i]*=-1;}
		    if (sk_g_max[i]!=sk_g_min[i]) sk_g[i]+=sk_g_speed[i];
		    if ((sk_g[i]<=sk_g_min[i])||(sk_g[i]>=sk_g_max[i])) {sk_g_speed[i]*=-1;}
		    if (sk_b_max[i]!=sk_b_min[i]) sk_b[i]+=sk_b_speed[i];
		    if ((sk_b[i]<=sk_b_min[i])||(sk_b[i]>=sk_b_max[i])) {sk_b_speed[i]*=-1;}
		}
		cnt=0;
	    }
	    ++skc;
	    if (skc>1024) skc=0;
	}
	return 0;
}

