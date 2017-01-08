.segment "DATUM"
die1_dmc:
	.incbin "resources/die1.dmc"
.segment "FIXED"

mus_idx_table:
	.addr mus_kk_main

mus_kk_main:
	.include "../resources/kk_main.asm"


die2_pcm:
	.incbin "resources/die2.pcm"

; Play the music speciifed in A
play_track:
	asl
	tax
	lda mus_idx_table+1, x
	tay
	lda mus_idx_table, x
	tax
	lda #80
	jsr FamiToneInit
	lda #$00
	jsr FamiToneMusicPlay
	rts

; DPCM playback for "WHOA" sound
play_whoa_sound:
	lda #%00000000
	sta $4015
	lda #%00001111
	sta $4010
	lda #$CC
	sta $4012
	lda #$80
	sta $4013
	lda #%00010000
	sta $4015

	rts


waste_time:
	rol
	ror
	rol
	rol
	ror
	rol
	ror
	ror
	nop
	nop

	rts
; PCM playback for "ACK" sound, since DPCM doesn't really cut it here
play_ack_sound:
	jsr wait_nmi
	lda #<die2_pcm
	sta addr_ptr
	lda #>die2_pcm
	sta addr_ptr+1
	ldy #$00
	lda #19
	sta temp
@playback_top:
	lda (addr_ptr), y
	lsr
	sta $4011
	jsr waste_time
	jsr waste_time
	iny

	bne @playback_top

	add16 addr_ptr, #$FF

	dec temp
	bne @playback_top
	lda #$3F
	sta $4011
	jsr wait_nmi
	rts
