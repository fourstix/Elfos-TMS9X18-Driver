; -------------------------------------------------------------------
; Load VDP Video driver in high memory
; -------------------------------------------------------------------
; Based on software written by Michael H Riley
; Thanks to the author for making this code available.
; Original author copyright notice:
; *******************************************************************
; *** This software is copyright 2004 by Michael H Riley          ***
; *** You have permission to use, modify, copy, and distribute    ***
; *** this software so long as this copyright notice is retained. ***
; *** This software may not be used in commercial applications    ***
; *** without express written permission from the author.         ***
; *******************************************************************


#include    include/bios.inc
#include    include/kernel.inc
#include    include/ops.inc

#ifdef      MINI1
#include    include/tms9x18_1167.inc
#endif

#ifdef      MINI5
#include    include/tms9x18_5167.inc
#endif

#ifdef      PEV2
#include    include/tms9x18_N15.inc
#endif

; ************************************************************
; This block generates the Execution header
; It occurs 6 bytes before the program start.
; ************************************************************
                        ORG     02000h-6  ; Header starts at 01ffah
                    dw  02000h            ; Program load address
                    dw  endrom-2000h      ; Program size
                    dw  02000h            ; Program execution address

                        ORG     02000h    ; code starts here
                    br  start             ; Jump past build info to code

; Build information                   
binfo:              db  02+80h        ; Month, 80H offset means extended info
                    db  10            ; Day
                    dw  2024          ; Year

; Current build number
build:              dw  6

; Must end with 0 (null)
copyright:          db      'Copyright (c) 2024 by Gaston Williams',0
                  
start:              lda  ra             ; move past any spaces
                    smi  ' '
                    bz   start
                    dec  ra             ; move back to non-space character
                    lda  ra             ; check for nonzero byte
                    lbz  check          ; jump if no arguments
                    smi  '-'            ; check for argument
                    lbnz  bad_arg
                    ldn  ra             ; check for correct argument
                    smi  'u'
                    lbz  unload         ; unload video driver
                    lbr  bad_arg        ; anything else is a bad argument
                      
check:              LOAD rd, O_VIDEO    ; check if video driver is  loaded 
                    lda  rd             ; get the vector long jump command
                    smi  0C0h           ; if not long jump, assume never loaded
                    lbnz load            
                    lda  rd             ; get hi byte of address
                    smi  03h            ; check to see if points to Kernel return
                    lbnz already        ; if not, assume driver is already loaded
                    ldn  rd             ; get the lo byte of address
                    smi  07eh           ; check to see if points to kernel return 
                    lbnz already        ; if not, assume driver is already loaded                    
                                      
load:               LOAD rc, END_DRIVER - BEGIN_DRIVER        ; load block size
                    LOAD R7, 0FF44H     ; page aligned (FF) & named permanent (44) 
                    CALL O_ALLOC        ; Call Elf/OS allocation routine

                    lbdf fail           ; DF = 1 means Elf/OS can't allocate block                                                                  
                    LOAD rd, O_VIDEO    ; save video buffer page in kernel
                    ldi  0c0h           ; 'C0' is lbr to video driver address
                    str  rd             ; save long jump instruction in kernel
                    inc  rd             ; move to address for long jump
                    ghi  rf             ; rf has address of allocated block
                    str  rd             ; save hi byte in kernel vector
                    inc  rd             ; move to lo byte of address                                                              
                    glo  rf             ; save lo byte in kernel vector
                    str  rd
                    inc  rd
                                        
                    COPY rf, rd           ; move destination in rf into rd               
                    LOAD rf, BEGIN_DRIVER ; rf points to source driver code
                    ; RC already has the count of bytes allocated
                    ; LOAD rc, END_DRIVER - BEGIN_DRIVER  ; load block size to move
                    CALL f_memcpy         ; copy the video driver into memory

                    lbr  done             ; we're done!
                                                                                               
