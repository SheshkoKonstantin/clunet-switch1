EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:rt424f05
LIBS:switch-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L ATMEGA8A-A IC1
U 1 1 58AF3FBE
P 4800 4150
F 0 "IC1" H 4050 5350 50  0000 L BNN
F 1 "ATMEGA8A-A" H 5300 2600 50  0000 L BNN
F 2 "tqfp:TQFP-32_7x7mm_Pitch0.8mm-LUT" H 4800 4150 50  0000 C CIN
F 3 "" H 4800 4150 50  0000 C CNN
	1    4800 4150
	1    0    0    -1  
$EndComp
$Comp
L 7805 U1
U 1 1 58AF4077
P 1550 1150
F 0 "U1" H 1700 954 50  0000 C CNN
F 1 "7805" H 1550 1350 50  0000 C CNN
F 2 "tqfp:TO-220_Vertical-LM7805" H 1550 1150 50  0001 C CNN
F 3 "" H 1550 1150 50  0000 C CNN
	1    1550 1150
	1    0    0    -1  
$EndComp
$Comp
L LED_RABG D1
U 1 1 58AF44AC
P 6850 1150
F 0 "D1" H 6925 1500 50  0000 C CNN
F 1 "Led1" H 6875 800 50  0000 C CNN
F 2 "tqfp:LED_D5.0mm-4-LL" H 6800 1100 50  0001 C CNN
F 3 "" H 6800 1100 50  0000 C CNN
	1    6850 1150
	0    -1   -1   0   
$EndComp
$Comp
L CONN_01X03 P1
U 1 1 58AF4C5D
P 1200 2950
F 0 "P1" H 1200 3150 50  0000 C CNN
F 1 "12v-gnd-clunet" V 1300 2950 50  0000 C CNN
F 2 "tqfp:DG301-5.0-3x" H 1200 2950 50  0001 C CNN
F 3 "" H 1200 2950 50  0000 C CNN
	1    1200 2950
	-1   0    0    1   
$EndComp
$Comp
L Q_PNP_BEC Q1
U 1 1 58AF5191
P 7000 4750
F 0 "Q1" H 7300 4800 50  0000 R CNN
F 1 "PNP BC858" H 7600 4650 50  0000 R CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 7200 4850 50  0001 C CNN
F 3 "" H 7000 4750 50  0000 C CNN
	1    7000 4750
	1    0    0    1   
$EndComp
$Comp
L +12V #PWR01
U 1 1 58AF5615
P 1750 3400
F 0 "#PWR01" H 1750 3250 50  0001 C CNN
F 1 "+12V" H 1750 3540 50  0000 C CNN
F 2 "" H 1750 3400 50  0000 C CNN
F 3 "" H 1750 3400 50  0000 C CNN
	1    1750 3400
	1    0    0    -1  
$EndComp
$Comp
L +12V #PWR02
U 1 1 58AF5D33
P 1000 950
F 0 "#PWR02" H 1000 800 50  0001 C CNN
F 1 "+12V" H 1000 1090 50  0000 C CNN
F 2 "" H 1000 950 50  0000 C CNN
F 3 "" H 1000 950 50  0000 C CNN
	1    1000 950 
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR03
U 1 1 58AF5D6D
P 3750 1050
F 0 "#PWR03" H 3750 900 50  0001 C CNN
F 1 "VCC" H 3750 1200 50  0000 C CNN
F 2 "" H 3750 1050 50  0000 C CNN
F 3 "" H 3750 1050 50  0000 C CNN
	1    3750 1050
	1    0    0    -1  
$EndComp
$Comp
L CP C1
U 1 1 58AF5E68
P 1000 1300
F 0 "C1" H 1025 1400 50  0000 L CNN
F 1 "100mkf" H 1025 1200 50  0000 L CNN
F 2 "tqfp:TO-220_Vertical-LM7805" H 1038 1150 50  0001 C CNN
F 3 "" H 1000 1300 50  0000 C CNN
	1    1000 1300
	1    0    0    -1  
$EndComp
$Comp
L CP C2
U 1 1 58AF60CC
P 3750 1350
F 0 "C2" H 3775 1450 50  0000 L CNN
F 1 "10mkf" H 3775 1250 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 3788 1200 50  0001 C CNN
F 3 "" H 3750 1350 50  0000 C CNN
	1    3750 1350
	1    0    0    -1  
$EndComp
Text GLabel 2600 2850 2    60   Input ~ 0
clunet
$Comp
L R R5
U 1 1 58AF7C8A
P 6600 4950
F 0 "R5" V 6680 4950 50  0000 C CNN
F 1 "2.2K" V 6600 4950 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 6530 4950 50  0001 C CNN
F 3 "" H 6600 4950 50  0000 C CNN
	1    6600 4950
	0    1    1    0   
