
; =====================================
; temp: pattern first byte
; temp2: pattern second byte
; temp3: pattern repeat counter
; temp4.w: bytes written

; addr_ptr: read ptr

.macro decomp_kernel

	; Get 16-bit pattern from compressed NT
	lda (addr_ptr), y
	sta temp
	iny
	lda (addr_ptr), y
	sta temp2
	iny
	
	; Get repetition count from compressed NT
	lda (addr_ptr), y
	sta temp3
	ldy #$00
	
	; Move read pointer forwards 3
	add16 addr_ptr, #$03
	
:
		; Write first byte of pattern
		lda temp
		sta PPUDATA
		
		lda temp2
		sta PPUDATA

		add16 temp4, #$02

	; Decrement repeat counter, loop if needed
	dec temp3
	bne :-
.endmacro

; =======================================
; Routine to decompress an RLE16 nametable into $2000 and put a shadow copy in
; col_map as well.
;	X: Low byte of NT address
;	Y: High byte of NT address
;	A: High byte of PPU address
unpack_nt:
	; Get the nametable address in ZP
	stx addr_ptr
	sty addr_ptr+1
	
	; Get set up to write to the nametable
	bit PPUSTATUS ; Reset address latch
;	lda #$20
	sta PPUADDR ; Write $2000 to
	ldy #$00
	sty PPUADDR ; PPUADDR latch
	sty temp4
	sty temp4+1
	
@decomp_top:
	decomp_kernel
	
	lda temp4+1
	cmp #$04
	bne @decomp_top
@finished:
	
	rts
