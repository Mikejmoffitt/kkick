; ============================================================================
; Logic top-level for player
player_logic:
	jsr player_counters
	jsr player_handle_input
	jsr player_death_proc
	rts

; ============================================================================
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
	ldx player_death_cnt
	beq :+
	dex
	stx player_death_cnt
:
	ldx player_hurt_cnt
	beq :+
	dex
	stx player_hurt_cnt
:
	rts

; ============================================================================
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

; ============================================================================
; See what's good with the d-pad
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

	lda game_mode
	beq :+
	key_down pad_1, btn_a
	
	jsr player_do_kick
:
	rts

; ============================================================================
player_sub_life:
	; Subtract a life
	lda player_lives
	sec
	sbc #$01
	sta player_lives

	; Restore health if lives are nonzero
	beq :+
	lda #3
	sta player_health
	lda #00
	jsr play_track
:
	rts

; ============================================================================
player_death_proc:
	lda player_death_cnt
	cmp #ACK_TIME
	bne :+
	jsr play_ack_sound
	rts
:

	; Right before the death count reaches zero, sub a life, set up health.
	lda player_death_cnt
	cmp #1
	bne :+
	lda #GAME_START_DELAY
	sta game_start_counter
	jsr player_reset_animation
	jsr player_sub_life
	lda #$00
	sta player_death_cnt
:
	
	rts

; ============================================================================
player_get_hurt:
	lda player_death_cnt
	beq :+
	rts
:
	lda player_health
	sec
	sbc #$01
	sta player_health
	beq @died
	lda #HURT_TIME
	sta player_hurt_cnt
@not_dead:
	jsr play_oof_sound
	rts
@died:
	lda #DEATH_TIME
	sta fiends_gen_disable
	sta player_death_cnt
	lda #$00
	sta player_hurt_cnt
	jsr fiends_clear
	jsr stop_track
	jsr play_whoa_sound
	jsr player_reset_animation
	rts
