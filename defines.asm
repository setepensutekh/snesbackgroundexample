;constants for SNES


;KEY_B      = $80 ;Controller1 + 1
;KEY_Y      = $40
;KEY_SELECT = $20
;KEY_START  = $10
;KEY_UP     = $08
;KEY_DOWN   = $04
;KEY_LEFT   = $02
;KEY_RIGHT  = $01
;
;KEY_A      = $80 ;Controller1
;KEY_X      = $40
;KEY_L      = $20
;KEY_R      = $10

KEY_B      = $8000
KEY_Y      = $4000
KEY_SEL    = $2000
KEY_ST     = $1000
KEY_UP     = $0800
KEY_DOWN   = $0400
KEY_LEFT   = $0200
KEY_RRIGHT = $0100
KEY_A      = $0080
KEY_X      = $0040
KEY_L      = $0020
KEY_R      = $0010







;for tiles on a map, upper byte, in 8 bit
TILEVFLP = $80
TILEHFLP = $40
TILEPRIO = $20
TILEPAL0 = $00
TILEPAL1 = $04
TILEPAL2 = $08
TILEPAL3 = $0c
TILEPAL4 = $10
TILEPAL5 = $14
TILEPAL6 = $18
TILEPAL7 = $1c
;bits 0 and 1 are for high 2 bits of tile #
;note, low byte is the low 8 bits of tile #


;each sprite has 4 1/4 bytes
;x
;y
;tile #
;attributes
;2 bits for x (negative, if set) and sprite size

;for sprites, attribute byte, in 8 bit
SPR_CHRSET_0 = 0
SPR_CHRSET_1 = 1
SPR_PAL_0 = $00
SPR_PAL_1 = $02
SPR_PAL_2 = $04
SPR_PAL_3 = $06
SPR_PAL_4 = $08
SPR_PAL_5 = $0a
SPR_PAL_6 = $0c
SPR_PAL_7 = $0e
SPR_PRIOR_0 = $00
SPR_PRIOR_1 = $10
SPR_PRIOR_2 = $20
SPR_PRIOR_3 = $30
SPR_V_FLIP = $80
SPR_H_FLIP = $40


;for sprites, high table
SPR_POS_X = 0
SPR_NEG_X = 1
;if the upper most bit of x is set, it's as if the sprite is
;off the screen to the left
;you can scroll a sprite off the left by setting this
SPR_SIZE_SM = 0
SPR_SIZE_LG = 2
;actual dimensions of the size set by 2101, oam_size



;for bg3 priority $2105, add this to mode # 0-7
BG3_BOTTOM = 0
BG3_TOP = 8
;for bg tilesize $2105
BGALL_8  = 0
BG1_16   = $10
BG2_16   = $20
BG3_16   = $40
BG4_16   = $80
BGALL_16 = $F0


;for bg map_size, $2107, $2108, $2109, $210a
MAP_32_32 = 0
MAP_64_32 = 1
MAP_32_64 = 2
MAP_64_64 = 3


;for oam size $2101
OAM_8_16 = 0
OAM_8_32 = $20
OAM_8_64 = $40
OAM_16_32 = $60
OAM_16_64 = $80
OAM_32_64 = $a0


;vram increment after the vram write
;register $2115
VMINC1 = $80
VMINC32 = $81


;for main screen or sub screen
;$212c and $212d
SCREEN_OFF = 0
BG1ON = 1
BG2ON = 2
BG3ON = 4
BG4ON = 8
BGALLON = $0f
SPROFF = 0
SPRON = $10
ALL_ON_SCREEN = $1f


;for screen bright $2100
FULL_BR = $0f
HALF_BR = $08
NO_BR = $00
FBLANK = $80


;for interrupts controller $4200
;you will also need to cli if you want IRQs
NO_INT = 0
NMI_ON = $80
V_IRQ_ON = $20
H_IRQ_ON = $10
AUTO_JOY_ON = 1
;auto read joypads




;register list, non-standard names
;see wiki.superfamicom.org/registers for standard names
; Unless commented otherwise, all registers are accessible during f-blank and v-blank only, and are single write access

INIDISP = $2100 ; Screen Display Register, TIMING=ANY
OBSEL = $2101 ; Object Size and Character Register
OAMADDL = $2102 ; OAM address register Low
OAMADDH = $2103
OAMDATA = $2104
BGMODE = $2105 ; BACKGROUND MODE AND CHARACTER SIZE Register, TIMING=+H-BLANK
MOSAIC = $2106 ; MOSAIC Register, TIMING=+H-BLANK
BG1SC = $2107 ; BG Tilemap Address Register BG1
BG2SC = $2108
BG3SC = $2109
BG4SC = $210a
BG12NBA = $210b ; BG Character Address Registers BG1&BG2
BG34NBA = $210c

BG1HOFS = $210d ;write twice, BG1 Scroll Register X, Horizontal
BG1VOFS = $210e ;write twice, BG1 Scroll Register Y, Vertical, all TIMING=+HBLANK
;210d 210e are also mode 7 scroll registers

BG2HOFS = $210f ;write twice
BG2VOFS = $2110 ;write twice
BG3HOFS = $2111 ;write twice
BG3VOFS = $2112 ;write twice
BG4HOFS = $2113 ;write twice
BG4VOFS = $2114 ;write twice


VMINC = $2115 ; Video Port Control Register, VRAM increment register
VMADDL = $2116 ; VRAM Address Register Low
VMADDH = $2117
;register needs to be in 16 bit mode to write just to 2118
VMDATAL = $2118
VMDATAH = $2119 ; VRAM Data Write Register Low
;register in 8 bit to write to each 2118 and 2119 separately