$EndComp
$Comp
L R R9
U 1 1 58AF7EE3
P 6900 4350
F 0 "R9" V 6980 4350 50  0000 C CNN
F 1 "22K" V 6900 4350 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 6830 4350 50  0001 C CNN
F 3 "" H 6900 4350 50  0000 C CNN
	1    6900 4350
	0    1    1    0   
$EndComp
$Comp
L GND #PWR04
U 1 1 58AF8170
P 7100 5050
F 0 "#PWR04" H 7100 4800 50  0001 C CNN
F 1 "GND" H 7100 4900 50  0000 C CNN
F 2 "" H 7100 5050 50  0000 C CNN
F 3 "" H 7100 5050 50  0000 C CNN
	1    7100 5050
	1    0    0    -1  
$EndComp
Text GLabel 7450 4350 2    60   Input ~ 0
clunet
$Comp
L R R10
U 1 1 58AF8C12
P 7300 4150
F 0 "R10" V 7380 4150 50  0000 C CNN
F 1 "560R" V 7300 4150 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 7230 4150 50  0001 C CNN
F 3 "" H 7300 4150 50  0000 C CNN
	1    7300 4150
	-1   0    0    1   
$EndComp
$Comp
L VCC #PWR05
U 1 1 58AF8EE9
P 7300 3900
F 0 "#PWR05" H 7300 3750 50  0001 C CNN
F 1 "VCC" H 7300 4050 50  0000 C CNN
F 2 "" H 7300 3900 50  0000 C CNN
F 3 "" H 7300 3900 50  0000 C CNN
	1    7300 3900
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR06
U 1 1 58AFBF75
P 4800 2700
F 0 "#PWR06" H 4800 2550 50  0001 C CNN
F 1 "VCC" H 4800 2850 50  0000 C CNN
F 2 "" H 4800 2700 50  0000 C CNN
F 3 "" H 4800 2700 50  0000 C CNN
	1    4800 2700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR07
U 1 1 58AFC280
P 4800 5850
F 0 "#PWR07" H 4800 5600 50  0001 C CNN
F 1 "GND" H 4800 5700 50  0000 C CNN
F 2 "" H 4800 5850 50  0000 C CNN
F 3 "" H 4800 5850 50  0000 C CNN
	1    4800 5850
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X01 P2
U 1 1 58AFE2A1
P 3600 2800
F 0 "P2" H 3600 2900 50  0000 C CNN
F 1 "Reset" V 3700 2800 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 3600 2800 50  0001 C CNN
F 3 "" H 3600 2800 50  0000 C CNN
	1    3600 2800
	0    -1   -1   0   
$EndComp
$Comp
L R R1
U 1 1 58AFE546
P 4350 2800
F 0 "R1" V 4430 2800 50  0000 C CNN
F 1 "1.5K" V 4350 2800 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 4280 2800 50  0001 C CNN
F 3 "" H 4350 2800 50  0000 C CNN
	1    4350 2800
	0    1    1    0   
$EndComp
$Comp
L SW_PUSH_SMALL_H SW2
U 1 1 58B013E5
P 5800 1150
F 0 "SW2" H 5880 1260 50  0000 C CNN
F 1 "Sw1" H 6000 1100 50  0000 C CNN
F 2 "Buttons_Switches_SMD:SW_SPST_PTS645" H 5800 1350 50  0001 C CNN
F 3 "" H 5800 1350 50  0000 C CNN
	1    5800 1150
	1    0    0    -1  
$EndComp
$Comp
L R_Small R4
U 1 1 58B027EB
P 7050 1600
F 0 "R4" V 7000 1500 50  0000 L CNN
F 1 "470R" V 7100 1500 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" H 7050 1600 50  0001 C CNN
F 3 "" H 7050 1600 50  0000 C CNN
	1    7050 1600
	1    0    0    -1  
$EndComp
$Comp
L R_Small R3
U 1 1 58B03009
P 6850 1600
F 0 "R3" V 6800 1500 50  0000 L CNN
F 1 "470R" V 6900 1500 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" H 6850 1600 50  0001 C CNN
F 3 "" H 6850 1600 50  0000 C CNN
	1    6850 1600
	1    0    0    -1  
$EndComp
$Comp
L R_Small R2
U 1 1 58B0305C
P 6650 1600
F 0 "R2" V 6600 1500 50  0000 L CNN
F 1 "470R" V 6700 1500 50  0000 L CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" H 6650 1600 50  0001 C CNN
F 3 "" H 6650 1600 50  0000 C CNN
	1    6650 1600
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR08
U 1 1 58B067B7
P 3400 3250
F 0 "#PWR08" H 3400 3100 50  0001 C CNN
F 1 "VCC" H 3400 3400 50  0000 C CNN
F 2 "" H 3400 3250 50  0000 C CNN
F 3 "" H 3400 3250 50  0000 C CNN
	1    3400 3250
	1    0    0    -1  
