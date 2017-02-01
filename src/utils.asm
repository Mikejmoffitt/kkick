.segment "FIXED"

wait_nmi_srand:
	lda pad_1
	sta pad_1_prev
	jsr read_joypads
	key_isdown pad_1, btn_start
	lda #$01
	sta temp8
:
	lda temp8
	bne :+
	lda rand_seed
	clc
	adc #$01
	sta rand_seed
	lda rand_seed+1
	adc #$00
	sta rand_seed+1
:
	lda vblank_flag
	bne wait_nmi_srand
	lda #$01
	sta vblank_flag
	rts

wait_nmi:
	lda vblank_flag
	bne wait_nmi			; Spin here until NMI lets us through
	lda #$01
	sta vblank_flag
	rts

; Controller reading code from NESDev
; Out: A=buttons pressed, where bit 0 is A button
read_joypads:
	; Strobe controller
	lda #1
	sta $4016
	sta pad_2
	lsr a
	sta $4016
:
	lda $4016
	and #$03
	cmp #$01
	rol pad_1
	lda $4017
	and #$03
	cmp #$01
	rol pad_2
	bcc :-
	rts

; temp is a zero-page variable

; Reads controller. Reliable when DMC is playing.
; Out: A=buttons held, A button in bit 0
read_joy_safe:
	; Back up previous ones for edge comparisons
	lda pad_1
	sta pad_1_prev
	lda pad_2
	sta pad_2_prev
	; Get first reading
	jsr read_joypads
:
	; Save previous reading
	lda pad_1
	sta temp
	lda pad_2
	sta temp2

	; Read again and compare. If they differ,
	; read again.
	jsr read_joypads
	lda pad_1
	cmp temp
	bne :-
	lda pad_2
	cmp temp2
	bne :-
	rts

; Clear the OAM table
spr_init:
	ldx #$00
	stx spr_alloc
	lda #$FF
@clroam_loop:
	sta OAM_BASE, x
	inx
	cpx #$00
	bne @clroam_loop
	rts
	
; ============================
; BG puts function; Max len 256
; Pointer to string in temp.w
; Column in temp3
; Row in temp4
; ============================
puts:
	ldy temp3			; Upper byte of VRAM Address
	ldx temp4			; Lower byte of VRAM Address

	bit PPUSTATUS
	sty PPUADDR
	stx PPUADDR

	ldy #$00
@printloop:
	lda (temp), y
	beq @finished
	sta PPUDATA
	iny
	bne @printloop
@finished:
	rts
