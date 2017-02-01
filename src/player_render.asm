
; Animation and rendering related player code

; Responsible for drawing both players to the screen based on state structs.
; No particular pre-conditions; this is a wrapper for the various subroutines
; which draw both players to the screen.
player_render:
	jsr player_latch_dir
	jsr player_choose_animation
	jsr player_choose_mapping
	jsr player_animate
	jsr player_draw
	rts

; Latch the player's display direction if not in a special animation
player_latch_dir:
	lda player_kick_cnt
	bne :+
	lda player_death_cnt
	bne :+
	lda player_hurt_cnt
	bne :+
	ldx player_dir
	stx player_disp_dir
:
	rts

; Based on player state (position, action, etc) choose an animation sequence
; to run. I
; Postconditions:
;	If appropriate, the player's animation number will have changed, and
;	the animation address will update as well.
player_choose_animation:
	lda player_death_cnt
	beq @not_dying
	lda #ANIM_DEATH
	jsr player_set_anim_num
	rts

@not_dying:
	lda player_hurt_cnt
	beq @not_hurt
	jsr player_reset_animation
	lda #ANIM_HURT
	jsr player_set_anim_num
	rts

@not_hurt:
	lda player_kick_cnt
	beq @not_kicking
	lda player_disp_dir
	and #%00000010
	cmp #$00
	bne @facing_down_kick
	lda #ANIM_KICK_BACK
	jsr player_set_anim_num
	rts

@facing_down_kick:
	lda #ANIM_KICK_FWD
	jsr player_set_anim_num
	rts

@not_kicking:
	lda player_disp_dir
	and #%00000010
	cmp #$00
	bne @facing_down_stand
	lda #ANIM_STAND_BACK
	jsr player_set_anim_num
	rts

@facing_down_stand:
	lda #ANIM_STAND_FWD
	jsr player_set_anim_num
	rts

; Puts an animation back to its first frame
player_reset_animation:
	lda #$00
	sta player_anim_frame
	sta player_anim_cnt
	rts


; Sets the player's animation to the number loaded in A. If the animation is
; already loaded, do nothing. Otherwise, reset animation counters.
; Preconditions:
;	A is loaded with the desired animation script
; Postconditions:
;	If a new animation is chosen, player_struct has these fields updated:
;		-Animation script address (ANIM_ADDR)
;		-Animation script length (ANIM_LEN)
;		-Animation number (ANIM_NUM)
;		-Animation frame accumulator (ANIM_CNT) (reset to zero)
;		-Animation frame number (ANIM_FRAME) (reset to zero)
player_set_anim_num:
	sta temp3				; Store number argument
	cmp player_anim_num
	beq @done	; If we're already in this animation, don't bother

	; First we need the address of the animation script from the map
	lda #<pl_anim_num_map
	sta addr_ptr
	lda #>pl_anim_num_map
	sta addr_ptr + 1

	; addr_ptr now contains the map address
	lda temp3
	asl a					; Multiply by two
	tay					; Get our animation # from A
	lda (addr_ptr), y			; Get lobyte
	sta player_anim_addr
	sta temp
	iny
	lda (addr_ptr), y			; Get hibyte
	sta player_anim_addr + 1
	sta temp2

	; The player struct now has a reference to the chosen animation script.
	; From that we can extract the length, but we need to put it into temp.

	ldy #$00				; First parameter is length.
	lda (temp), y				; A gets animation length
	sta player_anim_len

@done:
	rts

; Based on current animation number and frame number, choose a mapping to
; draw the player with.
; Preconditions:
;	X is loaded with the player struct offset
; Postconditions:
;	addr_ptr is loaded with the appropriate mapping
player_choose_mapping:

	; Get address of script into temp
	lda player_anim_addr
	sta temp
	lda player_anim_addr + 1
	sta temp2

	; Temp contains the script offset; we want the address of the first
	; mapping, which is $02 in

	add16 temp, #$02		; addr_ptr = script's first mapping

	lda player_anim_frame ; Get current frame #
	asl a
	asl a				; A = index into script for frame
					; A = current frame * 4
	sta temp3
	add16 temp, temp3		; addr_ptr = address of frame now


	; Temp has the address of the animation mapping now.

	ldy #$00
	lda (temp), y
	sta addr_ptr			; addr_ptr = lowaddr of mapping
	iny
	lda (temp), y
	sta addr_ptr+1			; addr_ptr+1 = hiaddr of mapping

	;addr_ptr now contains the mapping address.

	rts


; Have the player step through an animation script.
; Preconditions:
;	X is loaded with the player struct offset
;	ANIM_ADDROFF is loaded wtih a valid animation script address.
; Postconditions:
;	ANIM_CNTOFF has incremented, and if it's reached the current frame
;	  length, it will have reset to zero and incremented ANIM_FRAMEOFF.
;	ANIM_FRAMEOFF will reset to zero when it has reached the script length.
player_animate:

	; Get address of script into temp
	lda player_anim_addr
	sta temp
	lda player_anim_addr + 1
	sta temp2

	add16 temp, #$04		; Point at first frame's duration

	lda player_anim_frame ; Get current frame #
	asl a
	asl a				; A = index into script for frame
	sta temp3
	add16 temp, temp3

	; Temp points to the current frame's length
	ldy #$00
	lda (temp), y
	sta temp

	; Temp now contains the frame duration to compare against

	; Increment animation accumulator
	ldy player_anim_cnt
	iny
	cpy temp		; Have we reached the end of this frame?
	beq @frame_inc		; If so, increment frame number.
	; Otherwise, just increment the accumulator.
	sty player_anim_cnt
	rts

@frame_inc:
	lda #$00
	sta player_anim_cnt ; Reset frame accumulator
	ldy player_anim_frame
	iny
	tya
	cmp player_anim_len ; Is the animation over?
	beq @anim_loop	; If so, loop animation
	; Otherwise, just increment the frame number.
	sty player_anim_frame
	rts

@anim_loop:
	; Get address of script into temp
	lda player_anim_addr
	sta temp
	lda player_anim_addr + 1
	sta temp2

	add16 temp, #$01		; Point at the loop point

	ldy #$00
	lda (temp), y
	sta player_anim_frame
	rts

; Draws a player to the screen; called by players_draw.
; Preconditions:
;	addr_ptr is loaded with the address of the animation frame struct.
player_draw:
	lda #$01
	sta temp
	lda player_hurt_cnt
	beq :+
	lda #$00
	sta temp
:
	lda player_disp_dir
	and #$01 ; Clamp to a flag dictating whether it should flip
	eor temp ; Reverse it, unless it's the hurt anim
	sta temp3
	ldx #$7F
	ldy #$70
	jsr draw_metasprite
	rts

