Logging
-------

In order to be able to save logs, a storage device is needed.
Here are some of the possible options:

1. Store them in the EEPROM of the MCU (usually around 1-2KB space available)
2. Store them in the FLASH of the MCU (could be problematic with program/data sharing the same memory space, usual flash size is 16-256KB)
3. Store them on an external FLASH/EEPROM over I2C/SPI (anything from 512B to 32+ MB available)
4. Store them on an MMC/SD memory card (anything from 64MB to 32GB available)


