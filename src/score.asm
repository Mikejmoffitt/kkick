
; Print a big number on the nametable
; X: digit
; A: number

.macro put_row a1, a2, a3
	lda a1
	ldx a2
	ldy a3
	jsr place_row
.endmacro

place_row:
	sta temp2

	bit PPUSTATUS
	lda #$20
	sta PPUADDR
	lda temp
	sta PPUADDR

	lda temp2
	sta PPUDATA
	stx PPUDATA
	sty PPUDATA

	lda temp
	clc
	adc #$20
	sta temp
	rts

put_num:
	; temp: calculated low byte of PPUADDR
	sta temp2
	txa
	asl
	asl
	clc
	adc #$6B
	sta temp
	lda #$6B
	lda temp2

	beq @put_0
	cmp #$01
	bne :+
	jmp @put_1
:	cmp #$02
	bne :+
	jmp @put_2
:	cmp #$03
	bne :+
	jmp @put_3
:	cmp #$04
	bne :+
	jmp @put_4
:	cmp #$05
	bne :+
	jmp @put_5
:	cmp #$06
	bne :+
	jmp @put_6
:	cmp #$07
	bne :+
	jmp @put_7
:	cmp #$08
	bne :+
	jmp @put_8
:	cmp #$09
	bne :+
	jmp @put_9
:	rts

@put_0:
	put_row #$02, #$02, #$02
	put_row #$02, #$01, #$02
	put_row #$02, #$01, #$02
	put_row #$02, #$01, #$02
	put_row #$02, #$02, #$02
	rts

@put_1:
	put_row #$01, #$02, #$01
	put_row #$01, #$02, #$01
	put_row #$01, #$02, #$01
	put_row #$01, #$02, #$01
	put_row #$01, #$02, #$01
	rts

@put_2:
	put_row #$02, #$02, #$02
	put_row #$01, #$01, #$02
	put_row #$02, #$02, #$02
	put_row #$02, #$01, #$01
	put_row #$02, #$02, #$02
	rts

@put_3:
	put_row #$02, #$02, #$02
	put_row #$01, #$01, #$02
	put_row #$01, #$02, #$02
	put_row #$01, #$01, #$02
	put_row #$02, #$02, #$02
	rts

@put_4:
	put_row #$02, #$01, #$02
	put_row #$02, #$01, #$02
	put_row #$02, #$02, #$02
	put_row #$01, #$01, #$02
	put_row #$01, #$01, #$02
	rts

@put_5:
	put_row #$02, #$02, #$02
	put_row #$02, #$01, #$01
	put_row #$02, #$02, #$02
	put_row #$01, #$01, #$02
	put_row #$02, #$02, #$02
	rts

@put_6:
	put_row #$02, #$02, #$02
	put_row #$02, #$01, #$01
	put_row #$02, #$02, #$02
	put_row #$02, #$01, #$02
	put_row #$02, #$02, #$02
	rts

@put_7:
	put_row #$02, #$02, #$02
	put_row #$01, #$01, #$02
	put_row #$01, #$01, #$02
	put_row #$01, #$01, #$02
	put_row #$01, #$01, #$02
	rts

@put_8:
	put_row #$02, #$02, #$02
	put_row #$02, #$01, #$02
	put_row #$02, #$02, #$02
	put_row #$02, #$01, #$02
	put_row #$02, #$02, #$02
	rts

@put_9:
	put_row #$02, #$02, #$02
	put_row #$02, #$01, #$02
	put_row #$02, #$02, #$02
	put_row #$01, #$01, #$02
	put_row #$01, #$01, #$02
	rts

draw_score:
	ldx #$02
	lda player_score
	jsr put_num
	ldx #$01
	lda player_score+1
	jsr put_num
	ldx #$00
	lda player_score+2
	jsr put_num

	rts


score_add_point:
	inc player_score
	lda player_score
	cmp #10
	bne @inc_done
	lda #$00
	sta player_score
	lda player_score+1
	clc
	adc #$01
	sta player_score+1
	cmp #10
	bne @inc_done
	lda #$00
	sta player_score+1
	lda player_score+2
	clc
	adc #$01
	sta player_score+2

@inc_done: ; Done with BCD accumulation

; Increment score accumulator for extra lives
	lda player_score_acc
	clc
	adc #$01
	sta player_score_acc
	; mod 200 points?
	cmp #200
	beq @award_life
	rts

; If score accumulator >= 200, give an extra life
@award_life:
	lda #$00
	sta player_score_acc
	inc player_lives
	beq @lives_overflow
	rts

@lives_overflow:
	lda #$FF
	sta player_lives
	rts

; Writes the number of lives as a little number next to the player icon
draw_lives:
	bit PPUSTATUS
	lda #$22
	sta PPUADDR
	lda #$E7
	sta PPUADDR

	lda player_lives
	clc
	adc #$F0
	sta PPUDATA
	rts

; Draws the health status bar.
draw_health:
	bit PPUSTATUS
	lda #$22
	sta PPUADDR
	lda #$F5
	sta PPUADDR

	ldx #$01
	lda player_health
	cmp #1
	bcs :+
	ldx #$00
:
	stx PPUDATA
	stx PPUDATA
	ldx #$01
	lda player_health
	cmp #2
	bcs :+
	ldx #$00
:
	stx PPUDATA
	stx PPUDATA
	ldx #$01
	lda player_health
	cmp #3
	bcs :+
	ldx #$00
:
	stx PPUDATA
	stx PPUDATA
		
	rts	
