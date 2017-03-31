.segment "DATUM"
die1_dmc:
	.incbin "resources/die1.dmc"
.segment "FIXED"

mus_kk_main:
	.include "../resources/kk_main.asm"

die2_pcm:
	.incbin "resources/die2.pcm"

music_init:
	ldx #$00
	stx sound_double_cnt
	stx sound_double_delay
	rts

music_speedup:
	lda sound_double_delay
	cmp #02
	bne :+
	rts
:
	; Check if score is multiple of 16
	lda player_score_acc
	cmp #65
	bne :+
	lda #8
	sta sound_double_delay
	rts
:
	cmp #90
	bne :+
	lda #06
	sta sound_double_delay
	rts
:
	cmp #120
	bne :+
	lda #04
	sta sound_double_delay
	rts
:
	cmp #160
	bne :+
	lda #03
	sta sound_double_delay
	rts
:
	cmp #199
	bne :+
	lda #02
	sta sound_double_delay
:
	rts

; Runs music, makes it a bit faster if the game speeds up
music_logic:
	jsr misc_logic
	jsr FamiToneUpdate

	lda sound_double_delay
	bne :+
	rts
:
	lda sound_double_cnt
	bne :+
	jsr FamiToneUpdate
	jsr misc_logic
	lda sound_double_delay
	sta sound_double_cnt
	rts
:
	dec sound_double_cnt
	rts

sound_init:
	ldx #<mus_kk_main
	ldy #>mus_kk_main
	lda #$80
	jsr FamiToneInit
	rts

; Play the music speciifed in A
play_track:
	jsr FamiToneMusicPlay
	rts

stop_track:
	jsr FamiToneMusicStop
	rts

; DPCM playback for "WHOA" sound
play_whoa_sound:
	lda #%00001111
	sta $4010
	lda #$CC
	sta $4012
	lda #$80
	sta $4013
	lda #%00011111
	sta $4015
	rts

play_oof_sound:
	lda #%00001111
	sta $4010
	lda #$F6
	sta $4012
	lda #$27
	sta $4013
	lda #%00011111
	sta $4015
	rts

play_hit_sound:
	lda #%00001100
	sta temp
	lda rand_seed
	and #%00000011
	clc
	adc temp
	sta $4010
	lda #$EC
	sta $4012
	lda #$20
	sta $4013
	lda #%00011111
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
