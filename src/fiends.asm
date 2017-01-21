; You did a swell job roughing up that threat, HOUND
.segment "FIXED"

FIEND_STATE_IDLE = 0
FIEND_STATE_WALKING = 1
FIEND_STATE_ATTACKING = 2
FIEND_STATE_ATTACKED = 3
FIEND_STATE_DYING = 4
FIEND_STATE_DEAD = 5

FIENDS_SPEED_START_HI = 0
FIENDS_SPEED_START_LO = $80

FIEND_CENTER = $7F
FIEND_ATK_RANGE = 30
FIEND_HIT_RANGE = 9

FIEND_LEFT_ATK_BOUND = (FIEND_CENTER + FIEND_ATK_RANGE)
FIEND_RIGHT_ATK_BOUND = (FIEND_CENTER - FIEND_ATK_RANGE)
FIEND_LEFT_HIT_BOUND = (FIEND_CENTER + FIEND_HIT_RANGE)
FIEND_RIGHT_HIT_BOUND = (FIEND_CENTER - FIEND_HIT_RANGE)

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
:
	lda #$00
	sta fiend_xpos_lo, x
	sta fiend_xpos_hi, x
	sty fiend_ypos_lo, x
	sty fiend_ypos_hi, x
	sta fiend_state, x
	sta fiend_death_cnt, x

	txa
	asl
	asl
	asl
	sta fiend_xpos_hi, x

	asl
	sta fiend_ypos_hi, x

	lda #$01

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

	rts
; ======= Per-fiend functions - specific fiend specified in X

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

	; Add fiends_speed to X
	clc
	lda fiend_xpos_lo, x
	adc fiends_speed
	sta fiend_xpos_lo, x
	lda fiend_xpos_hi, x
	adc fiends_speed+1
	sta fiend_xpos_hi, x

	; Add fiends_speed/2 to Y
	clc
	lda fiend_ypos_lo, x
	adc temp
	sta fiend_ypos_lo, x
	lda fiend_ypos_hi, x
	adc temp+1
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
	cmp #FIEND_RIGHT_ATK_BOUND
	bcs @do_atk_anim
	rts

@moving_left:
	cmp #FIEND_LEFT_HIT_BOUND
	bcc @do_hit_player
	cmp #FIEND_LEFT_ATK_BOUND
	bcc @do_atk_anim
	rts

@do_atk_anim:
	lda ppumask_config
	ora #%01000001
	sta PPUMASK
	lda #FIEND_STATE_ATTACKING
	sta fiend_state, x
	rts

@do_hit_player:
	lda ppumask_config
	ora #%10100001
	sta PPUMASK
	lda fiend_state, x
	cmp #FIEND_STATE_ATTACKED
	bne @has_not_attacked
	rts

@has_not_attacked:
	lda #FIEND_STATE_ATTACKED
	sta fiend_state, x
	; Now check if:
	; 1) the player is facing the correct direction, and that
	; 2) the player is doing a kick (kc > 0 && kc < thresh)
	lda player_dir
	eor #%00000011
	cmp fiend_dir, x
	bne @do_hurt_player

	; Player passed test #1. Now check kick counter
	lda player_kick_cnt
	beq @do_hurt_player
	cmp #KICK_THRESH
	bcs @do_hurt_player

	; Player passed all tests. Fiend is destroyed if the player hasn't already
	; done so.
	lda #FIEND_STATE_DYING
	sta fiend_state, x

@do_hurt_player:
; TODO: Hurt the player.

	rts

