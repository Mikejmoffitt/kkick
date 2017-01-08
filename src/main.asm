; iNES Header

MAP_END = $FE

.segment "FIXED"
.include "nes.asm"
.include "header.asm"
.include "ram.asm"
.include "cool_macros.asm"
.include "utils.asm"
.include "bg.asm"
.include "metasprite.asm"
.include "famitone.asm"
.include "sound.asm"

.segment "FIXED"
; =============================
; VBlank ISR
; =============================

nmi_vector:
	pha				; Preseve A
	php
	
	lda #$00
	sta PPUCTRL			; Disable NMI
	sta vblank_flag

	lda #$80			; Bit 7, VBlank activity flag
@vbl_done:
	bit PPUSTATUS			; Check if vblank has finished
	bne @vbl_done			; Repeat until vblank is over

	lda ppuctrl_config
	sta PPUCTRL			; Re-enable NMI

	plp
	pla				; Restore registers from stack

	rti

; ============================
; IRQ vector
; ============================
irq_vector:
	rti

; ============================
; Entry point
; ============================
reset_vector:
; Basic 6502 init, straight outta NESDev
	sei				; ignore IRQs
	cld				; No decimal mode, it isn't supported
	ldx #%00000100
	stx $4017			; Disable APU frame IRQ

	ldx #$ff
	txs				; Set up stack

; Clear some PPU registers
	inx				; X = 0 now
	stx PPUCTRL			; Disable NMI
	stx PPUMASK			; Disable rendering
	stx DMCFREQ			; Disable DMC IRQs

; Wait for first vblank
@waitvbl1:
	lda #$80
	bit PPUSTATUS
	bne @waitvbl1

; Wait for the PPU to go stable
	txa				; X still = 0; clear A with this
@clrmem:
	sta $000, x
	sta $100, x
	; Reserving $200 for OAM display list
	sta $300, x
	sta $400, x
	sta $500, x
	sta $600, x

	inx
	bne @clrmem

; One more vblank
@waitvbl2:
	lda #$80
	bit PPUSTATUS
	bne @waitvbl2

; PPU configuration for actual use
	ldx #%10010000         ; Nominal PPUCTRL settings:
	;     |||||||___________ Nametable at $2000
	;     ||||||____________ VRAM inc at 1
	;     |||||_____________ SPR at $0000
	;     ||||______________ BG at $1000
	;     |||_______________ 8x8 Sprites
	;     ||________________ Slave mode (don't change this!)
	;     |_________________ NMI enable
	stx ppuctrl_config
	stx PPUCTRL

	ldx #%00011110
	;     ||||||||__________ Greyscale off
	;     |||||||___________ BG left column
	;     ||||||____________ SPR left column
	;     |||||_____________ BG enable
	;     ||||______________ SPR enable
	;     |||_______________ No red emphasis
	;     ||________________ No green emphasis
	;     |_________________ No blue emphasis
	stx ppumask_config
	stx PPUMASK

	jsr spr_init

	ppu_enable

; Build button comparison table
	lda #$80
	ldx #$00
@build_controller_table:
	sta button_table, x
	inx
	lsr
	bne @build_controller_table

; Set a default for scroll
	lda #$00
	sta xscroll
	sta yscroll+1
	sta xscroll+1
	lda #$E0
	sta yscroll
	jmp main_entry ; GOTO main loop

; =============================================================================
; ====                                                                     ====
; ====                            Program Begin                            ====
; ====                                                                     ====
; =============================================================================
main_entry:
	ppu_disable
	ldx #<ntcomp
	ldy #>ntcomp
	jsr decomp_room

	; Load in a palette
	ppu_load_spr_palette sample_spr_palette_data
	ppu_load_bg_palette main_bg_palette
	

; Sound test
	lda #$00
	jsr play_track
	; Make some noise
;	ldx #<testmus_music_data
;	ldy #>testmus_music_data
;	lda #80
;	jsr FamiToneInit
;	lda #$00
;;	jsr FamiToneMusicPlay

	; Bring the PPU back up.
	jsr wait_nmi

	ppu_enable

main_top_loop:

	; Run game logic here
	jsr read_joy_safe
	jsr FamiToneUpdate

	key_down pad_1, btn_a
	jsr play_ack_sound
:
	key_down pad_1, btn_b
	jsr play_whoa_sound
:

	; End of game logic frame; wait for NMI (vblank) to begin
	jsr wait_nmi

	; Commit VRAM updates while PPU is disabled in vblank
	ppu_disable

	spr_dma
	ppu_load_scroll xscroll, yscroll

	; Re-enable PPU for the start of a new frame
	ppu_enable

	jmp main_top_loop; loop forever


ntcomp:
	.incbin "resources/main_table.bin"

main_bg_palette:
	.byte	$0F, $15, $30, $0F
	.byte	$0F, $17, $27, $37
	.byte	$0F, $17, $27, $37
	.byte	$0F, $17, $27, $37

sample_spr_palette_data:
	.byte	$0F, $01, $30, $27
	.byte	$0F, $02, $24, $30
	.byte	$0F, $06, $26, $30
	.byte	$0F, $2C, $24, $2A
	; For a large project, palette data like this is often separated
	; into a separate file and .incbin'd in, just like the other data.

; These are needed to boot the NES.
.segment "VECTORS"

	.addr	nmi_vector	; Every vblank, this ISR is executed.
	.addr	reset_vector	; On bootup or reset, execution begins here.
	.addr	irq_vector	; Triggered by external hardware in the
				; game cartridge, this ISR is executed. A
				; software break (BRK) will do it as well.

; NROM CHR data

.segment "CHR"
	.incbin "resources/chr.chr"

