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
	ldx player_cooldown
	beq :+
	dex
	stx player_cooldown
:
	rts

; Performs a kick move.
player_do_kick:
; Latch the player direction
	lda player_dir
	sta player_disp_dir
; Clear animation variables
	jsr player_reset_animation
; Get the kick duration in there, as well as the cooldown
	lda #PLAYER_KICK_LEN
	sta player_kick_cnt
	lda #PLAYER_COOLDOWN_LEN
	sta player_cooldown
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
	
	lda game_mode
	beq @no_manual_kick
	jsr player_do_kick
@no_manual_kick:
	lda player_dir
	eor #%00000011
	jsr fiend_spawn
:
	rts

player_detect_collisions:
	rts

player_death_proc:
	rts

player_get_hurt:
	lda player_health
	sec
	sbc #$01
	beq @died
	sta player_health
@not_dead:
	jsr play_oof_sound
	rts
@died:
; TODO: Big death sequence.
	jsr play_ack_sound
;	lda #DEATH_TIME
	lda #50
	sta fiends_gen_disable
	lda #3
	sta player_health
	rts
