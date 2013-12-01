V4 - First Prototype Hardware Foundation
==================================

**Author**: Attila Sukosd (attila@demtech.dk / s070600@student.dtu.dk)

**Supervisor**: Joseph R. Kiniry 

![V4 Hardware prototype v1](https://raw.github.com/demtech/v4/master/hardware/images/v4-atmega1284p-1-small.png)


Abstract
--------

The following document presents an alternate in-booth electronic voting hardware  (ballot) which can replace 
the traditional paper ballots with a hybrid version with the hopes of reducing the number of "spoiled" ballots, 
providing a solution that disabled can use without intrusion on their privacy, and finally providing also a digital
count that could used to verify the results of a manual count.

The aim of the report is to give the reader an insight into the choices made by the authors with regards 
to technologies and solutions and to bootstrap them into getting up and running with the V4 hardware platform. 

Motivation
----------

The motivation behind this work originates from Joseph. He has thought of a system which can solve 
a number of issues relating to the existing paper ballot system, while provide a more secure, 
easy to use and understand solution which can be integrated into the existing election workflow without
too much effort.

Problem Formulation
-------------------

To participate in an election in Denmark today, a voter has to do the following:

1. Go to their designated polling place
2. Identify him/herself with a voter card
3. Pick up a paper ballot
4. Go into a private booth
5. Using a pen, mark the ballot to indicate their vote
6. Fold the ballot to hide their vote
7. Exit the polling booth
8. Put their complete ballot into an opaque, sealed box
9. Exit the polling place

The ballot iteself is a sheet of white paper, printed with black ink. The
size of the paper depends on the number of candidates, so recently it has
been at least an A3 page. There have been cases where this ballot has reached
around a meter in lengh due to the large number of candidates and parties.

The parties are listed in a random order, and the candidates belonging to
each party is listed under the party. The ordering of candidates under a party
is determined by the party itself.

In order for a ballot to be considered valid, the voter must put a clear mark
next to their desired party or candidate. There are a number of strict and
complex rules on what counts as a valid ballot and what does not, including
the location and kind of marks, smudges, etc.

Every year, there are thousands of spoiled ballots (cite?) which could easily
affect the outcome of the election.

Asside from the spoiled ballots, there are a number of other problems with the
existing paper ballot solution:

* Many of the disabled people do not have the possibility to vote in secrecy
  (as required by law), because they are in need of assistance from two
  electoral assistants. 

* The counting of the paper ballots in done manually, which is slow and
  error-prone. Published error rates for the counting process are around
  0.1% to 1%.
  
  
The following work was done to evaluate an alternate "hybrid" solution,
which could be integrated into the existing voting workflow, while improving
the ease of use, accuracy, security and keeping the complexity as low as
possible.

The goal was to mimic the paper ballot as much as possible, while providing additional
features which allow the disabled to vote privately, a digital count to occur so 
the analog counting could be verified, and reduce the number of spoiled ballots.

The electronic ballots should produce a paper output which can be visually verified by
the voter that their vote has not been manipulated, and should also provide a way for
digitally verifying the correctness of the manually counted ballots.

At this stage, the main focus is on creating a hardware platform suitable for the research
and development of the software for the e-ballot, eventually to be used at a test run for e-voting.


General Design Principles
-------------------------

In an ideal world, all parts of the system should be formally verified,
from the highest level programming down to the hardware design. That way
there is a fundament to argue for the correctness of the system as a whole.

One of the goals of the project was to reduce the amount of components
which can not be formally verified to the least possible number, which also meant
not using operating systems and/or libraries which were too complex to
fulfill this requirement.

In order to have an idea on what the V4 hardware should include
a number of functional and non-functional requirements were specified:

### Non-functional requirements
* It should be possible to operate the device without any external assistance
  regardless of disability
* The device should be responsive (less than 3 seconds of reaction) to be user
  friendly.
* The device should be operational within 3 seconds from supplying power.
* The device should live up to all non-functional requirements derived from existing
  national and international laws, guidelines and best practices.
* The price of the device should be below 1000 DKK.
* The work done by the device should be understandable by everyone
* The design of the device should be robust.
* The device should be able to replace a paper ballot in the voting booth in a secure manner
* It should produce a paper ballot which can fit into the existing workflow
* The device should aim at a simplistic approach
* The device should be cheap and accessible enough to be reproducible by wide audience
  

### Functional requirements
* The device hardware should be modular to make maintenance and upgrades simple.
* The device should be a simple design (2-layer PCB), simple components so it can
  be visually inspected.
* The device should be able to interface with a large number of inputs (120+ buttons)
* The device should be able to interface with external printers
* The device power consumption should be low (<100mA) in order to be able to operate
  from battery for up to 10 hours.
* The device should have no operating system
* The (8-bit) MCU should have enough resources to accommodate an embedded JVM (~15-20KB) + application code (~10-100KB)
* The software should be formally verified
* The hardware and software designs should be published under an open-source license
* There should be no RF leakage, which could be used to invalidate the voters’ privacy
* The printer in the device should print ASCII text, optionally support printing graphics (such as barcodes, QR code, etc)

During the hardware design a number of quality attributes need to be addresses, from accessibility/usability to portability, robustness,
security, safety, availibility and maintainability. 


Hardware considerations
-----------------------

The V4 hardware consists of a number of components. The electronics is a large part of it, but also the physical design
of the hardware needs to be considered. In this work most of the focus was placed on the electronics, but some proof of concept
3d design was also done to see how feasable would be to do it.

### Electronics

To get an overview of what parts are present in the system, it's worth looking at the following diagram:

![Overview of the components in the V4 hardware](https://raw.github.com/demtech/v4/master/hardware/images/v4-overview.png)

It can be seen that there is a "compute node" which is the V4 CPU board with the system-on-chip, and additional components needed
for the system to operate. There are a number of "button nodes" which are connected to the compute node over a bus. The button
nodes are dynamic, so they can be exchanged and reconfigured to suit the exact use-case. Since the number of candidates vary a lot
the modular design allows for expansion of the ballot easily.

Finally, an external printer is used to produce a paper ballot. 
Throughout this section the inner workings on the "compute node" and the "button node" will be described.

#### PCB

The pcb design was done in an open source PCB designer software called [KiCad][19].
At the point of writing, the latest version of Kicad was compile from source and used. (Build: 2013-11-29 BZR4513)

![V4 PCB layout](https://raw.github.com/demtech/v4/master/hardware/images/v4-pcblayout-small.png)

As it can be seen above, the PCB layout has been kept as simple as possible. The PCB itself is a 2-layer one, following
our requirements, with large, clearly visible traces which can be inspected without any external aid.

The components are also through-hole (PDIP) to make the hobby prototyping as easy as possible. The hardware went through
a number of revisions where small problems were corrected, new features were added and the routing of traces were optimized.

All traces seen on the prototype have been routed manually as the auto-routers tried were not able to provide an acceptable
result.

Since the "virtual" components on the schematics are assigned physical footprints in the designer program, it is possible to 
exchange the footprints from the current "hobbyist" setup to small surface mount components which would be easier and cheaper
to mass produce. An advantage of doing it this way is that the testing of the hardware can be done on larger components, making
it easier to work with, and the size and price of the finished product can be optimized at a later stage without having to change
or re-do the schematics.

#### MCU/SOC

The perfect selection of a SoC would be one which could fulfill all the requirements
below, and at the same time all the hardware was formally verified, so the correctness
of the implementation can be verified.

However, to our knowledge there isn't an affortable chip which would suit our purpose,
and while it would be possible to design and implement a formally verified SoC on an
FPGA, the mass production of ASICs would be prohibitively expnsive. 
Instead, popular (hobby) SoCs were investigated, as they are produced in large quantities,
are available virtually everywhere for a low price point, and there are huge communities
working on them, so support and knowledge about them are readily available.

In order to investigate what is out there, and what would fit the purpose best, a number of
additional requirements to the SoC were specified:

* The CPU should be 8-bit
* The CPU should be fast enough to do encryption (16+ Mhz)
* It should have a well defined, and relatively simple instruction set.
* It should have at least 8 KB memory
* It should have at least 128 KB flash
* The power consumption should be less than 100mA
* There should be both a PDIP version and a TSOIC version
* The chip should cost less than 80 DKK
* There should be some security built into it to protect the flash
* It should be from a large producent so having "tainted" batches would be less likely.
* There should be a software simulator for the architecture


Looking through the popular, low cost SoCs, three popular brands were highlighted:

* Atmel's AVR ATmega
* Microchip's PIC
* Texas Instrument's MSP


An overview of their offerings can be seen here:

|  Chip name    |      CPU Speed    |     Flash    |    EEPROM   |      RAM     |     Pin Count   |
|:-------------:|:-----------------:|:------------:|:-----------:|:------------:|:---------------:|
|   ATmega328P  |       1-20Mhz     |     32K      |     1KB     |      2KB     |         32      |
|   ATmega644PA |       1-20Mhz     |     64K      |     2KB     |      4KB     |         44      |
|   ATmega1281  |       1-16Mhz     |    128K      |     4KB     |      8KB     |         64      |
|   ATmega1284P |       1-20Mhz     |    128K      |     4KB     |     16KB     |         44      |
|   ATmega2560  |       1-20Mhz     |    256K      |     4KB     |      8KB     |         100     |
|   ATmega2561  |       1-20Mhz     |    256K      |     4KB     |      8KB     |         64      |
|   PIC18F8520  |       1-40Mhz     |     32K      |     1KB     |      2KB     |         80      |
|   PIC18F4550  |       1-48Mhz     |     32K      |    256B     |      2KB     |         40      |
|   PIC18F87K90 |       1-64Mhz     |    128K      |     1KB     |      4KB     |         80      |
|   TI MSP430   |       1-25Mhz     |    256K      |     ---     |     16KB     |        10-87    |

##### Atmel AVR

The AVR is an 8-bit RISC (harvard architecture) MCU. They have a number of different families,
but the more interesting for this puprose is the ATmega family. It is capable of running up to 20Mhz,
though people have been reportedly overclocking it to up to 40Mhz with varied success. The datasheet states
that due to the powerful instruction set, where most of the instructions can execute in a single clock cycle,
the SoC is capable of achieving close to 1 MIPs (millions of instructions per second) per MHz.

It can be bought in a number of different physical packaging, both in a 'hacker friendly' through-hole PDIP,
and in an SMD TSOIC. It boasts a large number of features, ranging from I2C, SPI, UART, A/D to programmable
comparators and PWM.

The operational range is from 1.8V to 5.5V at 4Mhz, 2.7V to 5.5V at 10Mhz, and 4.5V to 5.5V at 20+ Mhz, while
the active power consumption is around 10mA at 20Mhz.

There is also a number of power saving features, which could allow the CPU to transition into a sleep or a deep
power-down state, where the power usage is reduced to micro amps, while the CPU could be woken up by a timer or
an external interrupt on one of the GPIO pins.

There are also a number of security features built into the chip in terms of flash protection. By programming the
"FUSES" (special memory for configuration), it is possible to restrict access to certain parts of the flash by
locking them for either reading or reading and writing (in certain chips).

The AVR has a huge community around it, as it is also used as the basis for the popular Arduino development boards.
This gives it an edge compared to the other two, less widespread ones in terms of community support, and thus 
variety of available tools.

There are also a number of (open source) AVR simulators available online, such as 
"avr_simulator", "avrsim", "simavr", and "simulavr".

##### Microchip PIC

The PIC is the direct competitor to AVR. It has similar features compared to
the others, both in terms of functionality and security. It is also an 8-bit RISC MCU

Looking at the overview of the selected chips, it can be seen that the PIC chips
have a higher clock frequency, which is an advantage in doing heavier computational
operations, such as encryption, however they are limited by the amount of
memory available.

The overall power usage is rated a bit below the AVR, with the sleep mode going down
to a couple of nano-amps.

There are also a number of tools available for simulating the PIC MCU, such as 
"PICsim", "gpsim", "Real Pic Simulator" and others.

##### Texas Instruments MSP430

The MSP430 is an ultra low power 16-bit MCU by Texas Instruments. It has similar specifications as the
two other, however at the time of checking in terms of pricing, tool availability and community, 
it could not compete with the other two.

##### MCU choice

Based on the study above, there isn't a clear winner, as each of them has their
advantages and disadvangates, so in the end the [AVR ATmega1284P][5] was chosen. 
This was due to the superior documentation, resources and community available online, 
the amount of RAM and EEPROM, and the fact that it has a physical package which can
be used to prototype better.


#### Supporting components

In order for the MCU to function, a number of supporting components are needed.
By looking a the datasheet, it is possible to find a reference design.

Furthermore, AVR provides a '[hardware design considerations][18]' document
which details how the power supply should be designed with decoupling capacitors,
the connection of the reset signal, and the in circuit programming lines.

There is also a section on choosing the best external crystal and the capacitors
to provide the optimal frequency and stability to the MCU. 

![Supporting crystal and capacitors, and reset connection](https://raw.github.com/demtech/v4/master/hardware/images/v4-crystal-and-reset.png)


The power decoupling is quite important, as the fast switching CPU can 'wriggle' the
power supply, which can cause stability problems, especially when used together with the
brown-out detection. It is done by inserting decoupling capacitors between the Vcc and the
ground, as close to the chip as possible, to "buffer" enough charge.

The brown-out detection is a component inside the SoC, which detects when the supply
voltage goes below a certain limit, and keeps the CPU in a reset mode until the power
is restored. This is needed as it can result in memory and flash corruption if the voltage
is not enough to write into the memory cells.

### ISP

ISP stands for In-System Programming, which allows the (re)programming of the device,
after the chip has been mounted on the PCB. This port is vital to have in the prototyping phase,
as it makes the testing of new code much easier than having to remove the chip for each reprogramming.

The interface consists of three SPI lines (MOSI,MISO,SCK), a reset line (RESET), ground (GND) and power supply (Vcc).
The three SPI lines are the Master Out-Slave In (MOSI), the Master In-Slave Out (MISO), and the Serial ClocK (SCK).
When programming, the in-system programmer always acts as an SPI master, and the MCU acts as an SPI slave.
The clock for the communication is supplied on the SCK, so each pulse on the clock corresponds to 1 bit transfered from
the master to the slave, and simultaniously one bit transfered from the target back to the master.

In the early programmers, the reset line to the CPU was not exposed, so the user had to manually reset the target before
programming, which included some timing acrobatics to get right. In most of the new programmers, the reset line is
automatically controlled by the in-circuit programmer.

[AVR has published an application note][1] on how to the ISP works as well as some design guides on how to
implement it on the PCB.

For the V4 hardware, a full, standard ISP connector has been exposed, so it is compatible with most programmers.
It has been tested with an USPASP programmer.

![ISP 10-pin header](http://www.batsocks.co.uk/img/info_isp/ISP%2010%20way%20pinout.png)


#### RS232

RS232 is a serial communications standard. It has been chosed to be used in conjunction with a serial printer,
as the aim was to keep the complexity of the printer to the minimum too.

The AVR has a hardware UART (Universal Asynchronous Receiver/Transmitter), which basically handles serial transmission
in the hardware, so there is no need to bit-bang the GPIOs. This frees up the CPU for other tasks such as crypto.
The interface with the UART hardware consists of a number of registers, which can tell the state of the port,
configure the port, and also a data register which can be read or written to. When a byte arrives and the UART hardware
has buffered it into the register, an interrupt is fired off which allows the user application to read out the byte.

Since the MCU works at TTL levels (0 to +5V), and RS232's valid signals range from (+3 to +15V or -3 to -15V), a special
intervening driver circuit is required to translate logic levels. For this the [MAX232][2] is used.
 
![MAX232 TTL-RS232 level shifting](https://raw.github.com/demtech/v4/master/hardware/images/v4-uart.png)


The MAX232 has been around for a while, and a number of updated versions exist. These variations reduce the size of the
capacitors needed, or even remove the need for them all together, so in a future work, it would make sense to look
into the new version of this chip to decrease the parts count.

#### External memory

The inital plan was to use the built in device EEPROM for logging, however none of the MCUs offered 
enough space to store larger amount of data, so a closer look was taken at the different storage 
technologies available.

The options were as follows:

1. Try to limit the storage needs to the EEPROM size (1-2KB space at max)
2. Store in the existing flash of the microcontroller (16-256KB space depending on the application size)
3. Add an extra flash/eeprom over I2C or SPI (512B - 32+ MB)
4. Add an SD/MMC memory card (64MB to 32GB)

Option 1 was out of the question as the space requirements were bigger than what the EEPROM would allow for.
Storing in the MCU's flash is not advisable for two reasons:

1. Decreases the lifetime of the flash
2. If not done properly, corrupting the application code is possible

Having an SD/MMC memory card could have also been an option, but it introduces a number of possible failure points,
such as incompatibility of some SD cards, the mechanical connection between the card and the PCB, etc.

So in the end, the decision was made to use an external flash over the SPI bus. After looking at possible candidates,
the AT45DB161D seemed like the right choice. It is an external "DataFlash" from ATMEL, has a low power consumption 
(7mA in active state, 25 microamps in standby), a long lifetime (data retention 20 years, 100,000 program/erase cycles per page), 
built in security features, and has 4096 pages of 528 bytes each, adding up to 16 Mbits of storage. More information
on the chip can be found it it's [datasheet][3].

![External flash for storage](https://raw.github.com/demtech/v4/master/hardware/images/v4-externalflash.png)

The external flash chip shares the SPI bus with the ISP header, but it has a separate chip-select, so reprogramming the
MCU has no effect on the flash. The MCU also has a hardware SPI port, so it can communicate with the flash chip with ease,
without the need of bit-banging the interface.

#### Button matrix

In the requirements it was stated that a large number of buttons need to be interfaced. In order to do that, a number of methods
were studied. It was obvious that connecting one button per GPIO pin would be a massive waste of I/O ports which would not be
sustainable, so other solutions were needed.

##### Multiplexing buttons

A traditional approach to button matrices is to multiplex the buttons. The solution consists of a number of driver pins, which can be
selected by the software, and a number of sink pins, which read in the values of the switches.
This way it is possible to use 2*N number of I/O pins for an N*N button matrix. 

Using a 1-of-n decoder chip, such as the [HEF4514B][4], the number of I/O pins required can be reduced to n + (log_2 n).

##### Charlieplexing buttons

Charlieplexing is another method of connecting the buttons, which reduce the number of pins needed to N for an N*N button matrix, 
but requires extra diodes to work.

It is also considered "lossy" as it can only detect a single button press at the same time reliably in the whole matrix.

##### 1-wire button matrix

An alternate to dealing with buttons directly is to use a bus where multiple devices could be attached, and each would collect the inputs
from the buttons. This is a more modular and scalable approach, as the number of buttons do not directly constrain the choice of MCU.

One such IC is the [DS2408][4] which is a 1-wire 8-channel addressable switch. The disadvantage of this solution is that the 1-wire
protocol is slower than I2C, and there is no hardware controller available in the MCU, so the protocol needs to be bit-banged. 
The 1-wire interface is also patent protected, so there might be some issues relating to it, and could explain why it hasn't been as
widespread as I2C, at least in the hobby electronics community.

##### I2C button matrix

I2C is a two-wire serial bus, consists of a data line (SDA) and a clock line (SCL). The data is sent on the rising edge of the clock signal.
It can handle up to 127 unique devices as it has a 7-bit address space.

Since the I2C driver circuitry is built into the MCU, the only extra components it needs is two 4.7kOhm pull-up resistors on the
two wires. The bus speed is valid up to 400kHz, which allows for a decent amount of data to be transfered.

In the case of the V4 hardware, the MCU would act as an I2C master, while the button nodes would act as an I2C slave.
In order to connect the buttons an I2C 8 or 16-bit port expander is used.
The following ones were investigated:

* Texas Instruments [PCF8574A][7], 8-bit (8 buttons), 2.5V to 6V Vcc, PDIP/SOIC/SSOP/QFN packaging
* Microchip [MCP23017][8], 16-bit (16 buttons), 1.8V to 5.5V Vcc, PDIP/SOIC/SSOP/QFN packaging
* ON Semiconductor [CAT9535][9], 8-bit (8 buttons), 2.3V to 5.5V Vcc, SOIC/TSSOP/TQFN packaging

![I2C I/O port expander](https://raw.github.com/demtech/v4/master/hardware/images/v4-i2c-expander.png)

Each of these allow the connection of at least 8 buttons, come with configurable addresses so they can be set up to be unique
on the bus, and provide an interrupt signal back to the MCU to indicate that a state change has happened. This is a quite useful
feature, as these devices are slaves, so their states can only be polled by the master when it requests it. By levereging the interrupt
signal, in the V4 design, it is possible to ask the MCU to initiate the readout of the current state of buttons only when a state
change has occured. This is optimal both from a power saving perspective, and also frees up more resources for other functionality
such as crypto.

In the current design of the V4, the I2C bus is broken out on a 5-pin header, which consists of the Vcc, SDA, SCL, INT and GND.
These five signals are the ones which interface with the button nodes, providing power and data across conviniently placed magnetic plugs.

![I2C header](https://raw.github.com/demtech/v4/master/hardware/images/v4-i2c-bus.png)

#### Printer

In order to produce a paper trail for the vote, a paper ballot is needed. To solve this, the possibility of having
a printer was investigated. Early in the process it was decided to go for an RS232 capable printer, to keep the complexity down.

Choosing the right printer is not a small feat in itself, due to the more and more complex printers out on the market. Most
of the printers on the consumer market are nowadays "smart" ones, which include a number of embedded systems, some which are
running very complex operating systems such as Windows CE! This introduces a number of unwanted sources of potential security flaws. 

After researching the type of printers, the following list was compiled:

* Line printers
* Dot-matrix printers
* Daisy Wheel printers
* Thermal transfer printers
* Dye-sublimation printers
* Ink-jet printers
* Laser printers

The following potential printers were looked at:

* [SiPix Pocket Palm Printer][10]
* [Sieko Thermal Portable Receipt Printer][11]
* [CITIZE Column RS 232C Serial Printer][12]
* [Ap1310 Thermal Portable Printer][13]

Each of these need to be studied in depth to find out which one would be the most suitable for printing out a ballot. There
are a number of factors to consider which are outside the scope of this research.

### 3D case design

When designing a 3d case for a product a number of design considerations need to be made regarding the usability, 
the hardware security and robusness, etc. Doing a well thought through design could be a subject for a research of it's own.

Regardless, the design below is a shot-in-the-dark for a modular concept for an electronic ballot design, where each module can be
snapped together using magnetic snaps. This makes it easy to physically reconfigure the device into different shapes and sizes,
making it suitable for the dynamic nature of elections. 

![V4 3d case concept](https://raw.github.com/demtech/v4/master/hardware/images/v4-3d-concept-small.png)

The case was designed in a software tool called [OpenSCAD][14], which is dubbed "The Programmers Solid 3d CAD Modeller".
It is an excellent open source tool which allows the user to programatically define objects, instead of the traditional
drawing method. By doing this, the user can create procedural structures, which can be dynamically adjusted to fit the specific
use-case.

In the case of the V4 hardware, a special project box was defined with parameters which include width, height, length,
radius of the corners, and wall thickness.
To create the ballot case, 6 project boxes were created, where 4 of them were "button boxes" which contain the buttons, while
the other two are the "compute box", and potentially an empty box which could be used for a power supply or backup battery.
The project box contains screw columns and holes in each corner of the element, so it is easy to put them together.

During the research into what type of case to design, a number of fun ideas were thrown around, such as making a foldable device,
and building in physical security features which would make the tampering with the device much harder.
These ideas were discarded in the favour of a very simple design mostly due to lack of time and skills.


Software considerations
------------------------

There hasn't been too much work done on the software side of things, as the main objective
was to have a hardware platform which could be used for future software development and
testing.

However, some of software components which are planned to be used in the future were
prototyped quickly to verify that they can indeed execute on the target as expected.

The two main areas of focus were the evaluation of the MCU if it's fast enough to do
encryption in a reasonable time, and if there are enough resources to run a java
virtual machine (JVM). But first, it had to be programmed somehow.


### Programming the device

For programming the ISP port is used. The functionality on a hardware level has been detailed
previously in this paper. 

The test programming of the device was with an USPASP compatible programmer called [JYE Tech USB Programmer][15].
This programmer uses libusb to access the device, and has been confirmed to work both in Linux and in Mac OS X.

The program used to program the chip is the excellent [avrdude][16], an open source tool written as a replacement to
the commercial AVRstudio. It has since been adopted as the programmer for the popular Arduino boards aswell.

An example of flashing the chip with a speed test:

```
$ sudo avrdude -F -p m1284p -c usbasp -U flash:w:speed_nacl_atmega2560.hex 

avrdude: AVR device initialized and ready to accept instructions

Reading | ################################################## | 100% 0.00s

avrdude: Device signature = 0x1e9706
avrdude: Expected signature for ATMEGA1284P is 1E 97 05
avrdude: NOTE: FLASH memory has been specified, an erase cycle will be performed
         To disable this feature, specify the -D option.
avrdude: erasing chip
avrdude: reading input file "speed_nacl_atmega2560.hex"
avrdude: input file speed_nacl_atmega2560.hex auto detected as Intel Hex
avrdude: writing flash (29988 bytes):

Writing | ################################################## | 100% 11.55s

avrdude: 29988 bytes of flash written
avrdude: verifying flash memory against speed_nacl_atmega2560.hex:
avrdude: load data flash data from input file speed_nacl_atmega2560.hex:
avrdude: input file speed_nacl_atmega2560.hex auto detected as Intel Hex
avrdude: input file speed_nacl_atmega2560.hex contains 29988 bytes
avrdude: reading on-chip flash data:

Reading | ################################################## | 100% 7.50s

avrdude: verifying ...
avrdude: 29988 bytes of flash verified

avrdude: safemode: Fuses OK

avrdude done.  Thank you.
```

The above examples shows that it is possible to set the chip type with the "-p" parameter, the programmer type with "-c", 
and specify the compiled machine code to upload in the Intel HEX format.
For us, it was also needed to force avrdude to skip the signature check as our atmega1284p returned a signature different
from what is specified for it in the configuration file. After reading up on it, it turned out that the signature was updated
together with a new revision of the chip.


### Security

For encryption, the choice of library was [NaCl][17] (salt), which is an "easy-to-use high-speed
software library for network communication, encryption, decryption, signatures, etc.".

The implementation is small enough to run on a microcontroller, and it has already been 
[ported to the AVR][18] by Michael Hutter and Peter Schwabe. Their implementation was acquired and tested
on our prototype board. 

After running the tests from their implementation on the v4 development board, it was possible to see how many
instructions each crypto function took, with the worst case being 40 million instruction. By calculating
back how many seconds would it take to run 40 million instructions, it was deducted that it would take roughly 
2 seconds, which was still within our acceptable range in terms of user experience.

### JVM

The reason why a JVM is of interest is because there are a large number of tools
and libraries which are already formally verified, and which can be used to help
the formal verification along, compared to tools available for C.

For the JVM the testing was done on [HVM][19] from icelab.dk. 
The Java code was written in Eclipse, and then compiled into C code by the iceTool eclipse plugin.
There are two ways of compiling the code, one is to have the class as java bytecode which would be interpreted
at runtime, which based on measurements is roughly 8 times slower than native code. The other method is to
compile the methods into a C method, which would execute close to native speed. 

The following Makefile was made for compiling the generated code:

```
TARGET=out
CC=avr-gcc
LD=avr-ld
AR=avr-ar
SIZE=avr-size
MCU=atmega1284p
F_CPU=8000000UL
FORMAT=ihex
OBJCOPY=avr-objcopy
SRC=allocation_point.c print.c classes.c icecapvm.c methodinterpreter.c methods.c gc.c natives_allOS.c natives_avr.c rom_heap.c rom_access.c
CFLAGS=-g -Wall -pedantic -Os -fpack-struct -fshort-enums -std=gnu99 -funsigned-char -funsigned-bitfields -DF_CPU=$(F_CPU)
LDFLAGS=
REMOVE=rm
AVRDUDE_PORT=/dev/ttyUSB0
AVRDUDE_BIN=avrdude
AVRDUDE_CONF=/etc/avrdude.conf
AVRDUDE_PROGRAMMER=usbasp
UPLOAD_RATE=115200

# Uploader configuration 
AVRDUDE_WRITE_FLASH=-e -U flash:w:$(TARGET).hex:i
AVRDUDE_FLAGS=-F -C $(AVRDUDE_CONF) -p $(MCU) -c $(AVRDUDE_PROGRAMMER)

OBJ=$(SRC:.c=.o)

all: build

elf: $(TARGET).elf
hex: $(TARGET).hex

.SUFFIXES: .elf .hex

build: $(TARGET).elf $(TARGET).hex

$(TARGET).elf:
        $(CC) $(CFLAGS) -mmcu=$(MCU) -o $@ $(SRC)
        $(SIZE) $@
        
$(TARGET).hex: $(TARGET).elf
        $(OBJCOPY) -O $(FORMAT) -R .eeprom $< $@

# Compile: create object files from C source files.
.c.o:
        $(CC) -c $(CFLAGS) -mmcu=$(MCU) $< -o $@ 

clean:
        $(REMOVE) $(TARGET).hex $(TARGET).elf

upload: $(TARGET).hex
        $(AVRDUDE_BIN) $(AVRDUDE_FLAGS) $(AVRDUDE_WRITE_FLASH)

monitor: $(TARGET).hex
        screen /dev/ttyUSB0 115200

```

To adopt HVM to the V4 specific MCU, only a limited amount of work needs to be done, which includes the definition
of the interrupt vector table, the registers and setup the atmega1284p specific timers.

To learn more about HVM, some excellent resources can be found on icelab.dk.

Future works
-------------

There are still a number of areas which could be explored but were not due to lack of time:

* One of them would be to include a TPM (Trusted Platform Module) which could be used to off-load crypt to the chip, 
  increasing the security and reducing the response time
  
* Investigating a number of other 3d case designs, possibly with "physical security features" and tamper proofing

* Continue on the development of the hardware prototype to get it ready for mass production

* Investigate the usability and the user experience of the device

* Do the formal verification of the HVM


Related Documents
------------------

Most of sources for the work here can be accessed in the v4 repository under the demtech organization on github.
The works related to the JVM are not included as the license they were published under does not allow the publication
of the works at this time. 

The repository includes the following (all paths are relative to the root of the repo):

* README.md - An introduction to the generic V4 project
* README-jvm.md - Project description planned around the JVM for the V4 hardware
* README-hardware.md - Project description planned for the V4 hardware
* hardware/3dcad - OpenSCAD 3d CAD files for the V4 hardware
* hardware/docs - Some documentation for the different components
* hardware/images -  Images for the hardware
* hardware/schematics - KiCad schematics of the V4 hardware
* hardware/avrnacl - AVR NaCl Port


References
----------

* [1]: http://www.atmel.com/images/doc0943.pdf‎  [AVR: In-System Programming]
* [2]: http://www.ti.com/lit/ds/symlink/max232.pdf‎ [MAX232 datasheet, TTL-to-RS232 level shifter]
* [3]: https://www.sparkfun.com/datasheets/IC/AT45DB161D.pdf [AT45DB161D datasheet, DataFlash storage]
* [4]: http://www.nxp.com/documents/data_sheet/HEF4514B_CNV.pdf [HEF4515B datasheet, Digital multiplexer]
* [5]: http://datasheets.maximintegrated.com/en/ds/DS2408.pdf [DS2408 datasheet,  1-Wire 8-Channel Addressable Switch]
* [6]: http://www.atmel.com/images/doc8059.pdf [ATmega1284P datasheet]
* [7]: http://www.ti.com/lit/ds/scps069d/scps069d.pdf [PCF8574A datasheet, 8-bit i2c i/o expander]
* [8]: http://ww1.microchip.com/downloads/en/DeviceDoc/21952b.pdf [MCP23017, 16-bit i2c i/o expander] 
* [9]: http://www.onsemi.com/pub_link/Collateral/CAT9534-D.PDF [CAT9534, 8-bit i2c i/o expander]
* [10]: http://www.amazon.com/SiPix-Pocket-Palm-Printer-Blue/dp/B00005LDPR/ref=pd_sim_sbs_e_6
* [11]: http://www.amazon.com/Seiko-Thermal-Portable-Receipt-PRINTER/dp/B004ETSDV6/ref=pd_sim_sbs_e_5
* [12]: http://www.amazon.com/CITIZEN-Column-RS-232C-Serial-Printer/dp/B0038L47AC/ref=sr_1_4?s=electronics&ie=UTF8&qid=1363605109&sr=1-4&keywords=rs232+printer
* [13]: http://uk.rs-online.com/web/p/portable-modular-printers/0524468/
* [14]: http://www.openscad.org [OpenSCAD]
* [15]: http://www.jyetech.com/Products/073/How%20to%20Use%20the%20USB%20Programmer.pdf [JYETECH USB programmer]
* [16]: http://nacl.cr.yp.to/ [NaCl crypto]
* [17]: http://cryptojedi.org/papers/avrnacl-20130220.pdf [AVR NaCl port]
* [18]: http://www.atmel.com/images/atmel-2521-avr-hardware-design-considerations_application-note_avr042.pdf [AVR: Hardware design considerations application note]
* [19]: http://www.kicad-pcb.org/display/KICAD/KiCad+EDA+Software+Suite
* [20]: http://icelab.dk/

