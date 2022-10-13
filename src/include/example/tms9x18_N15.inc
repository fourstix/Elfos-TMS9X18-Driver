; Kernel vector for Video Driver
O_VIDEO:            equ 0456h

; set these values to match your TMS9X18 Video Card settings
#define VDP_DAT_P     1       ; data port
#define VDP_REG_P     5       ; register and address port

; comment out this next line if not using an 1802-Mini exapnder card
;#define EXP_PORT      1       ; 1802-Mini expander card group port

; these constants are ignored unless EXP_PORT is defined
#define VDP_GROUP     1       ; 1802-Mini video card group
#define DEF_GROUP     0       ; default group for 1802-Mini
