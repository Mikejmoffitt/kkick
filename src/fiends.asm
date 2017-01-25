; You did a swell job roughing up that threat, HOUND
.segment "FIXED"

FIEND_STATE_IDLE = 0
FIEND_STATE_WALKING = 1
FIEND_STATE_ATTACKING = 2
FIEND_STATE_ATTACKED = 3
FIEND_STATE_DYING = 4
FIEND_STATE_DEAD = 5

FIENDS_SPEED_START_HI = 3
FIENDS_SPEED_START_LO = 24

FIEND_CENTER = $7F
FIEND_ATK_RANGE = 23 ; Distance from player when fiend starts attack anim
FIEND_KICK_RANGE = 16 ; Distance from player when fiend can be kicked
FIEND_HIT_RANGE = 13 ; DIstance from player where fiend hurts player

FIEND_LEFT_ATK_BOUND =   (FIEND_CENTER + FIEND_ATK_RANGE)
FIEND_RIGHT_ATK_BOUND =  (FIEND_CENTER - FIEND_ATK_RANGE)
FIEND_LEFT_KICK_BOUND =  (FIEND_CENTER + FIEND_KICK_RANGE)
FIEND_RIGHT_KICK_BOUND = (FIEND_CENTER - FIEND_KICK_RANGE)
FIEND_LEFT_HIT_BOUND =   (FIEND_CENTER + FIEND_HIT_RANGE)
FIEND_RIGHT_HIT_BOUND =  (FIEND_CENTER - FIEND_HIT_RANGE)

FIEND_SPAWN_DISTANCE = 80
FIEND_SPAWN_LEFT = ($7F - FIEND_SPAWN_DISTANCE)
FIEND_SPAWN_RIGHT = ($7F + FIEND_SPAWN_DISTANCE)
FIEND_SPAWN_TOP = ($70 - FIEND_SPAWN_DISTANCE/2)
FIEND_SPAWN_BOTTOM = ($70 + FIEND_SPAWN_DISTANCE/2)

KICK_THRESH = 10

; Metasprite definitions
fiend_walk_fwd1:
	.byte	<-28, $59, %00000000, <-4
	.byte	<-20, $68, %00000000, <-8
	.byte	<-20, $69, %00000000, 0
	.byte	<-12, $78, %00000000, <-8
	.byte	<-12, $79, %00000000, 0
	.byte	MAP_END

fiend_walk_fwd2:
	.byte	<-28, $59, %00000000, <-4
	.byte	<-24, $6A, %00000000, <-6
	.byte	<-16, $7A, %00000000, <-8
	.byte	<-16, $7B, %00000000, 0
	.byte	<-8, $8A, %00000000, <-8
	.byte	<-8, $8B, %00000000, 0
	.byte	MAP_END

fiend_walk_fwd3:
	.byte	<-32, $58, %00000000, <-3
	.byte	<-24, $6C, %00000000, <-4
	.byte	<-16, $7C, %00000000, <-5
	.byte	<-8,  $8C, %00000000, <-4
	.byte	MAP_END

fiend_walk_fwd4:
	.byte	<-32, $58, %00000000, <-3
	.byte	<-24, $6E, %00000000, <-4
	.byte	<-16, $7E, %00000000, <-6
	.byte	<-8,  $8E, %00000000, <-8
	.byte	<-8,  $8F, %00000000, 0
	.byte	MAP_END

fiend_walk_back3:
	.byte	<-32, $58, %00000000, <-3
	.byte	<-24, $9C, %00000000, <-4
	.byte	<-16, $AC, %00000000, <-5
	.byte	<-8,  $BC, %00000000, <-4
	.byte	MAP_END

fiend_walk_back4:
	.byte	<-32, $58, %00000000, <-3
	.byte	<-24, $9E, %00000000, <-4
	.byte	<-16, $AE, %00000000, <-6
	.byte	<-8,  $BE, %00000000, <-8
	.byte	<-8,  $BF, %00000000, 0
	.byte	MAP_END