M7SEL = $211a ; Mode 7 Select
M7A = $211b ; Mode 7 Matrix registers, a-d, x-t, TIMING=+HBLANK
M7B = $211c
M7C = $211d
M7D = $211e
M7X = $211f
M7Y = $2120

; When BGMODE is 0-6 (or during vblank in mode 7), a fast 16x8
; signed multiply is available, finishing by the next CPU cycle.
M7MCAND = $211B    ; write low then high
M7MUL = $211C      ; 8-bit factor
M7PRODL = $2134 ;result
M7PRODM = $2135
M7PRODH = $2136

CGADD = $2121 ;CGRAM Address Register, or pallette address, +HBLANK
CGDATA = $2122 ;write twice, CGRAM Data Write Register, +HBLANK

W12SEL = $2123 ; Window Mask Settings Register, +HBLANK on all window stuff
W34SEL = $2124
WOBJSEL = $2125 ; Window Object
WH0 = $2126 ; Window position registers, Window 1 Left
WH1 = $2127 ; Window 1 Right
WH2 = $2128 ; Window 2 Left
WH3 = $2129 ; Window 2 Right
WBGLOG = $212a ;Window Mask Logic register, background
WOBJLOG = $212b ; Window Mask Logic Register, Object

TM = $212c ; Screen Destination Register, Main Screen, +HBLANK all
TS = $212d ; Screen Destination Register, Sub-screen
;---o 4321, o is sprites

TMW = $212e ; Window Mask Destination Register, Main Window
TSW = $212f ; WMDR, Sub-Window

CGWSEL = $2130 ; Color Math Register, Color add select, +HBLANK all
CGADSUB = $2131 ; Color add destination
COLDATA = $2132 ; Fixed color

SETINI = $2133 ;Screen Mode Select Register, Video Mode

;$2134-36 see above


SLHV = $2137 ;Computer Latch, Software Latch Register, TIMING=ANY

OAMDATAREAD = $2138 ; OAM Data Read Register
VMDATALREAD = $2139 ; the first read is junk and you
VMDATAHREAD = $213a ; need to toss that and then start reads
CGDATAREAD = $213b
OPHCT = $213c ; Scanline Location Register Horizontal, TIMING=ANY ALL TO STAT78
OPVCT = $213d
STAT77 = $213e ;PPU Status Register
STAT78 = $213f ;PPU Status Register 2

APUIO0 = $2140 ;APU IO Register 0, TIMING=ANY
APUIO1 = $2141
APUIO2 = $2142
APUIO3 = $2143

WMDATA = $2180 ;write/dma only, WRAM Data Register
WMADDL = $2181 ;WRAM Address Register Low (24-bit presumably)
WMADDM = $2182 ; Mid
WMADDH = $2183 ; High

JOYSER0 = $4016 ;Old style Joypad Register, slower access time, only used when auto-joypad is off, Single (write), read/write
JOYSER1 = $4017 ;Many(Read), Read access

NMITIMEN = $4200 ; Interrupt Enable Register (Note: ALL internal CPU register are TIMING=ANY, i.e. all $42xx registers)
WRIO = $4201 ; IO Port Write Register

WRMPYA = $4202 ;Multiplicand register
WRMPYB = $4203
WRDIVL = $4204 ;Divisor & Dividend Register
WRDIVH = $4205
WRDIVB = $4206 ;Divisor

HTIMEL = $4207 ;IRQ Timer Register, Horizonal Low
HTIMEH = $4208
VTIMEL = $4209
VTIMEH = $420a

MDMAEN = $420b ;DMA Enable Register, enable to execute settings you've put in DMA
HDMAEN = $420c
MEMSEL = $420d ;ROM Speed Register
RDNMI = $4210 ;read once during nmi, NMI flag
TIMEUP = $4211 ;read once during irq, IRQ Flag
HVBJOY = $4212 ; Joy PPU status
RDIO = $4213 ; IO Port Read Register


RDDIVL = $4214 ;Multiplication or Divide Result Register Low
RDDIVH = $4215
RDMPYL = $4216 ;Division remainder or Multiplication Result register
RDMPYH = $4217
;multiply results for 4202-3


JOY1L = $4218 ; Controller Port Data Register Low, Pad 1
JOY1H = $4219
JOY2L = $421a ; Pad 2
JOY2H = $421b
JOY3L = $421c ;Pad 3 Low
JOY3H = $421d
JOY4L = $421e ;Pad 4 Low
JOY4H = $421f


;10's digit can be 0-7 for 8 different channels
DMAP0 = $4300 ; DMA Control Register 0, third digit is the register to control
BBAD0 = $4301 ; DMA Destination Register, e.g., $18 for VRAM low ($2118)
A1T0L = $4302 ; DMA Source Address Reg (e.g., low word from a tile set file)
A1T0H = $4303
A1B0 = $4304 ;DMA channel 0 source address bank
DAS0L = $4305 ;also hdma... DMA Size Register Low
DAS0H = $4306
;Write 1 to 420b to start DMA transfer
HDIND0L = $4305 ;HDMA Indirect Address Register Low
HDIND0H = $4306
HDIND0B = $4307 ;HDMA Indirect Address Register Bank
A2A0L = $4308
A2A0H = $4309 ;HDMA Mid Frame Table Address Register High
NTLR0 = $430a ;HDMA Line Counter Register
;420c for hdma start