unload:             LOAD rd, O_VIDEO+1    ; point rd to video driver vector in kernel
                    lda  rd               ; get hi byte
                    phi  rf
                    ldn  rd               ; get lo byte
                    plo  rf               ; rf points to video driver in memory
                    CALL O_DEALLOC        ; De-alloc memory to unload video driver
                    
                                          ; Dealloc always works
                    LOAD rd, O_VIDEO+1   ; point rd back to hi byte of address
                    ldi  03h              ; point O_VIDEO to kernel return at 037eh
                    str  rd
                    inc  rd               ; advance to lo byte of address
                    ldi  07eh             ; point O_VIDEO to kernel return at 037eh
                    str  rd
                    LOAD rf, removed      ; show message that driver was unloaded
                    CALL O_MSG 
                    RTN                   ; return to Elf/OS
                    
done:               LOAD rf, loaded       ; show message that driver is loaded
                    CALL O_MSG 
                    LOAD rf, copyright
                    CALL O_MSG
                    LOAD rf, crlf
                    CALL O_MSG    
                    LOAD rf, config       ; show configuration info
                    CALL O_MSG
                    RTN                   ; return to Elf/OS 
                      
                    org 2100h             ; make sure to start driver on page boundary
BEGIN_DRIVER: bz SET_ADDR       ; 0 = Select VDP Address
              smi 01h
              bz SET_GROUP      ; 1 = Set Group
              smi 01h
              bz RESET_GROUP    ; 2 = Reset Group
              smi 01h
              bz WRITE_VREG     ; 3 = Write value to video Register 
              smi 01h
              bz FILL_VRAM      ; 4 = Fill memory with a byte
              smi 01h
              bz WRITE_DATA     ; 5 = write data buffer to memory
              smi 01h               
              bz FILL_SEQ       ; 6 = Fill with sequential byte values
              smi 01h               
              bz WRITE_BYTE     ; 7 = Write single byte value to memory
              smi 01h
              bz READ_STATUS    ; 8 = Read status byte
              smi 01h
              bz WRITE_RLE      ; 9 - Write Sun RLE data to memory
              smi 01h
              bz GET_BYTE       ; 10 = Get data byte from a VDP address
              smi 01h
              bz SET_BYTE       ; 11 = Set data byte at a VDP address
              smi 01h
              bz GET_INFO      ; 12 = Get user data from VDP memory
              smi 01h
              bz SET_INFO      ; 13 = Set user data into VDP memory
              smi 01h
              bz GET_VERSION    ; 14 = Get the driver version
              ldi 80h           
              shl               ; Set DF = 1, D = 0 for unknown request              
              rtn           

; -------------------------------------------------------------------
;            Set the Expansion Group for Video Card
; -------------------------------------------------------------------
SET_GROUP:  
#ifdef EXP_PORT
            ldi  VDP_GROUP    ; Video card is in group 1 
            str  r2
            out  EXP_PORT     ; Set group on expansion card
            dec  r2
#endif            
            rtn 

; -------------------------------------------------------------------
;            Set the Expansion Group back to default
; -------------------------------------------------------------------
RESET_GROUP:  
#ifdef EXP_PORT
              ldi  DEF_GROUP    ; All other cards are in group 0
              str  r2
              out  EXP_PORT     ; Set group on expansion card
              dec  r2
#endif              
              rtn
                                
; -------------------------------------------------------------------
;           Write a value to a TMS9118 VDP Register
; Inputs:
;   R7.1 - vdp register data value to write
;   R7.0 - register destination 
; -------------------------------------------------------------------
WRITE_VREG: ghi  r7
            str  r2
            out  VDP_REG_P
            dec  r2
            glo  r7
            str  r2
            out  VDP_REG_P
            dec  r2
            rtn

; -----------------------------------------------------------
;         Set VDP destination address for sending data
; Inputs:
;   R7 - VDP Address to set
; -----------------------------------------------------------
SET_ADDR:   glo  r7          ; r7 has address data
            str  r2
            out  VDP_REG_P   ; send low byte of address
            dec  r2
            ghi  r7
            str  r2
            out  VDP_REG_P   ; and then high byte
            dec  r2
            rtn


; -----------------------------------------------------------
;                     FILL VDP memory
; Inputs:
;   R7 -   Size of memory to fill
;   R8.0 - byte to file with
; -----------------------------------------------------------
FILL_VRAM:  glo  r8             ; get fill byte from r8.0
            str  r2
            out  VDP_DAT_P      ; VDP performs autoincrement of VRAM address  
            dec  r2
            dec  r7
            glo  r7
            bnz  FILL_VRAM
            ghi  r7
            bnz  FILL_VRAM
            rtn
            
