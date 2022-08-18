# Elfos-TMS9X18-Driver
TMS9X18 Video Display Processor driver for Elf/OS is an Elf/OS program for the [1802-Mini TMS9x18 Video Card](https://github.com/dmadole/1802-Mini-9918-Video) by David Madole and for Pico/Elf v2 TMS9118/9918 Color Video card. Information about the Pico/Elf v2 and the TMS9118/9918 Color Board  is available at [elf-emulation.com](http://www.elf-emulation.com/hardware.html) by Mike Riley.  This driver program was assembled into an 1802 binary file using the [Asm/02 1802 Assembler](https://github.com/rileym65/Asm-02) by Mike Riley.

Platform  
--------
These driver was written to run on an [1802-Mini](https://github.com/dmadole/1802-Mini) with the [1802-Mini TMS9918 Video Card](https://github.com/dmadole/1802-Mini-9918-Video) created by David Madole.  A lot of information and software for the 1802-Mini can be found in the [COSMAC ELF Group](https://groups.io/g/cosmacelf) at groups.io.  The driver should also run with a Pico/Elf v2 and a TMS9118/9918 Color Board, but this configuration has not been tested yet.  In order to run properly, the driver source file tms9x18.asm should be assembled with the constants in the /include/tsm9x18.inc file to set to match Data Port, Register Port and Expansion Group settings on the video card hardware platform.

Examples
----------
## tms9x18
This command will load the tms9x18 video driver into the Elf/OS high memory and register the driver with the Elf/OS kernel.  If the video driver is already loaded this command will print a message with the driver's Data Port, Register Port and Expansion Group.

## tms9x18 -u
The option -u will unload the driver from high memory, return the memory block to the heap and unregister the driver from the Elf/OS kernel.

## tms9x18 -?
Any other option besides *-u* will show a help message.


TMS9X18 Video Driver API
------------------------
<table>
<tr><th>Number</th><th>VDP.inc Token</th><th colspan="2">Description</th></tr>
<tr><td>0x00</td><td>V_SET_ADDRESS</td><td colspan="2">Set the VDP register Address.</td></tr>
<tr><td>0x01</td><td>V_SET_GROUP</td><td colspan="2">Set the Expansion Group to the video card expansion group.</td></tr>
<tr><td>0x02</td><td>V_RESET_GROUP</td><td colspan="2">Reset the Expansion Group to the system default.</td></tr>
<tr><td>0x03</td><td>V_WRITE_VREG</td><td colspan="2">Write a data value to a VDP register</td></tr>
<tr><td>0x04</td><td>V_FILL_VRAM</td><td colspan="2">Fill the VDP memory with a particular data value.</td></tr>
<tr><td>0x05</td><td>V_WRITE_DATA</td><td colspan="2">Write a data buffer to the VDP memory.</td></tr>
<tr><td>0x06</td><td>V_FILL_SEQ</td><td colspan="2">Fill the VDP memory with sequential byte values 00 to FF, repeated as needed.</td></tr>
<tr><td>0x07</td><td>V_WRITE_BYTE</td><td colspan="2">Write a single byte value to the VDP memory</td></tr>
<tr><td>0x08</td><td>V_READ_STATUS</td><td colspan="2">Read VDP status byte</td></tr>
<tr><td>0x09</td><td>V_WRITE_RLE</td><td colspan="2">Write a data buffer encoded in the Sun RLE format to the VDP memory.</td></tr>
<tr><td>0x0a</td><td>V_GET_BYTE</td><td colspan="2">Get a data byte from a given VDP address.</td></tr>
<tr><td>0x0b</td><td>V_SET_BYTE</td><td colspan="2">Set a data byte at a given VDP address.</td></tr>
</table>

TMS9X18 Video Driver API Parameters
-----------------------------------
<table>
<tr><th rowspan="2">Number</th><th rowspan="2">VDP.inc Token</th><th colspan="2">R7</th><th colspan="2">R8</th><th rowspan="2" colspan="2">Note</th></tr>
<tr><th>R7.1</th><th>R7.0</th><th>R8.1</th><th>R8.0</th></tr>
<tr><td>0x00</td><td>V_SET_ADDRESS</td><td colspan="2">Register Address</td><td colspan="2"> - </td><td colspan="2"> - </td></tr>
<tr><td>0x01</td><td>V_SET_GROUP</td><td colspan="2"> - </td><td colspan="2"> - </td><td colspan="2"> If an expansion group is not defined, this function returns immediately.</td></tr>
<tr><td>0x02</td><td>V_RESET_GROUP</td><td colspan="2"> - </td><td colspan="2"> - </td><td colspan="2"> If an expansion group is not defined, this function returns immediately.</td></tr>
<tr><td>0x03</td><td>V_WRITE_VREG</td><td>Data to write</td><td>VDP Register destination</td><td colspan="2"> - </td><td colspan="2"> - </td></tr>
<tr><td>0x04</td><td>V_FILL_VRAM</td><td colspan="2"> Size of memory to fill</td><td> - </td><td>byte to fill memory with.</td><td colspan="2">Set the memory address using V_SET_ADDRESS before calling this function.</td></tr>
<tr><td>0x05</td><td>V_WRITE_DATA</td><td colspan="2"> Size of memory</td><td colspan="2">Pointer to data buffer.</td><td colspan="2">Set the memory address using V_SET_ADDRESS before calling this function.</td></tr>
<tr><td>0x06</td><td>V_FILL_SEQ</td><td colspan="2"> Size of memory to fill</td><td colspan="2">(R8 is used internally to fill memory)</td><td colspan="2">Set the memory address using V_SET_ADDRESS before calling this function. Memory will be filled with sequential bytes from 00 to FF, repeated as necessary.</td></tr>
<tr><td>0x07</td><td>V_WRITE_BYTE</td><td colspan="2"> -</td><td>-</td><td>data byte to write</td><td colspan="2">Set the memory address using V_SET_ADDRESS before calling this function.</td></tr>
<tr><td>0x07</td><td>V_READ_STATUS</td><td colspan="2"> - </td><td colspan="2">-</td><td colspan="2">The VDP status byte is returned in D.</td></tr>
<tr><td>0x09</td><td>V_WRITE_RLE</td><td colspan="2">Size of memory</td><td colspan="2">Pointer to data buffer encoded in the Sun RLE format.</td><td colspan="2">R9 is used internally for the repeated data byte count. Set the memory address using V_SET_ADDRESS before calling this function.</td></tr>
<tr><td>0x0a</td><td>V_GET_BYTE</td><td colspan="2">VDP Address</td><td colspan="2">-</td><td colspan="2">The data byte read from VDP memory address is returned in D.</td></tr>
<tr><td>0x0b</td><td>V_SET_BYTE</td><td colspan="2">VDP Address</td><td>-</td><td>data byte to write</td><td colspan="2">Writing data this way is usually slower than the other functions.</td></tr>
</table>

TMS9X18 Video Driver API Notes
------------------------------
* Be sure to set the Expansion Group before using any VDP functions and to reset the Expansion Group back to default before returning to the Elf/OS.
* For most data functions set the VDP Address using the V_SET_ADDRESS function.
* R7 is used for the VDP Address, Memory Size or Register data.
* R8 is used for the data buffer pointer, and R8.0 is used for a single data byte to write.  R8 is used internally by V_FILL_SEQ.
* R9 is used internally by V_WRITE_RLE for the repeated byte count when uncompressing Sun RLE encoded data.
* The functions V_GET_BYTE and V_SET_BYTE always set the memory address and access a single byte.  If possible, it is usually faster to set an address for the memory location one time with SET_ADDRESS and use one of the other functions to write or fill memory repeatedly.

Repository Contents
-------------------
* **/src/**  -- Source files for assembling the TMS9X18 Video Driver.
  * asm.bat - Windows batch file to assemble source file with Asm/02 to create binary file. Use the command *asm tms9x18.asm* to assemble the tms9x18.asm file.  Replace *[YOUR_PATH]* with the path to the Asm/02 directory.
  * tms9x18.asm - Demo to blank the display.
* **/src/include/**  -- Included source files for Elf/OS TMS9X18 Video Driver.
  * ops.inc - Opcode definitions for Asm/02.
  * bios.inc - Bios definitions from Elf/OS
  * kernel.inc - Kernel definitions from Elf/OS
  * tms9x18.inc - Video card configuration constants.  The constants in this file *must* match the video card hardware configuration.  
  * vdp.inc - API constants and useful VDP constants to be used by programs calling the driver.
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
