; You did a swell job roughing up that threat, HOUND
.segment "FIXED"

FIEND_STATE_IDLE = 0
FIEND_STATE_WALKING = 1
FIEND_STATE_ATTACKING = 2
FIEND_STATE_ATTACKED = 3
FIEND_STATE_DYING = 4
FIEND_STATE_DEAD = 5

FIENDS_SPEED_START_HI = 0
FIENDS_SPEED_START_LO = 128

FIENDS_SPEED_MAX_HI = 7

FIEND_CENTER = $7F
FIEND_ATK_RANGE = 29 ; Distance from player when fiend starts attack anim
FIEND_KICK_RANGE = 23 ; Distance from player when fiend can be kicked
FIEND_HIT_RANGE = 9 ; DIstance from player where fiend hurts player

FIEND_LEFT_ATK_BOUND =   (FIEND_CENTER + FIEND_ATK_RANGE)
FIEND_RIGHT_ATK_BOUND =  (FIEND_CENTER - FIEND_ATK_RANGE)
FIEND_LEFT_KICK_BOUND =  (FIEND_CENTER + FIEND_KICK_RANGE)
FIEND_RIGHT_KICK_BOUND = (FIEND_CENTER - FIEND_KICK_RANGE)
FIEND_LEFT_HIT_BOUND =   (FIEND_CENTER + FIEND_HIT_RANGE)
FIEND_RIGHT_HIT_BOUND =  (FIEND_CENTER - FIEND_HIT_RANGE)

FIENDS_GEN_PERIOD_DEFAULT = 40
FIENDS_GEN_PERIOD_MIN = 10

FIEND_SPAWN_DISTANCE = 80
FIEND_SPAWN_LEFT = ($7F - FIEND_SPAWN_DISTANCE)
FIEND_SPAWN_RIGHT = ($7F + FIEND_SPAWN_DISTANCE)
FIEND_SPAWN_TOP = ($70 - FIEND_SPAWN_DISTANCE/2)
FIEND_SPAWN_BOTTOM = ($70 + FIEND_SPAWN_DISTANCE/2)

FIEND_ANIM_PERIOD = 4
FIEND_ANIM_LEN = 6

KICK_THRESH = 10

STAT_TABLE_ACC_PERIOD = 6

TABLE_END = $FFFF

; Format is speed_lo, speed_hi, spawn period.
fiends_stat_table:
	.word	$0100
	.byte	40
	;------------
	.word	$010B
	.byte	38
	;------------
	.word	$0117
	.byte	36
	;------------
	.word	$011F
	.byte	35
	;------------
	.word	$0124
	.byte	34
	;------------
	.word	$012E
	.byte	34
	;------------
	.word	$0131
	.byte	32
	;------------
	.word	$0135
	.byte	31
	;------------
	.word	$0138
	.byte	30
	;------------
	.word	$013B
	.byte	29
	;------------
	.word	$0140
	.byte	27
	;------------
	.word	$0143
	.byte	26
	;------------
	.word	$013F
	.byte	29
	;------------
	.word	$0146
	.byte	27
	;------------
	.word	$014A
	.byte	26
	;------------
	.word	$014D
	.byte	25
	;------------
	.word	$0150
	.byte	25
	;------------
	.word	$0159
	.byte	25
	;------------
	.word	$0160
	.byte	24
	;------------
	.word	$016E
	.byte	24
	;------------
	.word	$016F
	.byte	23
	;------------
	.word	$0170
	.byte	23
	;------------
	.word	$0176
	.byte	22
	;------------
	.word	$018E
	.byte	22
	;------------
	.word	$0195
	.byte	21
	;------------
	.word	$01AF
	.byte	21
	;------------
	.word	$01C3
	.byte	21
	;------------
	.word	$01E0
	.byte	20
	;------------
	.word	$0200
	.byte	20
	;------------
	.word	$0210
	.byte	19
	;------------
	.word	$021D
	.byte	18
	;------------
	.word	$0220
	.byte	17
	;------------
	.word	$0222
	.byte	16
	;------------
	.word	$0223
	.byte	15
	;------------
	.word	$0210
	.byte	14
	;------------
	.word	$020F
	.byte	14
	;------------
	.word	$0200
	.byte	15
	;------------
	.word	$0200
	.byte	16
	;------------
	.word	$0200
	.byte	15
	;------------
	.word	$020F
	.byte	14
	;------------
	.word	$0240
	.byte	13
	;------------
	.word	$0240
	.byte	12
	;------------
	.word	$0240
	.byte	13
	;------------
	.word	$0200
	.byte	15
	;------------
	.word	$0250
	.byte	13
	;------------
	.word	$0270
	.byte	12
	;------------
	.word	$0283
	.byte	12
	;------------
	.word	$02A3
	.byte	11
	;------------
	.word	$0270
	.byte	12
	;------------
	.word	$0200
	.byte	15
	;------------
	.word	$0223
	.byte	16
	;------------
	.word	$0220
	.byte	17
	;------------
	.word	$0200
	.byte	16
	;------------
	.word	$020F
	.byte	14
	;------------
	.word	$0270
	.byte	12
	;------------
	.word	$0283
	.byte	11
	;------------
	.word	$029F
	.byte	14
	;------------
	.word	$02BF
	.byte	16
	;------------
	.word	$02CF
	.byte	18
	;------------
	.word	$0283
	.byte	19
	;------------
	.word	$0263
	.byte	19
	;------------
	.word	$02AF
	.byte	14
	;------------
	.word	$02D4
	.byte	12
	;------------
	.word	$0300
	.byte	11
	;------------
	.word	$0300
	.byte	10
	;------------
	.word	TABLE_END

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

