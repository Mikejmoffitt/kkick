player_logic:
	jsr player_counters
	jsr player_handle_input
	jsr player_detect_collisions
	jsr player_death_proc
	rts

player_counters:
	ldx player_kick_cnt
	beq @post_kcount
	dex
	bne :+
	; If it just reached zero, reset animation stats
	jsr player_reset_animation
:
	stx player_kick_cnt

@post_kcount:
	rts

player_handle_input:
	key_isdown pad_1, btn_left
	lda player_dir
	and #%11111110
	sta player_dir
:
	key_isdown pad_1, btn_right
	lda player_dir
	ora #%00000001
	sta player_dir
:
	key_isdown pad_1, btn_up
	lda player_dir
	and #%11111101
	sta player_dir
:
	key_isdown pad_1, btn_down
	lda player_dir
	ora #%00000010
	sta player_dir
:

; Debug kick anim test
	key_down pad_1, btn_a
	jsr player_reset_animation
	lda #19
	sta player_kick_cnt
:

	rts

player_detect_collisions:
	rts

player_death_proc:
	rts