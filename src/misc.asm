misc_init:
	lda #$00
	sta temp
	sta temp2
	sta temp3
	sta temp4
	sta temp5
	sta temp6
	sta temp7
	sta temp8
	sta addr_ptr
	sta addr_ptr+1
	sta pad_1
	sta pad_1_prev
	sta pad_2
	sta pad_2_prev
	sta vblank_flag
	sta FT_TEMP
	sta FT_TEMP+1
	sta FT_TEMP+2

; Clear out famitone RAM
	ldx #$FF
	lda #$00
:
	sta FT_BASE_ADR, x
	dex
	bne :-

; Build button comparison table
	lda #$80
	ldx #$00
@build_controller_table:
	sta button_table, x
	inx
	lsr
	bne @build_controller_table

; Set a default for scroll
	lda #$00
	sta xscroll
	sta yscroll+1
	sta xscroll+1
	lda #$E0
	sta yscroll
	rts


misc_counters:
	ldx game_start_counter
	beq :+
	dex
	stx game_start_counter
:

	rts

misc_paused_proc:
@paused_top:

	jsr read_joy_safe
	key_down pad_1, btn_start
	rts
:
	jsr wait_nmi
	lda ppumask_config
	ora #%11100000
	sta PPUMASK
	jsr FamiToneUpdate
	jmp @paused_top

	rts

misc_pause:
	key_down pad_1, btn_start
	; Stay here until start is hit again
	jsr misc_paused_proc
:
	rts


misc_logic:
	jsr misc_counters
	jsr misc_pause
	rts

misc_render:

; Draw "READY!" if the game has not begun
	lda game_start_counter
	beq :+
	lda player_anim_frame
	eor #%00000001
	beq :+
	lda #$00
	sta temp3
	lda #<misc_mapping_ready
	sta addr_ptr
	lda #>misc_mapping_ready
	sta addr_ptr+1
	ldx #$80
	ldy #$80
	jsr draw_metasprite
:

	rts
; ============================================================================
; Show "Game Over" for three seconds
misc_gameover:
	lda #$02
	jsr play_track
	jsr spr_init
	jsr wait_nmi
	ppu_disable
	spr_dma
	ldx #$FF
@wait_top:
	jsr read_joy_safe
	txa
	pha

	lda #$00
	sta temp3
	lda #<misc_mapping_gameover
	sta addr_ptr
	lda #>misc_mapping_gameover
	sta addr_ptr+1
	ldx #$80
	ldy #$78
	jsr draw_metasprite

	jsr FamiToneUpdate
	
	jsr wait_nmi
	ppu_disable
	ppu_load_scroll xscroll, yscroll
	spr_dma
	ppu_enable

	pla
	tax
	dex
	bne @wait_top

	ldx #80
@blank_wait:
	txa
	pha
	jsr FamiToneUpdate

	jsr wait_nmi

	pla
	tax
	dex
	bne @blank_wait

	rts

misc_mapping_gameover:
	.byte	<-8,  $C9, %00000011, <-36
	.byte	<-8,  $CC, %00000011, <-28
	.byte	<-8,  $C8, %00000011, <-20
	.byte	<-8,  $CB, %00000011, <-12
	.byte	<-8,  $C7, %00000011, 4
	.byte	<-8,  $C6, %00000011, 12
	.byte	<-8,  $CB, %00000011, 20
	.byte	<-8,  $CA, %00000011, 28
	.byte	MAP_END

misc_mapping_ready:
	.byte	<-8,  $CA, %00000011, <-24
	.byte	<-8,  $CB, %00000011, <-16
	.byte	<-8,  $CC, %00000011, <-8
	.byte	<-8,  $CD, %00000011, 0
	.byte	<-8,  $CE, %00000011, 8
	.byte	<-8,  $CF, %00000011, 16
	.byte	MAP_END