; ----- Exported fiend functions -----
; Clear out state for fiends
fiends_init:

	lda #FIENDS_SPEED_START_HI
	sta fiends_speed+1
	lda #FIENDS_SPEED_START_LO
	sta fiends_speed

	ldy #$00
	lda #$00
	sty fiends_gen_cnt

	dey
	ldx #NUM_FIENDS
	lda #$00
:
		sta fiend_xpos_lo, x
		sta fiend_xpos_hi, x
		sty fiend_ypos_lo, x
		sty fiend_ypos_hi, x
		sta fiend_state, x
		sta fiend_death_cnt, x
		sta fiend_dir, x
		sta fiend_state, x
	dex
	bne :-

	rts

; Game logic top-level
fiends_logic:
	ldx #NUM_FIENDS
:
		lda fiend_state, x
		beq @skip_fiend_proc

		jsr fiend_move
		jsr fiend_detect_player_coll

@skip_fiend_proc:
	dex
	bne :-
	rts

; Render top-level
fiends_render:
	ldx #NUM_FIENDS
:
		lda fiend_state, x
		beq @skip_fiend_proc

		jsr fiend_render
@skip_fiend_proc:
	dex
	bne :-
	rts

; Spawn fiend in direction specified in A
fiend_spawn:
	and #%00000011
	sta temp
	ldx #NUM_FIENDS
:

		lda fiend_state, x
		bne @fiend_ng
		; Idle fiend found. Initialize the one fiend and get out.
		lda temp
		jsr fiend_setup

		rts
@fiend_ng:
	dex
	bne :-
	rts


; ======= Per-fiend internal functions - specific fiend specified in X

; Initializes the fiend in X, and spawns in direction in A
fiend_setup:
	sta fiend_dir, x
	lda #$00
	sta fiend_death_cnt, x
	sta fiend_xpos_lo, x
	sta fiend_ypos_lo, x
	lda #FIEND_STATE_WALKING
	sta fiend_state, x

; Pick left or right side
@choose_x_spot:
	lda fiend_dir, x
	and #%00000001
	bne @facing_right
@facing_left:
	lda #FIEND_SPAWN_RIGHT
	jmp @post_x
@facing_right:
	lda #FIEND_SPAWN_LEFT
@post_x:
	sta fiend_xpos_hi, x

	lda fiend_dir, x
	and #%00000010
	bne @facing_down
@facing_up:
	lda #FIEND_SPAWN_BOTTOM
	jmp @post_y
@facing_down:
	lda #FIEND_SPAWN_TOP
@post_y:
	sta fiend_ypos_hi, x
	rts

; Renders fiend X based on state
fiend_render:

; Get coordinates, stick in A and Y
	ldy fiend_ypos_hi, x
	lda fiend_xpos_hi, x
	sta temp

; Back up X so fiend count isn't corrupted
	txa
	pha

; TODO: Pull animation frame from anim variables

	; Get fiend direction, mask for flipping
	lda fiend_dir, x
	and #$01
	eor #$01
	sta temp3

	; Choose starting sprite num

	; Get frame address
	lda #<fiend_walk_fwd2
	sta addr_ptr
	lda #>fiend_walk_fwd2
	sta addr_ptr+1
	ldx temp
	lda #$00
	jsr draw_metasprite

; Restore X for fiend count
	pla
	tax
	rts

; Runs the movement logic for fiend X
fiend_move:
	; Get fiends_speed / 2 in temp
	lda fiends_speed+1
	lsr a
	sta temp+1
	lda fiends_speed
	ror a
	sta temp

	; Check if the fiend is going left or right
	lda fiend_dir, x
	and #%00000001
	beq @facing_left

@facing_right:
	; Add fiends_speed to X
	clc
	lda fiend_xpos_lo, x
	adc fiends_speed
	sta fiend_xpos_lo, x
	lda fiend_xpos_hi, x
	adc fiends_speed+1
	sta fiend_xpos_hi, x
	jmp @do_y_addition