$EndComp
NoConn ~ 3900 3450
$Comp
L LED_RABG D2
U 1 1 58B424D9
P 8450 1150
F 0 "D2" H 8525 1500 50  0000 C CNN
F 1 "Led1" H 8475 800 50  0000 C CNN
F 2 "tqfp:LED_D5.0mm-4-LL" H 8400 1100 50  0001 C CNN
F 3 "" H 8400 1100 50  0000 C CNN
	1    8450 1150
	0    -1   -1   0   
$EndComp
$Comp
L R_Small R6
U 1 1 58B42D52
P 8250 1600
F 0 "R6" V 8200 1500 50  0000 L CNN
F 1 "470R" V 8300 1500 50  0000 L CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" H 8250 1600 50  0001 C CNN
F 3 "" H 8250 1600 50  0000 C CNN
	1    8250 1600
	1    0    0    -1  
$EndComp
$Comp
L R_Small R7
U 1 1 58B42EE7
P 8450 1600
F 0 "R7" V 8400 1500 50  0000 L CNN
F 1 "470R" V 8500 1500 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" H 8450 1600 50  0001 C CNN
F 3 "" H 8450 1600 50  0000 C CNN
	1    8450 1600
	1    0    0    -1  
$EndComp
$Comp
L R_Small R8
U 1 1 58B42F44
P 8650 1600
F 0 "R8" V 8600 1500 50  0000 L CNN
F 1 "470R" V 8700 1500 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" H 8650 1600 50  0001 C CNN
F 3 "" H 8650 1600 50  0000 C CNN
	1    8650 1600
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL_H SW1
U 1 1 58B43CA9
P 5800 900
F 0 "SW1" H 5880 1010 50  0000 C CNN
F 1 "Sw1" H 6000 850 50  0000 C CNN
F 2 "Buttons_Switches_SMD:SW_SPST_PTS645" H 5800 1100 50  0001 C CNN
F 3 "" H 5800 1100 50  0000 C CNN
	1    5800 900 
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR09
U 1 1 58B43F26
P 9100 900
F 0 "#PWR09" H 9100 650 50  0001 C CNN
F 1 "GND" H 9100 750 50  0000 C CNN
F 2 "" H 9100 900 50  0000 C CNN
F 3 "" H 9100 900 50  0000 C CNN
	1    9100 900 
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X01 P3
U 1 1 58B450CD
P 5100 2500
F 0 "P3" H 5100 2600 50  0000 C CNN
F 1 "Vcc" V 5200 2500 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x01_Pitch2.54mm" H 5100 2500 50  0001 C CNN
F 3 "" H 5100 2500 50  0000 C CNN
	1    5100 2500
	0    -1   -1   0   
$EndComp
$Comp
L CONN_01X01 P4
U 1 1 58B466F4
P 5100 6050
F 0 "P4" H 5100 6150 50  0000 C CNN
F 1 "Gnd" V 5200 6050 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x01_Pitch2.54mm" H 5100 6050 50  0001 C CNN
F 3 "" H 5100 6050 50  0000 C CNN
	1    5100 6050
	0    1    1    0   
$EndComp
$Comp
L RT424F05 K2
U 1 1 58B5204E
P 9900 4750
F 0 "K2" H 9850 5150 50  0000 C CNN
F 1 "RT424F05" H 10050 4250 50  0000 C CNN
F 2 "tqfp:RT424F05" H 9900 4750 50  0001 C CNN
F 3 "" H 9900 4750 50  0000 C CNN
	1    9900 4750
	1    0    0    -1  
$EndComp
NoConn ~ 9900 4350
NoConn ~ 9900 5150
$Comp
L RT424F05 K1
U 1 1 58B5439C
P 9800 2900
F 0 "K1" H 9750 3300 50  0000 C CNN
F 1 "RT424F05" H 9950 2400 50  0000 C CNN
F 2 "tqfp:RT424F05" H 9800 2900 50  0001 C CNN
F 3 "" H 9800 2900 50  0000 C CNN
	1    9800 2900
	1    0    0    -1  
$EndComp
NoConn ~ 9800 2500
NoConn ~ 9800 3300
Wire Wire Line
	1400 2950 1800 2950
Wire Wire Line
	1800 2950 1800 3050
Wire Wire Line
	1400 3050 1500 3050
Wire Wire Line
	1500 3050 1500 3450
Wire Wire Line
	1500 3450 1750 3450
Wire Wire Line
	1750 3450 1750 3400
Wire Wire Line
	1150 1100 1000 1100
Wire Wire Line
	1000 950  1000 1150