; -----------------------------------------------------------
;        Write  data to vram 
; Inputs:
;   R7 - Size of data 
;   R8 - Buffer with data to write
; -----------------------------------------------------------
            
WRITE_DATA: lda  r8
            str  r2
            out  VDP_DAT_P     ; VDP will autoincrement VRAM address
            dec  r2
            dec  r7
            glo  r7
            bnz  WRITE_DATA
            ghi  r7
            bnz  WRITE_DATA
            rtn

; -----------------------------------------------------------
;           FILL VDP memory sequentially
; Inputs:
;   R7 -   Size of memory to fill
; Uses: 
;   R8 -  byte to fill with (00, 01, 02, ... FE, FF, 00, 01, etc.)
; -----------------------------------------------------------
FILL_SEQ:   ldi  0              ; starting index at 00
            plo  r8
NAME_IDX:   glo  r8
            str  r2
            out  VDP_DAT_P
            dec  r2
            inc  r8
            dec  r7             ; r7 has the size of memory
            glo  r7
            bnz  NAME_IDX
            ghi  r7
            bnz  NAME_IDX
            rtn
            
; -----------------------------------------------------------
;           WRITE Byte to VDP memory
; Inputs:
;   R8.0 - byte to write to memory 
; -----------------------------------------------------------
WRITE_BYTE: glo  r8             ; get byte from r8.0
            str  r2
            out  VDP_DAT_P      ; VDP performs autoincrement of VRAM address  
            dec  r2
            rtn

; -----------------------------------------------------------
;           Read VDP status byte
; Outputs:
;   D - VDP status byte 
; -----------------------------------------------------------
READ_STATUS:  inp  VDP_REG_P          ; read VDP status, D holds status byte
              rtn

; -----------------------------------------------------------
;        Write Sun RLE data to vram 
; Inputs:
;   R7 - Size of data 
;   R8 - Buffer with RLE data to write
; Uses:
;   R9 - counter for repeated bytes
; -----------------------------------------------------------            
WRITE_RLE:    lda  r8
              str  r2
              smi  080h         ; check for marker byte
              bz  RLE_MARKER    ; if not a marker just output data byte
              out  VDP_DAT_P    ; VDP will autoincrement VRAM address
              dec  r2
              br  CHK_CNT       ; check count
RLE_MARKER:   dec  r7           ; adjust count for second byte read
              lda  r8           ; get second byte
              bnz SET_RCNT      ; second byte is the repeat count or zero
              ldi  080h         ; if second byte was zero, write a literal 0x80 
              str  r2           ; store literal 0x80 in M(X)
              out  VDP_DAT_P    ; VDP will autoincrement VRAM address
              dec  r2
              br  CHK_CNT       ; check the data stream count
SET_RCNT:     plo  r9           
              ldi  00h
              phi  r9     
              inc  r9           ; set count + 1 in r9 to repeat data n+1 times
              lda  r8           ; get the third byte as the value to repeat
              str  r2           ; put third byte in M(X)
              dec  r7           ; adjust count for third byte consumed
RLE_RPT:      out  VDP_DAT_P    ; VDP will autoincrement VRAM address
              dec  r2           ; point X back to data byte
              dec  r9           ; decrement repeat count
              glo  r9           ; check repeat count in r9
              bnz RLE_RPT
              ghi  r9
              bnz RLE_RPT                          
CHK_CNT:      dec  r7
              glo  r7
              bnz WRITE_RLE
              ghi  r7
              bnz WRITE_RLE
              rtn

; -----------------------------------------------------------
;           Get VDP data byte from an address
; Inputs:
;   r7 - Address 
; Outputs:
;   D - VDP data byte read from address
; -----------------------------------------------------------
GET_BYTE:  glo  r7          ; r7 has address data
            str  r2
            out  VDP_REG_P   ; send low byte of address
            dec  r2
            ghi  r7
            str  r2
            out  VDP_REG_P   ; and then high byte
            dec  r2
            inp  VDP_DAT_P   ; read VDP vran, D holds data byte
            rtn
              
              
