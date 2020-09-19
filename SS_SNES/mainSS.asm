.p816
.smart

.include "../Common/defines.asm"
.include "../Common/header.asm"
.include "../Common/init.asm"
.include "../Common/macros.asm"

.segment "RODATA1"

  BGPAL:
    .incbin "SSBG/SSBG2.pal"
  TILES:
    .incbin "SSBG/SSBG2.chr"
  END_TILES:

  TILEMAP:
    .incbin "SSBG/SSBG2.map"

.segment "CODE"
;enter here in f-BLANK

main:
  .a16
  .i16

    phk
    plb

;DMA from SSBG2.pal to CGRAM
    sep #$20
    stz $2121

    stz $4300 ; DMAP0 transfer mode 0, 1 reg, 1 writes
    lda #$22
    sta $4301 ;BBAD0 Dest reg, 2122= CGRAM write
    ldx #.loword(BGPAL)
    stx $4302
    lda #^BGPAL
    sta $4304
    ldx #32
    stx $4305
    lda #1
    sta $420b

;DMA from Tiles to vram
    lda #$80
    sta $2115 ; $2115 VMINC, set increment mode to 1
    ldx #$0000
    stx $2116 ; $2116 VMADDL

    lda #1
    sta $4300 ;transfer mode 1, 2 reg 1 write

    lda #$18
    sta $4301
    ldx #.loword(TILES)
    stx $4302
    lda #^TILES ; Using ^ appears to grab the bank of the binary we choose
    sta $4304
    ldx #(END_TILES-TILES)
    stx $4305
    lda #1
    sta $420b

;DMA from Tilemap to VRAM
    ldx #$6000
    stx $2116

    lda #1
    sta $4300
    lda #$18
    sta $4301
    ldx #.loword(TILEMAP)
    stx $4302
    lda #^TILEMAP
    sta $4304
    ldx #$700
    stx $4305
    lda #1
    sta $420b

  ; Set BG MODE
    lda #1 ; mode 1, tiles 8x8
    sta $2105 ;BGMODE
    stz $210b ;BG12NBA
    lda #$60
    sta $2107 ;BG1SC
    lda #$01 ;$01, BG1ON
    sta $212c ;TM, $212c

    lda #$0f ;0f, FULL_BR
    sta $2100 ;INIDISP, $2100

InfLoop:
  jmp InfLoop
