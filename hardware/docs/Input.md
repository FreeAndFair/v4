Objectives:
-----------

* It should be possible to interface a large number of buttons (120+)
* It should be relatively low latency (responsiveness)
* It should be modular, so extending it with more buttons should be easy


Options:
--------

* "Simple" button matrix (multiplexing, charlieplexing?)
* 1-wire device?
* I2C button matrix


Simple button matrix
====================

Multiplexing
------------

Multiplexing the buttons allow us to use 2*N number of IO pins for an N*N button matrix.
So 16 buttons require 8 pins.

Using a 1-of-n decoder chip (such as the HEF4514B), the number of IO pins required can be reduced to n + [log_2 n].

Charlieplexing
--------------

Charlieplexing allows the use of N IO pins for an N*N button matrix, but requires extra components (diodes).
It is also considered "lossy" as it can only detect a single button press reliably.

1-wire button matrix
====================

Possible to use: DS2401 (1-Wire 8-Channel Addressable Switch)
It is not very wide spread.

I2C button matrix
=================

Using an i2c, it is theoretically possible to connect up to 127 devices on the same bus, allowing for a large number of modules.

Option 1:  8/16 port expander devices (PCF8574A) with 8 buttons each, giving a maximum of 128 buttons.

Option 2: 8 port expander devices (MCP23017) with 16 buttons each, giving a maximum number of 128 buttons.

Option 3: 8 port expander devices (CAT9534) with 8 buttons each, giving a maximum number of 64 buttons.


The wiring of these modules would be rather simple, as the I2C itself requires, 2 pins (SDA, SCL), the chip needs power (VCC, GND) and an optional interrupt bus could be shared to notify the microcontroller of button presses, resulting in a total of 5 signals which need to be connected.

Resources: https://sites.google.com/site/arduinoprojectst/i2c-keypad-and-lcd-controller/keypad-and-port-expander-1







