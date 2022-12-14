# Elfos-TMS9X18-Driver
TMS9X18 Video Display Processor driver for Elf/OS is an Elf/OS program for the [1802-Mini TMS9x18 Video Card](https://github.com/dmadole/1802-Mini-9918-Video) by David Madole and for Pico/Elf v2 by Mike Riley with a [TMS9118/9918 Color Board](https://web.archive.org/web/20220918120827/http://www.elf-emulation.com/hardware.html) or a [Pico/Elf TMS9918 Video IO card](https://github.com/fourstix/PicoElfTMS9118VIOCard). This driver program was assembled into an 1802 binary file using the [Asm/02 1802 Assembler](https://github.com/rileym65/Asm-02) by Mike Riley.

Platform  
--------
These driver was written to run on an [1802-Mini](https://github.com/dmadole/1802-Mini) with the [1802-Mini TMS9918 Video Card](https://github.com/dmadole/1802-Mini-9918-Video) created by David Madole.  The driver will also run with a [Pico/Elf v2](https://web.archive.org/web/20220918120827/http://www.elf-emulation.com/hardware.html) and the [Pico/Elf TMS9918 Video IO card](https://github.com/fourstix/PicoElfTMS9118VIOCard) or with a [TMS9118/9918 Color Board](https://web.archive.org/web/20220918120827/http://www.elf-emulation.com/hardware.html).  In order to run properly, the driver source file tms9x18.asm should be assembled with the constants in the /include/tsm9x18.inc file to set to match Data Port, Register Port and Expansion Group settings on the video card hardware platform. Two versions of the driver are available as binaries to match the configurations listed below.  A lot of information and software for the 1802-Mini and Pico/Elf v2 can be found in the [COSMAC ELF Group](https://groups.io/g/cosmacelf) at groups.io.

1802-Mini v4.4 Configuration 
-----------------------------
For this configuration, the code is assembled with the expansion group defined as 1 in tms9x18.inc amd with the EXT_PORT define statement set equal to 5. The binary file tms9x18_5167.bin is assembled to match the v4.4 firmware configuration that is defined by the [1802-Mini ElfOS Install Rom v4.4](https://github.com/dmadole/1802-Mini/blob/master/firmware/1802-mini-elfos-410-install-v4.4.img). In this configuration the TMS9X18 Video card is configured for Expansion Port 5, Group 1, Data Port 6 and Register Port 7.  The binary file for this driver is [tms9x18_5167.bin](https://github.com/fourstix/Elfos-TMS9X18-Driver/blob/main/bin/tms9x18_5167.bin).

Card Groups and Ports
-------------------------
<table>
<tr><th>Group</th><th>Ports</th><th>Card</th></tr>
<tr><td rowspan = "3">ALL</td><td>1</td><td>

[Pixie Video](https://groups.io/g/cosmacelf/message/39132)

</td></tr>
<tr><td>4</td><td>

[Front Panel](https://github.com/dmadole/1802-Mini-Front-Panel)

</td></tr>
<tr><td>5</td><td>

[Expander](https://github.com/dmadole/1802-Mini-Expander-RTC)

</td></tr>
<tr><td rowspan = "4">00</td><td>2</td><td rowspan="2">

[Compact Flash](https://github.com/dmadole/1802-Mini-Compact-Flash)

</td></tr>
<tr><td>3</td></tr>
<tr><td>6</td><td rowspan="2">

[UART](https://github.com/dmadole/1802-Mini-1854-Serial)

</td></tr>
<tr><td>7</td></tr>
<tr><td rowspan="3">01</td><td>3</td><td>

[Real Time Clock](https://github.com/dmadole/1802-Mini-Expander-RTC)

</td></tr>
<tr><td>6</td><td rowspan="2">

[TMS9X19 Video](https://github.com/dmadole/1802-Mini-9918-Video)

</td></tr>
<tr><td>7</td></tr>
<tr><td rowspan="2">02</td><td>2</td><td rowspan="2">

[SPI/MicroSD](https://github.com/arhefner/1802-Mini-SPI-DMA)

</td></tr>
<tr><td>3</td></tr>
</table>

External Flags
-------------------------
<table>
<tr><th>Flag</th><th>Card</th><th>Function</th></tr>
<tr><td>/EF1</td><td>Pixie Video</td><td>Video Status</td></tr>
<tr><td>/EF2</td><td>Processor</td><td>Software IO</td></tr>
<tr><td>/EF3</td><td>(none)</td><td>(unassigned)</td></tr>
<tr><td>/EF4</td><td>Front Panel</td><td>Input Button</td></tr>
</table>

The assembled version of this driver is named tms9x18_5167.bin. (Expansion Port 5, Group 1, Data Port 6 and Register Port 7.)

1802-Mini v4.3 Configuration 
----------------------------
For this configuration, the code is assembled with the expansion group defined as 1 in tms9x18.inc and with the EXT_PORT define statement set equal to 1.  The binary file tms9x18_1167.bin is assembled to match the firmware v4.3 configuration that is defined by the [1802-Mini ElfOS Install Rom v4.3](https://github.com/dmadole/1802-Mini/blob/master/firmware/1802-mini-elfos-410-install-v4.3.img). In this configuration the TMS9X18 Video card is configured for Expansion Port 1, Group 1, Data Port 6 and Register Port 7.  The binary file for this driver is [tms9x18_1167.bin](https://github.com/fourstix/Elfos-TMS9X18-Driver/blob/main/bin/tms9x18_1167.bin).

Card Groups and Ports
-------------------------
<table>
<tr><th>Group</th><th>Ports</th><th>Card</th></tr>
<tr><td rowspan = "2">ALL</td><td>1</td><td>

[Expander](https://github.com/dmadole/1802-Mini-Expander-RTC)

</td></tr>
<tr><td>4</td><td>

[Front Panel](https://github.com/dmadole/1802-Mini-Front-Panel)
</td></tr>
<tr><td rowspan = "5">00</td><td>2</td><td rowspan="2">

[Compact Flash](https://github.com/dmadole/1802-Mini-Compact-Flash)

</td></tr>
<tr><td>3</td></tr>
<tr><td>5</td><td>

[Real Time Clock](https://github.com/dmadole/1802-Mini-Expander-RTC)

</td></tr>
<tr><td>6</td><td rowspan="2">

[UART](https://github.com/dmadole/1802-Mini-1854-Serial)

</td></tr>
<tr><td>7</td></tr>
<tr><td rowspan="2">01</td><td>6</td><td rowspan="2">

[TMS9X19 Video](https://github.com/dmadole/1802-Mini-9918-Video)

</td></tr>
<tr><td>7</tr>
</table>

External Flags
-------------------------
<table>
<tr><th>Flag</th><th>Card</th><th>Function</th></tr>
<tr><td>/EF1</td><td>TMS9X18 Video</td><td>VDP Interrupt</td></tr>
<tr><td>/EF2</td><td>Processor</td><td>Software IO</td></tr>
<tr><td>/EF3</td><td>(none)</td><td>(unassigned)</td></tr>
<tr><td>/EF4</td><td>Front Panel</td><td>Input Button</td></tr>
</table>

The assembled version of this driver is named tms9x18_1167.bin. (Expansion Port 1, Group 1, Data Port 6 and Register Port 7.)

Pico/Elf v2 Configuration  
-------------------------
There is no expansion card in this Pico/Elf v2 Configuration, so there is no expansion group defined in tms9x18.inc when the code is assembled. (The EXT_PORT define statement is commented out.) The binary file [tms9x18_N15.bin](https://github.com/fourstix/Elfos-TMS9X18-Driver/blob/main/bin/tms9x18_N15.bin) is assembled to match this platform configuration.

Ports
------
<table>
<tr><th>Group</th><th>Ports</th><th>Function</th></tr>
<tr><td rowspan="7">(None)</td><td>1</td><td>Video Card Data</td></tr>
<tr><td>2</td><td rowspan="2">Disk Card</td></tr>
<tr><td>3</td></tr>
<tr><td>4</td><td>Data IO</td></tr>
<tr><td>5</td><td>Video Card Register</td></tr>
<tr><td>6</td><td rowspan="2">RTC/NVR/UART</td></tr>
<tr><td>7</td></tr>
</table>

External Flags
---------------
<table>
<tr><th>Flag</th><th>Function</th></tr>
<tr><td>/EF1</td><td>VDP Interrupt</td></tr>
<tr><td>/EF2</td><td>Software IO</td></tr>
<tr><td>/EF3</td><td>(unassigned)</td></tr>
<tr><td>/EF4</td><td>Input Button</td></tr>
</table>

The assembled version of this driver is named vdp_video_N15.bin. (N = No group, Data Port 1 and Register Port 5.)

If your configuration is different from the above, edit the tms9x18.inc file and 
change the constants to match your configuration.  Then re-assemble the code with the updated tms9x18.inc file.

Example Commands
----------------
## tms9x18
This command will load the tms9x18 video driver into the Elf/OS high memory and register the driver with the Elf/OS kernel.  If the video driver is already loaded this command will print a message with the driver's Data Port, Register Port and Expansion Group.

## tms9x18 -u
The option -u will unload the driver from high memory, return the memory block to the heap and unregister the driver from the Elf/OS kernel.

## tms9x18 -?
Any other option besides *-u* will show a help message with usage information.


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
<tr><td>0x0c</td><td>V_GET_INFO</td><td colspan="2">Get user defined data values from memory.</td></tr>
<tr><td>0x0d</td><td>V_SET_INFO</td><td colspan="2">Set user defined data values in memory.</td></tr>
<tr><td>0x0e</td><td>V_GET_VERSION</td><td colspan="2">Get the driver version as a byte.</td></tr>
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
<tr><td>0x0c</td><td>V_GET_INFO</td><td colspan="2">User Defined Word Value (Returned in R7)</td><td colspan="2">User Defined Word Value (Returned in R8)</td><td colspan="2">R9 is used internally as a memory pointer. Get user defined word values saved previously in memory and return in R7 and R8.</td></tr>
<tr><td>0x0d</td><td>V_SET_INFO</td><td colspan="2">User Defined Word Value to save.</td><td colspan="2">User Defined Word Value to save.</td><td colspan="2">R9 is used internally as a memory pointer. Save user defined word values in R7 and R8 to memory.</td></tr>
<tr><td>0x0e</td><td>V_GET_VERSION</td><td colspan="2"> - </td><td colspan="2"> - </td><td colspan="2"> The driver version is returned in D. The high nibble is the major version, and the low nibble is the minor version.</td></tr>

</table>

TMS9X18 Video Driver API Notes
------------------------------
* Be sure to set the Expansion Group before using any VDP functions and to reset the Expansion Group back to default before returning to the Elf/OS.
* For most data functions set the VDP Address using the V_SET_ADDRESS function.
* R7 is used for the VDP Address, Memory Size, Register data or Index value.
* R7 is used to return the Index value saved previously.
* R8 is used for the data buffer pointer, and R8.0 is used for a single data byte to write.  R8 is used internally by V_FILL_SEQ.
* R9 is used internally by V_WRITE_RLE for the repeated byte count when uncompressing Sun RLE encoded data.
* R9 is used internally by V_SET_INFO and V_GET_INFO as a memory pointer. 
* The functions V_GET_BYTE and V_SET_BYTE always set the memory address and access a single byte.  If possible, it is usually faster to set an address for the memory location one time with SET_ADDRESS and use one of the other functions to write or fill memory repeatedly.
* The functions V_SET_INFO and V_GET_INFO can be used to save and retrieve user program values, like the offset into VDP memory or color map values, as data words in the driver memory. These functions save and retrieve the word values in R7 and R8.
* The V_GET_VERSION function returns the current driver version in D.  The major version is in the higher 4 bits of this byte and the minor version is in the lower 4 bits. The byte value of 0x13 indicates v1.3 as the current driver version.

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
* **/src/include/example/**  -- Example tms9x18.inc source files for various Elf/OS TMS9X18 Video Driver configurations.
  * tms9x18_1167.inc - Include file for a 1802-Mini v4.3 with the Expansion Port set to 1, and the TMS9x18 video card set to Expansion Group 1, Data Port 6 and Register Port 7.
  * tms9x18_5167.inc - Include file for a 1802-Mini v4.4 with the Expansion Port set to 5, and the TMS9x18 video card set to Expansion Group 1, Data Port 6 and Register Port 7.
  * tms9x18_N15.bin - Include file for a Pico/Elf v2 TMS9x18 video card set to Data Port 1, Register Port 5 and no expansion card group in use.
* **/bin/**  -- Binary files for TMS9X18 video driver.
  * tms9x18_1167.bin - Video driver assembled for a 1802-Mini v4.3 with the Expansion Port set to 1, and the TMS9x18 video card set to Expansion Group 1, Data Port 6 and Register Port 7.
  * tms9x18_5167.bin - Video driver assembled for a 1802-Mini v4.4 with the Expansion Port set to 5, and the TMS9x18 video card set to Expansion Group 1, Data Port 6 and Register Port 7.
  * tms9x18_N15.bin - Video driver assembled for a Pico/Elf v2 TMS9x18 video card set to Data Port 1, Register Port 5 and no expansion card group in use.
  

License Information
-------------------

This code is public domain under the MIT License, but please buy me a beer
if you use this and we meet someday (Beerware).

References to any products, programs or services do not imply
that they will be available in all countries in which their respective owner operates.

Other company, product, or services names may be trademarks or services marks of others.

All libraries used in this code are copyright their respective authors.

The 1802-Mini hardware and software
Copyright (c) 2021-2022 by David Madole

The Pico/Elf v2 1802 microcomputer hardware and software
Copyright (c) 2004-2022 by Mike Riley.

Elf/OS and RcAsm Software
Copyright (c) 2004-2022 by Mike Riley.

The Pico/Elf Video IO Card hardware
Copyright (c) 2022 by Gaston Williams

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