fiend_walk_back1:
	.byte	<-28, $5A, %00000000, <-4
	.byte	<-20, $98, %00000000, <-8
	.byte	<-20, $99, %00000000, 0
	.byte	<-12, $A8, %00000000, <-8
	.byte	<-12, $A9, %00000000, 0
	.byte	MAP_END

fiend_walk_back2:
	.byte	<-28, $5A, %00000000, <-4
	.byte	<-24, $9A, %00000000, <-6
	.byte	<-16, $AA, %00000000, <-8
	.byte	<-16, $AB, %00000000, 0
	.byte	<-8, $BA, %00000000, <-8
	.byte	<-8, $BB, %00000000, 0
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

fiend_anim_fwd:
	.addr fiend_walk_fwd1
	.addr fiend_walk_fwd2
	.addr fiend_walk_fwd3
	.addr fiend_walk_fwd4
	.addr fiend_walk_fwd3
	.addr fiend_walk_fwd2

fiend_anim_back:
	.addr fiend_walk_back1
	.addr fiend_walk_back2
	.addr fiend_walk_back3
	.addr fiend_walk_back4
	.addr fiend_walk_back3
	.addr fiend_walk_back2

; ----- Exported fiend functions -----
; ============================================================================
; Clear out state for fiends
fiends_init:
	ldy #$00
	ldx #$00
	lda #<fiends_stat_table
	sta addr_ptr
	lda #>fiends_stat_table
	sta addr_ptr+1

; Set defaults for speed, etc.
	ldy #$00
	lda (addr_ptr), y
	sta fiends_speed
	iny
	lda (addr_ptr), y
	sta fiends_speed+1
	iny
	lda (addr_ptr), y
	sta fiends_gen_period

; Now calculate the length of the stats table
	ldx #$00
@len_calc_top:
	lda (addr_ptr), y
	cmp #$FF
	bne :+
	iny
	lda (addr_ptr), y
	cmp #$FF
	beq @found_len
:
	inx
	ldy #$00
	add16 addr_ptr, #3
	clc
	bcc @len_calc_top

@found_len:
	dex
	stx fiends_stat_table_len

; Clear out some other basic defaults
	lda #$00
	sta fiends_gen_cnt
	sta fiends_gen_disable
	sta fiends_stat_table_idx
	sta fiends_stat_idx_acc
	jsr fiends_clear
	rts

; ============================================================================
; Get all fiends inactive and off the playfield
fiends_clear:
	ldx #NUM_FIENDS
	lda #$00
:
		sta fiend_xpos_lo, x
		sta fiend_xpos_hi, x
		sta fiend_ypos_lo, x
		sta fiend_ypos_hi, x
		sta fiend_state, x
		sta fiend_death_cnt, x
		sta fiend_dir, x
		sta fiend_anim_frame, x
		sta fiend_anim_delay, x
		dex
	bne :-
	rts

; ============================================================================
; Game logic top-level
fiends_logic:

	jsr fiends_gen_proc

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

; ============================================================================
; Responsible for fiend spawning.
fiends_gen_proc:
; Check if spawning has been suspended.
	ldx fiends_gen_disable
	beq :+
	dex
	stx fiends_gen_disable
	rts
:

; If the game is starting, or the player is dead, disable spawning
	lda game_start_counter
	ora player_death_cnt
	beq :+
	lda #2
	sta fiends_gen_disable
	rts
:

; Countdown until it's time to spawn another enemy.
	ldx fiends_gen_cnt
	beq :+
	dex
	stx fiends_gen_cnt
	rts
:

	; Reset the spawn time counter
	lda fiends_gen_period
	sta fiends_gen_cnt

; Generate a random number
	ldx #$08
	lda rand_seed
:
	asl
	rol rand_seed+1
	bcc :+
	eor #$2D
:
	dex
	bne :--
	sta rand_seed


