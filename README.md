# Elfos-TMS9X18-Driver
TMS9X18 Video Display Processor driver for Elf/OS is an Elf/OS program for the [1802-Mini TMS9x18 Video Card](https://github.com/dmadole/1802-Mini-9918-Video) by David Madole and for Pico/Elf v2 TMS9118/9918 Color Video card. Information about the Pico/Elf v2 and the TMS9118/9918 Color Board  is available at [elf-emulation.com](http://www.elf-emulation.com/hardware.html) by Mike Riley.  This driver program was assembled into an 1802 binary file using the [Asm/02 1802 Assembler](https://github.com/rileym65/Asm-02) by Mike Riley.

Platform  
--------
These driver was written to run on an [1802-Mini](https://github.com/dmadole/1802-Mini) with the [1802-Mini TMS9918 Video Card](https://github.com/dmadole/1802-Mini-9918-Video) created by David Madole.  A lot of information and software for the 1802-Mini can be found in the [COSMAC ELF Group](https://groups.io/g/cosmacelf) at groups.io.  The driver should also run with a Pico/Elf v2 and a TMS9118/9918 Color Board, but this configuration has not been tested yet.  In order to run properly, the driver source file tms9x18.asm should be assembled with the proper Port and Group settings to match the hardware platform.

Examples
----------
## tms9x18
This command will load the tms9x18 video driver into the Elf/OS high memory and register the driver with the Elf/OS kernel.  If the video driver is already loaded this command will print a message with the driver's Data Port, Register Port and Expansion Group.

## tms9x18 -u
The option -u will unload the driver from high memory, return the memory block to the heap and unregister the driver from the Elf/OS kernel.

## tms9x18 -?
Any other option besided *-u* will show a help message.


TMS9X18 Video Driver API
------------------------


Repository Contents
-------------------
* **/src/**  -- Source files for assembling the TMS9X18 Video Driver.
  * asm.bat - Windows batch file to assemble source file with Asm/02 to create binary file. Use the command *asm tms9x18.asm* to assemble the tms9x18.asm file.
  * tms9x18.asm - Demo to blank the display.
* **/src/include/**  -- Included source files for Elf/OS TMS9X18 Video Driver.
  * ops.inc - Opcode definitions for Asm/02.
  * bios.inc - Bios definitions from Elf/OS
  * kernel.inc - Kernel definitions from Elf/OS
  * tms9x18.inc - Video card configuration constants.  The constants in this file *must* match the video card hardware configuration.  
* **/bin/**  -- Binary files for TMS9X18 video driver.
  * tms9x18_167.bin - Video driver assembled for a 1802-Mini TMS9x18 video card set to Expansion Group 1, Data Port 6 and Register Port 7.
  * tms9x18_N15.bin - Video driver assembled for a TMS9x18 video card set to Data Port 1, Register Port 5 and no expansion card group in use.
  



License Information
-------------------

This code is public domain under the MIT License, but please buy me a beer
if you use this and we meet someday (Beerware).

References to any products, programs or services do not imply
that they will be available in all countries in which their respective owner operates.

Other company, product, or services names may be trademarks or services marks of others.

All libraries used in this code are copyright their respective authors.

The 1802-Mini Hardware
Copyright (c) 2021-2022 by David Madole

The Pico/Elf v2 1802 microcomputer hardware and software
Copyright (c) 2004-2021 by Mike Riley.

Elf/OS and RcAsm Software
Copyright (c) 2004-2021 by Mike Riley.

Many thanks to the original authors for making their designs and code available as open source.

This code, firmware, and software is released under the [MIT License](http://opensource.org/licenses/MIT).

The MIT License (MIT)

Copyright (c) 2022 by Gaston Williams

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

**THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.**
