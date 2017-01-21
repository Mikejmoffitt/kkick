METASPRITE_MAX_TILES = (24*4)

.segment "FIXED"
; Draws a metasprite to the screen. 
; Preconditions:
;	Put screen X in X and screen Y in Y.
;	Temp3 flips about the Y axis (horizontally)
;	Put the metasprite structure's address in addr_ptr
;	Starting sprite is specified with spr_alloc
draw_metasprite:
	txa
	sta temp
	tya
	sta temp2

	; Normalize the flip flag to exactly #$40
	lda temp3
	beq @post_flip_fix
	lda #$40
	sta temp3
@post_flip_fix:

; Set up initial sprite number
	lda spr_alloc
	tay
	sta temp4
	sub16 addr_ptr, temp4
	lda temp4
	clc
	adc #METASPRITE_MAX_TILES
	sta temp4
	

@oam_copy_loop:

	lda spr_alloc
	clc
	adc #$04
	sta spr_alloc
	; Y = OAM Y position
	lda (addr_ptr), y		; Y pos relative to metasprite
	cmp #MAP_END			; Check unused flag
	beq @end_frame			; Y-Pos was MAP_END; terminate loop
	clc
	adc temp2			; Offset from sprite's Y center
	sec
	sbc yscroll			; Factor in scrolling position
	sta OAM_BASE, y
	iny				; Y = OAM tile select

	lda (addr_ptr), y
@tile_store:
	sta OAM_BASE, y
	iny				; Y = OAM attributes
	lda (addr_ptr), y

	; Process X flip for attributes
	eor temp3 ; X flip
	sta OAM_BASE, y
	iny				; Y = OAM X position

	; Check if tile position needs to be flipped about Y axis (horiz)
	lda temp3
	beq @noflipx
	lda #$00
	sec
	sbc (addr_ptr), y		; Reverse relative X position
	sec
	sbc #$08
	;sec
	;sbc xscroll			; Factor in scrolling position
	clc
	adc temp; Offset from sprite's X center
@no_x_overflow:
	sta OAM_BASE, y
	iny
	cpy temp4
	bne @oam_copy_loop
	rts

@noflipx:
	lda (addr_ptr), y		; X pos relative to metasprite
	clc
	adc temp			; Offset from sprite's X center
	;sec
	;sbc xscroll			; Factor in scrolling position
	sta OAM_BASE, y
	iny

	cpy temp4
	bne @oam_copy_loop
	rts

; This branch is for when a sprite is to be hidden so we can ignore everything
; other than the Y position
@end_frame:
	lda #$FF
	sta OAM_BASE, y			; Hide this sprite
	iny
	iny
	iny
	iny
	cpy temp4			; Hide all remaining sprites
	bne @end_frame			; for this metasprite.
	rts

extra_spr_clear:
	lda $5555
	lda spr_alloc
	lsr
	lsr
	tax
	lda #$FE
:
	sta OAM_BASE, x
	inx
	inx
	inx
	inx
	bne :-

	rts