Connection ~ 1550 1450
Connection ~ 1000 1100
Wire Wire Line
	7100 4950 7100 5050
Wire Wire Line
	7050 4350 7450 4350
Wire Wire Line
	7100 4550 7100 4350
Connection ~ 7100 4350
Wire Wire Line
	7300 4350 7300 4300
Connection ~ 7300 4350
Wire Wire Line
	7300 4000 7300 3900
Wire Wire Line
	4750 2850 4750 2800
Wire Wire Line
	4800 2800 4800 2700
Wire Wire Line
	4850 2800 4850 2850
Connection ~ 4800 2800
Wire Wire Line
	4750 5750 4750 5800
Wire Wire Line
	4850 5800 4850 5750
Wire Wire Line
	4800 5800 4800 5850
Connection ~ 4800 5800
Wire Wire Line
	3600 3150 3900 3150
Wire Wire Line
	3600 3150 3600 3000
Connection ~ 4750 2800
Connection ~ 3800 3150
Wire Wire Line
	3900 3350 3400 3350
Wire Wire Line
	3400 3350 3400 3250
Wire Wire Line
	5100 2800 5100 2700
Connection ~ 4850 2800
Wire Wire Line
	5100 5800 5100 5850
Connection ~ 4850 5800
Wire Wire Line
	5800 4950 6450 4950
Wire Wire Line
	6750 4350 6750 4950
Wire Wire Line
	6800 4750 6750 4750
Connection ~ 6750 4750
Wire Wire Line
	10300 4350 10300 4200
Wire Wire Line
	10100 4350 10100 4200
Wire Wire Line
	10300 5150 10400 5150
Wire Wire Line
	10400 5150 10400 4200
Wire Wire Line
	10100 5150 10050 5150
Wire Wire Line
	10050 4200 10050 5250
Wire Wire Line
	10200 2500 10200 2350
Wire Wire Line
	10150 2350 10300 2350
Wire Wire Line
	10150 2150 10150 2350
Wire Wire Line
	10000 2500 10000 2350
Wire Wire Line
	9950 2350 10050 2350
Wire Wire Line
	10050 2350 10050 2050
Wire Wire Line
	10200 3300 10300 3300
Wire Wire Line
	10300 3300 10300 2350
Connection ~ 10200 2350
Wire Wire Line
	10000 3300 9950 3300
Wire Wire Line
	9950 3300 9950 2350
Connection ~ 10000 2350
$Comp
L LED_RABG D3
U 1 1 58B9F6F4
P 7650 1150
F 0 "D3" H 7725 1500 50  0000 C CNN
F 1 "Led1" H 7675 800 50  0000 C CNN
F 2 "tqfp:LED_D5.0mm-4-LL" H 7600 1100 50  0001 C CNN
F 3 "" H 7600 1100 50  0000 C CNN
	1    7650 1150
	0    -1   -1   0   
$EndComp
$Comp
L R_Small R11
U 1 1 58B9F81F
P 7450 1600
F 0 "R11" V 7400 1500 50  0000 L CNN
F 1 "470R" V 7500 1500 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" H 7450 1600 50  0001 C CNN
F 3 "" H 7450 1600 50  0000 C CNN
	1    7450 1600
	1    0    0    -1  
$EndComp
$Comp
L R_Small R12
U 1 1 58B9F8F7
P 7650 1600
F 0 "R12" V 7600 1500 50  0000 L CNN
F 1 "470R" V 7700 1500 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" H 7650 1600 50  0001 C CNN
F 3 "" H 7650 1600 50  0000 C CNN
	1    7650 1600
	1    0    0    -1  
$EndComp
$Comp
L R_Small R13
U 1 1 58B9F9A7
P 7850 1600
F 0 "R13" V 7800 1500 50  0000 L CNN
F 1 "470R" V 7900 1500 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" H 7850 1600 50  0001 C CNN
F 3 "" H 7850 1600 50  0000 C CNN
	1    7850 1600
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL_H SW3
U 1 1 58BA046B
P 5800 1400
F 0 "SW3" H 5880 1510 50  0000 C CNN
F 1 "Sw1" H 6000 1350 50  0000 C CNN
F 2 "Buttons_Switches_SMD:SW_SPST_PTS645" H 5800 1600 50  0001 C CNN
F 3 "" H 5800 1600 50  0000 C CNN
	1    5800 1400
	1    0    0    -1  
$EndComp
NoConn ~ 5800 4450
NoConn ~ 5800 4550
$Comp
L CONN_01X03 P5
U 1 1 58BA597C
P 10900 3600
F 0 "P5" H 10900 3800 50  0000 C CNN
F 1 "Load-L-F-L" V 11000 3600 50  0000 C CNN
F 2 "tqfp:DG301-5.0-3x" H 10900 3600 50  0001 C CNN
F 3 "" H 10900 3600 50  0000 C CNN
	1    10900 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	10500 4200 10500 2150
