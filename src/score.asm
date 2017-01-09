
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


sc_test:
	inc player_score
	lda player_score
	cmp #10
	bne :+
	lda #$00
	sta player_score
	lda player_score+1
	clc
	adc #$01
	sta player_score+1
	cmp #10
	bne :+
	lda #$00
	sta player_score+1
	lda player_score+2
	clc
	adc #$01
	sta player_score+2

:
	rts

