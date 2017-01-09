; =============================
; Zero-page and main RAM
; Variables, flags, etc.
; =============================

.segment "ZEROPAGE"
; Fast variables
addr_ptr:		.res 2
temp:			.res 1
temp2:			.res 1
temp3:			.res 1
temp4:			.res 1
temp5:			.res 1
temp6:			.res 1
temp7:			.res 1
temp8:			.res 1
pad_1:			.res 1
pad_1_prev:		.res 1
pad_2:			.res 1
pad_2_prev:		.res 1
FT_TEMP:		.res 3

player_dir:		.res 1		; 0 for up-left, 1 for up-right, 2 for down-left, 3 for down-right
player_anim_map:	.res 2		; List of animation script pointers
player_anim_num:	.res 1		; Which animation list
player_anim_addr:	.res 2		; Current animation script pointer
player_anim_len:	.res 1		; Current animation script length
player_anim_frame:	.res 1		; Frame index into animation script
player_anim_cnt:	.res 1		; Animation accumulator

player_score:		.res 3		; BCD storage of player score
player_lives:		.res 1


.segment "RAM"

; Famitone stuff
FT_BASE_ADR:		.res 256

; Flags for PPU control
ppumask_config:	.res 1
ppuctrl_config:	.res 1
vblank_flag:	.res 1
xscroll:	.res 2
yscroll:	.res 2

button_table:
btn_a:		.res 1
btn_b:		.res 1
btn_sel:	.res 1
btn_start:	.res 1
btn_up:		.res 1
btn_down:	.res 1
btn_left:	.res 1
btn_right:	.res 1