Wire Wire Line
	10500 2150 10150 2150
Connection ~ 10500 3600
Wire Wire Line
	10700 3500 10700 2050
Wire Wire Line
	10700 2050 10050 2050
Text HLabel 6650 1750 3    60   Input ~ 0
LED1_1
Text HLabel 7050 1750 3    60   Input ~ 0
LED1_2
Text HLabel 6850 1750 3    60   Input ~ 0
LED1_3
Text HLabel 7450 1750 3    60   Input ~ 0
LED2_1
Text HLabel 7650 1750 3    60   Input ~ 0
LED2_2
Text HLabel 7850 1750 3    60   Input ~ 0
LED2_3
Text HLabel 8250 1750 3    60   Input ~ 0
LED3_1
Text HLabel 8650 1750 3    60   Input ~ 0
LED3_2
Text HLabel 8450 1750 3    60   Input ~ 0
LED3_3
Text HLabel 5550 900  0    60   Input ~ 0
SW1
Text HLabel 5550 1150 0    60   Input ~ 0
SW2
Text HLabel 5550 1400 0    60   Input ~ 0
SW3
Wire Wire Line
	5550 1400 5650 1400
Wire Wire Line
	5550 1150 5650 1150
Wire Wire Line
	5550 900  5650 900 
Wire Wire Line
	8650 1500 8650 1450
Wire Wire Line
	8250 1500 8250 1450
Wire Wire Line
	8250 1750 8250 1700
Wire Wire Line
	7850 1500 7850 1450
Wire Wire Line
	7650 1500 7650 1450
Wire Wire Line
	7450 1500 7450 1450
Wire Wire Line
	7450 1750 7450 1700
Wire Wire Line
	7650 1750 7650 1700
Wire Wire Line
	7850 1750 7850 1700
Wire Wire Line
	7050 1500 7050 1450
Wire Wire Line
	6850 1500 6850 1450
Wire Wire Line
	6650 1500 6650 1450
Wire Wire Line
	6650 1750 6650 1700
Wire Wire Line
	6850 850  6850 750 
Wire Wire Line
	6250 750  9100 750 
Wire Wire Line
	9100 750  9100 900 
Wire Wire Line
	8450 850  8450 750 
Connection ~ 8450 750 
Wire Wire Line
	7650 850  7650 750 
Connection ~ 7650 750 
Wire Wire Line
	6250 750  6250 1400
Wire Wire Line
	6250 1400 5950 1400
Connection ~ 6850 750 
Wire Wire Line
	5950 1150 6250 1150
Connection ~ 6250 1150
Wire Wire Line
	5950 900  6250 900 
Connection ~ 6250 900 
Text HLabel 6850 3650 2    60   Input ~ 0
LED2_1
Text HLabel 5950 3850 2    60   Input ~ 0
LED2_2
Text HLabel 5950 3950 2    60   Input ~ 0
LED2_3
Text HLabel 5950 3350 2    60   Input ~ 0
LED1_1
Text HLabel 5950 3250 2    60   Input ~ 0
LED1_2
Text HLabel 5950 3150 2    60   Input ~ 0
LED1_3
Text HLabel 6900 3450 2    60   Input ~ 0
SW1
Text HLabel 6850 3550 2    60   Input ~ 0
SW2
Text HLabel 5950 4150 2    60   Input ~ 0
LED3_1
Text HLabel 5950 4250 2    60   Input ~ 0
LED3_2
Text HLabel 5950 4350 2    60   Input ~ 0
LED3_3
Text HLabel 5950 4050 2    60   Input ~ 0
SW3
Wire Wire Line
	5800 3650 6850 3650
Wire Wire Line
	5800 3550 6850 3550
Wire Wire Line
	5800 3450 6900 3450
Wire Wire Line
	6750 3000 6750 3650
Connection ~ 6750 3650
Wire Wire Line
	6650 3150 6650 3550
Connection ~ 6650 3550
Wire Wire Line
	6550 3300 6550 3450
Connection ~ 6550 3450
Wire Wire Line
	5800 3850 5950 3850
Wire Wire Line
	5800 3950 5950 3950
Text HLabel 5950 5250 2    60   Input ~ 0
R2_1
Text HLabel 3750 4050 0    60   Input ~ 0
R2_2
Text HLabel 5950 5450 2    60   Input ~ 0
R1_1
Text HLabel 5950 5350 2    60   Input ~ 0
R1_2
NoConn ~ 5800 5150
NoConn ~ 5800 5050
$Comp
L CONN_01X02 P11
U 1 1 58BE0A92
P 3450 5900
F 0 "P11" H 3450 6050 50  0000 C CNN
F 1 "R1_" V 3550 5900 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x02_Pitch2.54mm" H 3450 5900 50  0001 C CNN
F 3 "" H 3450 5900 50  0000 C CNN
	1    3450 5900
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X02 P13
U 1 1 58BE22FA
P 8800 2900
F 0 "P13" H 8800 3050 50  0000 C CNN
F 1 "R1_" V 8900 2900 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x02_Pitch2.54mm" H 8800 2900 50  0001 C CNN
F 3 "" H 8800 2900 50  0000 C CNN
	1    8800 2900
	-1   0    0    1   
