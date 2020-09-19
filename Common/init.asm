;init code for SNES
;much borrowed from Damian Yerrick

.p816
.smart


.segment "CODE"
NMI:
	pha
	lda RDNMI	; it is required to read this register
				; in the NMI handler
	pla
	rti
IRQ:
	pha
	lda TIMEUP	; it is required to read this register
				; in the IRQ handler
	pla
IRQ_end:
	rti


RESET:
	sei			; turn off IRQs
	clc
	xce			; turn off 6502 emulation mode
	rep #$38 	;rep #$30 and clear decimal mode.
	ldx #$1fff
	txs			; set the stack pointer
	phk
	plb 		;set b to current bank, 00

; Initialize the CPU I/O registers to predictable values
	lda #$4200
	tcd			; temporarily move direct page to S-CPU I/O area
	lda #$FF00
	sta $00
	stz $00
	stz $02
	stz $04
	stz $06
	stz $08
	stz $0A
	stz $0C

; Initialize the PPU registers to predictable values
	lda #$2100
	tcd			 ; temporarily move direct page to PPU I/O area

; first clear the regs that take a 16-bit write
	lda #$0080
	sta $00		 ; Enable forced blank
	stz $02
	stz $05
	stz $07
	stz $09
	stz $0B
	stz $16
	stz $24
	stz $26
	stz $28
	stz $2A
	stz $2C
	stz $2E
	ldx #$0030
	stx $30		 ; Disable color math
	ldy #$00E0
	sty $32		 ; Clear red, green, and blue components of COLDATA
				 ; also 0 to 2133, normal video at 224 pixels high

; now clear the regs that need 8-bit writes
	sep #$20
	sta $15		 ; still $80: Inc VRAM pointer after high byte write
	stz $1A
	stz $21
	stz $23 ;window, 24,25 above

; The scroll registers $210D-$2114 need double 8-bit writes
	.repeat 8, I
		stz $0D+I
		stz $0D+I
	.endrepeat

; As do the mode 7 registers, which we set to the identity matrix
	; [ $0100	$0000 ]
	; [ $0000	$0100 ]
	lda #$01
	stz $1B
	sta $1B
	stz $1C
	stz $1C
	stz $1D
	stz $1D
	stz $1E
	sta $1E
	stz $1F
	stz $1F
	stz $20
	stz $20




;clear all RAM

	rep #$30
	lda #$0000
	tcd				; return direct page to real zero page

wram_clear: 		;data bank is 7e
	tax 			; a and x are zero
@loop:
	sta f:$7e0000,x
	sta f:$7f0000,x
	inx
	inx
	bne @loop

	jsr Clear_Palette
	jsr Clear_Oam
	jsr Clear_VRAM

	sep #$20
	lda #1
	sta $420d ;fastROM

	rep #$30
	jml main ;should jump into the $80 bank, fast ROM

;we are still in forced blank, main code will have to turn the screen on




Clear_Palette:
	php
	sep #$20
	rep #$10
	stz $2121 ;CGADD Palette Address $2121
	ldx #256
@loop:
	stz $2122 ;CGDATA Palette Data $2122
	stz $2122 ;write twice
	dex
	bne @loop
	plp
	rts


Clear_Oam:
	php
	sep #$20
	rep #$10
	stz OAMADDL
	stz OAMADDH
	lda #224 	;set all y values to 224, off screen
				;works with screen in 224 mode and sprites
				;smaller than 64x64
	ldx #512
@loop:
	sta OAMDATA ;$2104
	dex
	bne @loop
	ldx #32
@loop2:
	stz OAMDATA ;$2104
	dex
	bne @loop2

	plp
	rts


Clear_VRAM:
	php
	sep #$20
	lda #$80
	sta $2115 ;VRAM increment mode +1
	rep #$30
	stz $2116 ;VMADDL VRAM Address $2116
	ldx #$8000
@loop:
	stz $2118 ;VMDATAL $2118
	dex
	bne @loop
	plp
	rts