@facing_left:
	sec
	lda fiend_xpos_lo, x
	sbc fiends_speed
	sta fiend_xpos_lo, x
	lda fiend_xpos_hi, x
	sbc fiends_speed+1
	sta fiend_xpos_hi, x

@do_y_addition:
	lda fiend_dir, x
	and #%00000010
	beq @facing_up

@facing_down:
	; Add fiends_speed/2 to Y
	clc
	lda fiend_ypos_lo, x
	adc temp
	sta fiend_ypos_lo, x
	lda fiend_ypos_hi, x
	adc temp+1
	sta fiend_ypos_hi, x

	rts
@facing_up:
	sec
	lda fiend_ypos_lo, x
	sbc temp
	sta fiend_ypos_lo, x
	lda fiend_ypos_hi, x
	sbc temp+1
	sta fiend_ypos_hi, x

	rts

; Detect if fiend X is near the player, and transition to the attack state or
; damage the player if the player is not kicking and facing them
fiend_detect_player_coll:
	lda fiend_state, x
	cmp #FIEND_STATE_DYING
	bne @not_dying
	rts

@not_dying:
	lda fiend_xpos_hi, x
	bmi @moving_left

@moving_right:
	cmp #FIEND_RIGHT_HIT_BOUND
	bcs @do_hit_player
	cmp #FIEND_RIGHT_KICK_BOUND
	bcs @do_get_kicked
	cmp #FIEND_RIGHT_ATK_BOUND
	bcs @do_atk_anim
	rts

@moving_left:
	cmp #FIEND_LEFT_HIT_BOUND
	bcc @do_hit_player
	cmp #FIEND_LEFT_KICK_BOUND
	bcc @do_get_kicked
	cmp #FIEND_LEFT_ATK_BOUND
	bcc @do_atk_anim
	rts

; Fiend begins an attack animation
@do_atk_anim:
	;lda ppumask_config
	;ora #%01000001
	;sta PPUMASK
	lda #FIEND_STATE_ATTACKING
	sta fiend_state, x
	rts

; Fiend is close enough to be hurt by the player
@do_get_kicked:
	;lda ppumask_config
	;ora #%00100001
	;sta PPUMASK
	jsr fiend_eval_get_kicked

	; Facing the player?
	lda fiend_dir, x
	eor #%00000011
	cmp player_dir
	beq :+
	rts
:
	; If so, ahve the player begin a kick
	jsr player_trigger_kick_anim
	rts

; Fiend hurts the player.
@do_hit_player:
	;lda ppumask_config
	;ora #%10000001
	;sta PPUMASK
	jsr fiend_eval_get_kicked
; TODO: Check if fiend has been killed, and abort here if so.
	lda fiend_state, x
	cmp #FIEND_STATE_ATTACKED
	bne @has_not_attacked
	jsr fiend_die
	rts

@has_not_attacked:
	lda #FIEND_STATE_ATTACKED
	sta fiend_state, x
; TODO: Inflict damage here - play sound, hurt anim, etc.
	; The fiend just disappears at this point.
	lda #FIEND_STATE_IDLE
	sta fiend_state, x

	dec player_health

	rts

fiend_eval_get_kicked:
; Mode A: Player is facing the fiend
@mode_a:
	lda fiend_dir, x
	eor #%00000011
	cmp player_dir
	beq @is_facing_player
	rts

@is_facing_player:
; Mode B: Player must also be kicking at the right time manually
	lda game_mode
	beq fiend_die
	rts
@mode_b:
	; Check that kick_cnt != 0 && kick_cnt <= KICK_THRESH
	lda player_kick_cnt
	beq :+
	cmp #KICK_THRESH
	bcc fiend_die
:
	rts

; Kill off the dude
fiend_die:
; TODO: Initialize dying animation instead of just voiping away.
	lda #FIEND_STATE_IDLE
	sta fiend_state, x
	jsr score_add_point

	rts