; -----------------------------------------------------------
;           Send Byte to VDP memory address
; Inputs:
;   R7   - address  
;   R8.0 - byte to write to memory 
; -----------------------------------------------------------
SET_BYTE:   glo  r7          ; r7 has address data
            str  r2
            out  VDP_REG_P   ; send low byte of address
            dec  r2
            ghi  r7
            str  r2
            out  VDP_REG_P   ; and then high byte
            dec  r2
            glo  r8          ; get byte from r8.0
            str  r2
            out  VDP_DAT_P   ; VDP performs autoincrement of VRAM address  
            dec  r2
            rtn

; -----------------------------------------------------------
;       Get user data values into scratch registers 
; Outputs:
;   R7 - user data value
;   R8 - user data value
; Uses: 
;   R9 - pointer to user index value 
;------------------------------------------------------------
GET_INFO:   ghi  r3           ; get hi byte from P (r3) for page
            phi  r9           ; point r9 to index Buffer
            ldi  userData.0  ; get lo byte of buffer
            plo  r9           ; r9 now points to user data buffer
            lda  r9           ; get hi byte of first value 
            phi  r7           ; store first value in r7
            lda  r9           ; get lo byte of first value
            plo  r7           ; r7 now has first value
            lda  r9           ; get hi byte of second value 
            phi  r8           ; store second value in r9
            ldn  r9           ; get lo byte of second value
            plo  r8           ; r8 now has second value
            rtn            

; -----------------------------------------------------------
;       Save user data values in scratch registers
; Inputs:
;   R7 - user word value to set
;   R8 - user word value to set
; Uses: 
;   R9 - pointer to user data values 
;------------------------------------------------------------
SET_INFO:   ghi  r3           ; get hi byte from P (r3) for page
            phi  r9           ; point r9 to index Buffer
            ldi  userData.0  ; get lo byte of buffer
            plo  r9           ; r9 now points to index buffer
            ghi  r7           ; save r7 in memory
            str  r9
            inc  r9
            glo  r7    
            str  r9
            inc  r9
            ghi  r8           ; save r8 in memory
            str  r9
            inc  r9
            glo  r8    
            str  r9
            rtn

; -----------------------------------------------------------
;       Get the driver version 
; Outputs:
;   D - version byte
; Version byte: 
;   High nibble = major number; Low nibble = minor number
;------------------------------------------------------------
GET_VERSION:  ldi 014h  ; Current version is v1.4
              rtn
            
; -----------------------------------------------------------
;           User defined values in driver memory
;------------------------------------------------------------
userData:          dw 0, 0                            
; -----------------------------------------------------------
;           ID String for memory block
;------------------------------------------------------------
VideoMarker:        db 0,'TMS9X18',0  ; string to identify memory block
END_DRIVER:         db 0, 0, 0, 0     ; twelve bytes for padding at end
                    db 0, 0, 0, 0     ; in case rounded up to entire page
                    db 0, 0, 0, 0     

;------ error handling for memory allocation and loading functions
fail:               LOAD RF, failed       ; show error message
                    CALL O_MSG
                    RTN                   ; return to Elf/OS
                    
;------ show configuration when the driver is already loaded                                   
already:            LOAD rf, present      ; show message driver already loaded
                    CALL O_MSG
                    LOAD rf, config       ; show configuration
                    CALL O_MSG
                    RTN
                    
;------ show usage message for an invalid argument
bad_arg:            LOAD rf, usage          ; print bad arg message and end
                    CALL O_MSG
                    RTN

;------ message strings
failed:             db   'Error: Video driver was *NOT* loaded.',10,13,0
loaded:             db   'TMS9x18 Video driver v1.4 loaded.',10,13,0
usage:              db   'Loads TMS9X18 video driver. Use -u option to unload the video driver.',10,13,0 
removed:            db   'Video driver unloaded.',10,13,0
present:            db   'TMS9x18 Video driver v1.4 already in memory.',10,13,0
config:             db   'Data Port: ', 030h + VDP_DAT_P,0
                    db    ' '   
                    db   'Register Port: ',030h + VDP_REG_P
                    db    10,13,'Expansion: '
#ifdef EXP_PORT
                    db   'Port ',030h + EXP_PORT
                    db    ', '
                    db   'Group ',030h + VDP_GROUP
                    db   10,13,0    ; end for above string
#else 
                    db   '(None)',10,13,0
#endif
crlf:               db   10,13,0                 
;------ define end of execution block
endrom: equ     $