$EndComp
Wire Wire Line
	9000 2950 9000 3100
Wire Wire Line
	9000 2850 9000 2700
Text HLabel 1750 5950 0    60   Input ~ 0
R1_2
Text HLabel 1750 5850 0    60   Input ~ 0
R1_1
$Comp
L CONN_01X02 P14
U 1 1 58BE4B5E
P 8850 4750
F 0 "P14" H 8850 4900 50  0000 C CNN
F 1 "R2_" V 8950 4750 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x02_Pitch2.54mm" H 8850 4750 50  0001 C CNN
F 3 "" H 8850 4750 50  0000 C CNN
	1    8850 4750
	-1   0    0    1   
$EndComp
Wire Wire Line
	9050 4800 9050 4950
Wire Wire Line
	9050 4950 9300 4950
Wire Wire Line
	9050 4700 9050 4550
Wire Wire Line
	9050 4550 9300 4550
$Comp
L CONN_01X02 P12
U 1 1 58BE5403
P 3700 6100
F 0 "P12" H 3700 6250 50  0000 C CNN
F 1 "R2_" V 3800 6100 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x02_Pitch2.54mm" H 3700 6100 50  0001 C CNN
F 3 "" H 3700 6100 50  0000 C CNN
	1    3700 6100
	1    0    0    -1  
$EndComp
Text HLabel 1750 6150 0    60   Input ~ 0
R2_2
Text HLabel 1750 6050 0    60   Input ~ 0
R2_1
Wire Wire Line
	9000 3100 9200 3100
Wire Wire Line
	9000 2700 9200 2700
Wire Wire Line
	10300 4200 10500 4200
Connection ~ 10400 4200
Wire Wire Line
	10500 3600 10700 3600
Wire Wire Line
	10100 4200 10050 4200
Wire Wire Line
	10050 5250 10600 5250
Wire Wire Line
	10600 5250 10600 3700
Wire Wire Line
	10600 3700 10700 3700
Connection ~ 10050 5150
$Comp
L CONN_01X01 P6
U 1 1 58BF40AA
P 1900 2850
F 0 "P6" H 1900 2950 50  0000 C CNN
F 1 "Clunet" V 2000 2850 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x01_Pitch2.54mm" H 1900 2850 50  0001 C CNN
F 3 "" H 1900 2850 50  0000 C CNN
	1    1900 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 2850 1700 2850
$Comp
L CONN_01X01 P7
U 1 1 58BF43F3
P 2200 2850
F 0 "P7" H 2200 2950 50  0000 C CNN
F 1 "Clunet" V 2300 2850 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x01_Pitch2.54mm" H 2200 2850 50  0001 C CNN
F 3 "" H 2200 2850 50  0000 C CNN
	1    2200 2850
	-1   0    0    1   
$EndComp
Wire Wire Line
	2400 2850 2600 2850
$Comp
L C_Small C5
U 1 1 58BFA9D1
P 4100 1400
F 0 "C5" H 4110 1470 50  0000 L CNN
F 1 "C_Small" H 4110 1320 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 4100 1400 50  0001 C CNN
F 3 "" H 4100 1400 50  0000 C CNN
	1    4100 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 1050 3750 1200
Wire Wire Line
	4100 1150 4100 1300
Connection ~ 3750 1150
Wire Wire Line
	3750 1150 4100 1150
Wire Wire Line
	3750 1500 4100 1500
$Comp
L GND #PWR010
U 1 1 58BFDCE3
P 3900 1550
F 0 "#PWR010" H 3900 1300 50  0001 C CNN
F 1 "GND" H 3900 1400 50  0000 C CNN
F 2 "" H 3900 1550 50  0000 C CNN
F 3 "" H 3900 1550 50  0000 C CNN
	1    3900 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 1550 3900 1500
Connection ~ 3900 1500
$Comp
L CONN_01X01 P9
U 1 1 58BFE3A9
P 2250 1100
F 0 "P9" H 2250 1200 50  0000 C CNN
F 1 "Vcc" V 2350 1100 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x01_Pitch2.54mm" H 2250 1100 50  0001 C CNN
F 3 "" H 2250 1100 50  0000 C CNN
	1    2250 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 1100 2050 1100