; If the number is between 0 and 20, the fiend doesn't spawn.
	cmp #20
	bcs @not_null_spawn
	rts
@not_null_spawn:
	cmp #54
	bcc @spawn_topleft
	cmp #112
	bcc @spawn_topright
	cmp #173
	bcc @spawn_bottomleft
@spawn_bottomright:
	lda #$03
	jmp fiend_spawn
@spawn_topleft:
	lda #$00
	jmp fiend_spawn
@spawn_topright:
	lda #$01
	jmp fiend_spawn
@spawn_bottomleft:
	lda #$02
	jmp fiend_spawn
@no_spawn:
	rts

; ============================================================================
; Based on player progress, speeds up the game.
fiends_speed_inc_proc:

; Determine and accumulate stat table index if appropriate
	ldy fiends_stat_idx_acc
	iny
	sty fiends_stat_idx_acc

	; Should we increment the index?
	cpy #STAT_TABLE_ACC_PERIOD
	bne @load_stats ; If not, skip and load stats.
	lda $5555

	; Increment stat table index
	ldy fiends_stat_table_idx
	iny
	cpy fiends_stat_table_len
	beq :+
	sty fiends_stat_table_idx
:
	; Clear out stat table accumulator
	ldy #$00
	sty fiends_stat_idx_acc

@load_stats:

; Load stats from table index
	lda #<fiends_stat_table
	sta addr_ptr
	lda #>fiends_stat_table
	sta addr_ptr+1

	; Add 3x the offset to the address pointer
	add16 addr_ptr, fiends_stat_table_idx
	add16 addr_ptr, fiends_stat_table_idx
	add16 addr_ptr, fiends_stat_table_idx

; Get speed low byte
	ldy #$00
	lda (addr_ptr), y
	sta fiends_speed
; And high byte
	iny
	lda (addr_ptr), y
	sta fiends_speed+1
; Get spawn counter period
	iny
	lda (addr_ptr), y
	sta fiends_gen_period

	rts

; ============================================================================
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
		jsr fiends_speed_inc_proc

		rts
@fiend_ng:
	dex
	bne :-
	rts

; ============================================================================
; Render top-level
fiends_render:
	ldx #NUM_FIENDS
:
		lda fiend_state, x
		beq @skip_fiend_proc

		jsr fiend_animate
		jsr fiend_draw
@skip_fiend_proc:
	dex
	bne :-
	rts

; ============================================================================
; ============================================================================
; ============================================================================
; ============================================================================
;
;       Per-fiend internal functions - specific fiend specified in X
;
; ============================================================================
; ============================================================================
; ============================================================================

; ============================================================================
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

; ============================================================================
; Processes animation sequence for a fiend
fiend_animate:
	lda fiend_anim_delay, x
	beq @next_frame
	sec
	sbc #$01
	sta fiend_anim_delay, x
	rts

@next_frame:
	lda #FIEND_ANIM_PERIOD
	sta fiend_anim_delay, x
	lda fiend_anim_frame, x
	clc
	adc #$01
	cmp #(FIEND_ANIM_LEN-1)
	bne @no_phase_reset
	lda #$00

@no_phase_reset:
	sta fiend_anim_frame, x
	rts

; ============================================================================
; Renders fiend X based on state
fiend_draw:

; Determine whether fiend is going forwards or backwards
	lda fiend_dir, x
	and #%00000010
	beq @facing_back

; Get animation script
	lda #<fiend_anim_fwd
	sta temp
	lda #>fiend_anim_fwd
	sta temp+1
	jmp @choose_frame

@facing_back:
	lda #<fiend_anim_back
	sta temp
	lda #>fiend_anim_back
	sta temp+1
	; Fall through to @choose_frame

; Frame offset within struct
@choose_frame:
	lda fiend_anim_frame, x
	asl
	tay
	
; Fetch address of animation frame
	lda (temp), y
	sta addr_ptr
	iny
	lda (temp), y
	sta addr_ptr+1

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

	; Get frame address
	ldx temp
	lda #$00
	jsr draw_metasprite

; Restore X for fiend count
	pla
	tax
	rts

; ============================================================================
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

; ============================================================================
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
	lda player_cooldown
	beq :+
	rts
:
	jsr fiend_eval_get_kicked

	; Facing the player?
	lda fiend_dir, x
	eor #%00000011
	cmp player_dir
	beq :+
	rts
:
	; If so, have the player begin a kick
	jsr player_do_kick
	jsr play_hit_sound
	rts

; Fiend hurts the player.
@do_hit_player:
	;lda ppumask_config
	;ora #%10000001
	;sta PPUMASK
; TODO: Maybe ensure that the guy is not dead here?
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

	jsr player_get_hurt

	rts

; ============================================================================
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
