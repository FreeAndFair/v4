Choice of MCUs
==============


Here are the popular MCUs: Atmel AVR, Microchip PIC, TI MSP430

Atmel AVR
---------

8-bit RISC (harvard architecture) MCUs, most likely the family we are interested in is the megaAVR (Atmega series).
They have a 4-256 kB program memory, 28-100-pin package, FLASH, EEPROM and SRAM. 
Wide range of interfaces: I2C, SPI, USART, A/D, programmable comparators, PWM
Speed: 0-20 Mhz (overclockable to 32 Mhz)

Due to the Arduino community, the AVRs have a huge community.

Flash memory: 4-256KB
EEPROM: 512B-4KB
CPU Speed: 1-20Mhz
Pin count: 28-100
Operation range: 1.8-5.5V@4Mhz, 2.7-5.5V@10Mhz, 4.5-5.5V@20Mhz
Power consumption at 1Mhz, 1.8V, 25C:
	- Active: 0.4mA
	- Power-down Mode: 0.1uA
	- Power-save Mode: 0.5uA (including the 32kHz RTC)


Possible candidates:
ATmega328P - 32K flash, 1KB EEPROM, 2KB SRAM, 32 pin count, 20Mhz
ATmega644PA - 64K flash, 2KB EEPROM, 4KB SRAM, 44 pin count, 20Mhz
ATmega1281 - 128K flash, 4KB EEPROM, 8KB SRAM, 64 pin count, 16Mhz
ATmega1284P - 128K flash, 4KB EEPROM, 16KB SRAM, 44 pin count, 20Mhz
ATmega2560 - 256K flash, 4KB EEPROM, 8KB SRAM, 100 pin count, 16Mhz
ATmega2561 - 256K flash, 4KB EEPROM, 8KB SRAM, 64 pin count, 20Mhz


Microchip PIC
-------------

Also 8-bit RISC MCUs, wide range of features: I2C, SPI, USB, USART, PWM, CAN, Ethernet ...
Low power, down to 35 uA/Mhz, sleep current at 20nA.
The family we are interested in is the PIC18 where the specs are:

Flash memory: 4-128KB
EEPROM: 0-1024B
RAM: 256-4096B
CPU speed: 32-64Mhz
Operation range: 1.8V - 3.6V, 2V - 5.5V
Pin count: 18-100
I/O pin count: 15-87

Possible candidates:
PIC18F8520 - 32K flash, 1K EEPROM, 2K SRAM, 80 pin count, 40Mhz
PIC18F4550 - 32K flash, 256B EEPROM, 2K SRAM, 40 pin count, 48Mhz
PIC18F87K90 - 128K flash, 1K EEPROM, 4K SRAM, 80 pin count, 64Mhz


TI MSP430
---------
16-bit MCU, top speed at 25Mhz, known as one of the most power conserving MCUs on the market. 
Features include: oscillators, timers, PWM, watchdog, USART, SPI, I2C, ADCs, BOD

Flash memory: up to 256KB
RAM: up to 16KB



Comparison
----------
TBD

-----------------------------------------------------