$Comp
L CONN_01X01 P10
U 1 1 58BFEA1B
P 2250 1450
F 0 "P10" H 2250 1550 50  0000 C CNN
F 1 "Gnd" V 2350 1450 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x01_Pitch2.54mm" H 2250 1450 50  0001 C CNN
F 3 "" H 2250 1450 50  0000 C CNN
	1    2250 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	1000 1450 2050 1450
$Comp
L GNDA #PWR011
U 1 1 58C05075
P 1550 1500
F 0 "#PWR011" H 1550 1250 50  0001 C CNN
F 1 "GNDA" H 1550 1350 50  0000 C CNN
F 2 "" H 1550 1500 50  0000 C CNN
F 3 "" H 1550 1500 50  0000 C CNN
	1    1550 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	1550 1400 1550 1500
Wire Wire Line
	9000 3800 9200 3800
Wire Wire Line
	9200 2900 9200 4750
Wire Wire Line
	9200 4750 9300 4750
Connection ~ 9200 3800
$Comp
L CONN_01X01 P8
U 1 1 58BB0513
P 6550 3100
F 0 "P8" H 6550 3200 50  0000 C CNN
F 1 "CON_MOS" V 6650 3100 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 6550 3100 50  0001 C CNN
F 3 "" H 6550 3100 50  0000 C CNN
	1    6550 3100
	0    -1   -1   0   
$EndComp
$Comp
L CONN_01X01 P15
U 1 1 58BB05CC
P 6650 2950
F 0 "P15" H 6650 3050 50  0000 C CNN
F 1 "CON_MIS" V 6750 2950 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 6650 2950 50  0001 C CNN
F 3 "" H 6650 2950 50  0000 C CNN
	1    6650 2950
	0    -1   -1   0   
$EndComp
$Comp
L CONN_01X01 P16
U 1 1 58BB066D
P 6750 2800
F 0 "P16" H 6750 2900 50  0000 C CNN
F 1 "CON_SCK" V 6850 2800 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 6750 2800 50  0001 C CNN
F 3 "" H 6750 2800 50  0000 C CNN
	1    6750 2800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5800 4050 5950 4050
Wire Wire Line
	5800 4150 5950 4150
Wire Wire Line
	5800 4250 5950 4250
Wire Wire Line
	5950 4350 5800 4350
$Comp
L GND #PWR012
U 1 1 58BB692C
P 3650 3600
F 0 "#PWR012" H 3650 3350 50  0001 C CNN
F 1 "GND" H 3650 3450 50  0000 C CNN
F 2 "" H 3650 3600 50  0000 C CNN
F 3 "" H 3650 3600 50  0000 C CNN
	1    3650 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 3550 3650 3550
Wire Wire Line
	3650 3550 3650 3600
Wire Wire Line
	7050 1750 7050 1700
Wire Wire Line
	6850 1750 6850 1700
Wire Wire Line
	5800 3150 5950 3150
Wire Wire Line
	5800 3250 5950 3250
Wire Wire Line
	5800 3350 5950 3350
Wire Wire Line
	8450 1500 8450 1450
Wire Wire Line
	8450 1750 8450 1700
Wire Wire Line
	8650 1750 8650 1700
$Comp
L CONN_01X01 P17
U 1 1 58BC6FA9
P 5350 2500
F 0 "P17" H 5350 2600 50  0000 C CNN
F 1 "Vcc_Prog" V 5450 2500 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 5350 2500 50  0001 C CNN
F 3 "" H 5350 2500 50  0000 C CNN
	1    5350 2500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5350 2800 5350 2700
Connection ~ 5100 2800
$Comp
L CONN_01X01 P18
U 1 1 58BC7825
P 5350 6050
F 0 "P18" H 5350 6150 50  0000 C CNN
F 1 "Gnd_Prog" V 5450 6050 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 5350 6050 50  0001 C CNN
F 3 "" H 5350 6050 50  0000 C CNN
	1    5350 6050
	0    1    1    0   
$EndComp
Wire Wire Line
	5350 5800 5350 5850
Connection ~ 5100 5800
$Comp
L GNDA #PWR013
U 1 1 58BCFFEC
P 1800 3050
F 0 "#PWR013" H 1800 2800 50  0001 C CNN
F 1 "GNDA" H 1800 2900 50  0000 C CNN
F 2 "" H 1800 3050 50  0000 C CNN
F 3 "" H 1800 3050 50  0000 C CNN
	1    1800 3050
	1    0    0    -1  
$EndComp
Connection ~ 5350 5800
Connection ~ 5350 2800
Wire Wire Line
	4500 2800 5600 2800
Wire Wire Line
	4750 5800 5350 5800
Wire Wire Line
	1750 6050 1850 6050
Wire Wire Line
	1750 6150 1850 6150
Wire Wire Line
	3150 5850 3250 5850
Wire Wire Line
	3150 5950 3250 5950
Wire Wire Line
	3150 6050 3500 6050
Wire Wire Line
	3150 6150 3500 6150
NoConn ~ 1850 6350
NoConn ~ 1850 6250
NoConn ~ 3150 6250
NoConn ~ 3150 6350
$Comp
L GND #PWR014
U 1 1 58CDC305
P 1650 6850
F 0 "#PWR014" H 1650 6600 50  0001 C CNN
F 1 "GND" H 1650 6700 50  0000 C CNN
F 2 "" H 1650 6850 50  0000 C CNN
F 3 "" H 1650 6850 50  0000 C CNN
	1    1650 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 6650 1650 6650
Wire Wire Line
	1650 6650 1650 6850
$Comp
L VCC #PWR015
U 1 1 58CDF021
P 4850 6500
F 0 "#PWR015" H 4850 6350 50  0001 C CNN
F 1 "VCC" H 4850 6650 50  0000 C CNN
F 2 "" H 4850 6500 50  0000 C CNN
F 3 "" H 4850 6500 50  0000 C CNN
	1    4850 6500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3150 6650 4850 6650
Wire Wire Line
	3750 4050 3900 4050
NoConn ~ 5800 4750
NoConn ~ 5800 4850
Wire Wire Line
	1850 5950 1750 5950
Wire Wire Line
	1750 5850 1850 5850
Wire Wire Line
	3800 3150 3800 2800
Wire Wire Line
	3800 2800 4200 2800
Wire Wire Line
	5800 5250 5950 5250
Wire Wire Line
	5800 5350 5950 5350
Wire Wire Line
	5800 5450 5950 5450
Text HLabel 3750 3850 0    60   Input ~ 0
spk
Wire Wire Line
	3750 3850 3900 3850
Text HLabel 1700 6450 0    60   Input ~ 0
spk
$Comp
L CONN_01X02 P19
U 1 1 58D096C1
P 3850 6500
F 0 "P19" H 3850 6650 50  0000 C CNN
F 1 "SPK" V 3950 6500 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x02_Pitch2.54mm" H 3850 6500 50  0001 C CNN
F 3 "" H 3850 6500 50  0000 C CNN
	1    3850 6500
	1    0    0    -1  
$EndComp
$Comp
L ULN2003-norm U2
U 1 1 58CDBCFE
P 2500 6250
F 0 "U2" H 2500 6350 50  0000 C CNN
F 1 "ULN2003-norm" H 2500 6150 50  0000 C CNN
F 2 "SMD_Packages:SO-16-N" H 2500 6250 50  0001 C CNN
F 3 "" H 2500 6250 50  0000 C CNN
	1    2500 6250
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 6450 1850 6450
Connection ~ 3550 6650
Wire Wire Line
	3550 6650 3550 6550
Wire Wire Line
	3550 6550 3650 6550
Wire Wire Line
	3650 6450 3150 6450
$Comp
L CONN_01X02 P20
U 1 1 58D0B5D3
P 4150 6500
F 0 "P20" H 4150 6650 50  0000 C CNN
F 1 "SPK" V 4250 6500 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x02_Pitch2.54mm" H 4150 6500 50  0001 C CNN
F 3 "" H 4150 6500 50  0000 C CNN
	1    4150 6500
	-1   0    0    1   
$EndComp
NoConn ~ 4350 6450
$Comp
L +5V #PWR016
U 1 1 58D11E47
P 2000 900
F 0 "#PWR016" H 2000 750 50  0001 C CNN
F 1 "+5V" H 2000 1040 50  0000 C CNN
F 2 "" H 2000 900 50  0000 C CNN
F 3 "" H 2000 900 50  0000 C CNN
	1    2000 900 
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 1100 2000 900 
Connection ~ 2000 1100
$Comp
L +5V #PWR017
U 1 1 58D1392D
P 9000 3700
F 0 "#PWR017" H 9000 3550 50  0001 C CNN
F 1 "+5V" H 9000 3840 50  0000 C CNN
F 2 "" H 9000 3700 50  0000 C CNN
F 3 "" H 9000 3700 50  0000 C CNN
	1    9000 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	9000 3800 9000 3700
$Comp
L +5V #PWR?
U 1 1 58D1702F
P 4600 6500
F 0 "#PWR?" H 4600 6350 50  0001 C CNN
F 1 "+5V" H 4600 6640 50  0000 C CNN
F 2 "" H 4600 6500 50  0000 C CNN
F 3 "" H 4600 6500 50  0000 C CNN
	1    4600 6500
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 6650 4850 6500
Wire Wire Line
	4350 6550 4600 6550
Wire Wire Line
	4600 6550 4600 6500
$EndSCHEMATC
