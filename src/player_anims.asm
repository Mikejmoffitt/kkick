; Player animation scripts

; =============== Animation Mappings ====================
; Arrangements of sprites to form single animation frames, or "metasprites"
; Four bytes follow the mapping of what goes into OAM, mostly
;		 Sprite Y (relative to player's Y), signed; set to MAP_END to end list
;		 Tile selection
;		 Attributes; player 2 is ORed with %00000010
;		 Sprite X (relative to player's X), signed; flipped to face left
; Twelve sprites are allocated for a frame.

pl_mapping_stand_fwd1:
	.byte	<-32, $00, %00000000, <-4
	.byte	<-32, $01, %00000000, 4
	.byte	<-24, $10, %00000000, <-12
	.byte	<-24, $11, %00000000, <-4
	.byte	<-24, $12, %00000000, 4
	.byte	<-16, $20, %00000000, <-12
	.byte	<-16, $21, %00000000, <-4
	.byte	<-8,  $30, %00000000, <-9
	.byte	<-8,  $31, %00000000, <-1
	.byte	MAP_END

pl_mapping_stand_fwd2:
	.byte	<-31, $02, %00000000, <-4
	.byte	<-31, $03, %00000000, 4
	.byte	<-23, $13, %00000000, <-8
	.byte	<-23, $14, %00000000, 0
	.byte	<-15, $23, %00000000, <-12
	.byte	<-15, $24, %00000000, <-4
	.byte	<-7,  $33, %00000000, <-9
	.byte	<-7,  $34, %00000000, <-1
	.byte	MAP_END

pl_mapping_stand_back1:
	.byte	<-32, $04, %00000000, <-4
	.byte	<-32, $05, %00000000, 4
	.byte	<-24, $15, %00000000, <-12
	.byte	<-24, $16, %00000000, <-4
	.byte	<-24, $12, %00000000, 4
	.byte	<-16, $20, %00000000, <-12
	.byte	<-16, $22, %00000000, <-4
	.byte	<-8,  $30, %00000000, <-9
	.byte	<-8,  $31, %00000000, <-1
	.byte	MAP_END

pl_mapping_stand_back2:
	.byte	<-31, $06, %00000000, <-4
	.byte	<-31, $07, %00000000, 4
	.byte	<-23, $17, %00000000, <-8
	.byte	<-23, $18, %00000000, 0
	.byte	<-15, $23, %00000000, <-12
	.byte	<-15, $32, %00000000, <-4
	.byte	<-7,  $33, %00000000, <-9
	.byte	<-7,  $34, %00000000, <-1
	.byte	MAP_END

pl_mapping_kick_fwd1:
	.byte	<-31, $40, %00000000, <-14
	.byte	<-31, $41, %00000000, <-6
	.byte	<-23, $50, %00000000, <-10
	.byte	<-23, $51, %00000000, <-2
	.byte	<-15, $60, %00000000, <-10
	.byte	<-15, $61, %00000000, <-2
	.byte	<-7, $65, %00000000, <-6
	.byte	MAP_END

pl_mapping_kick_fwd2:
	.byte	<-31, $42, %00000000, <-12
	.byte	<-31, $43, %00000000, <-4
	.byte	<-23, $37, %00000000, <-12
	.byte	<-23, $25, %00000000, <-4
	.byte	<-23, $26, %00000000, 4
	.byte	<-15, $47, %00000000, <-12
	.byte	<-15, $63, %00000000, <-4
	.byte	<-15, $64, %00000000, 4
	.byte	<-7, $44, %00000000, <-4
	.byte	MAP_END

pl_mapping_kick_fwd3:
	.byte	<-31, $42, %00000000, <-12
	.byte	<-31, $43, %00000000, <-4
	.byte	<-23, $37, %00000000, <-12
	.byte	<-23, $35, %00000000, <-4
	.byte	<-23, $36, %00000000, 4
	.byte	<-15, $47, %00000000, <-12
	.byte	<-15, $63, %00000000, <-4
	.byte	<-15, $64, %00000000, 4
	.byte	<-7, $44, %00000000, <-4
	.byte	MAP_END

pl_mapping_kick_fwd4:
	.byte	<-31, $42, %00000000, <-12
	.byte	<-31, $43, %00000000, <-4
	.byte	<-23, $37, %00000000, <-12
	.byte	<-23, $45, %00000000, <-4
	.byte	<-23, $46, %00000000, 4
	.byte	<-15, $47, %00000000, <-12
	.byte	<-15, $63, %00000000, <-4
	.byte	<-15, $64, %00000000, 4
	.byte	<-7, $44, %00000000, <-4
	.byte	MAP_END

pl_mapping_kick_fwd5:
	.byte	<-31, $42, %00000000, <-12
	.byte	<-31, $43, %00000000, <-4
	.byte	<-23, $52, %00000000, <-12
	.byte	<-23, $53, %00000000, <-4
	.byte	<-23, $54, %00000000, 4
	.byte	<-15, $62, %00000000, <-12
	.byte	<-15, $63, %00000000, <-4
	.byte	<-15, $64, %00000000, 4
	.byte	<-7, $44, %00000000, <-4
	.byte	MAP_END

pl_mapping_kick_fwd6:
	.byte	<-31, $42, %00000000, <-12
	.byte	<-31, $43, %00000000, <-4
	.byte	<-23, $38, %00000000, <-12
	.byte	<-23, $55, %00000000, <-4
	.byte	<-23, $56, %00000000, 4
	.byte	<-15, $48, %00000000, <-12
	.byte	<-15, $63, %00000000, <-4
	.byte	<-15, $64, %00000000, 4
	.byte	<-7, $44, %00000000, <-4
	.byte	MAP_END

pl_mapping_kick_fwd7:
	.byte	<-31, $42, %00000000, <-12
	.byte	<-31, $43, %00000000, <-4
	.byte	<-23, $39, %00000000, <-12
	.byte	<-23, $55, %00000000, <-4
	.byte	<-23, $56, %00000000, 4
	.byte	<-15, $49, %00000000, <-12
	.byte	<-15, $63, %00000000, <-4
	.byte	<-15, $64, %00000000, 4
	.byte	<-7, $44, %00000000, <-4
	.byte	MAP_END

pl_mapping_kick_fwd8:
	.byte	<-31, $42, %00000000, <-12
	.byte	<-31, $43, %00000000, <-4
	.byte	<-23, $3A, %00000000, <-12
	.byte	<-23, $55, %00000000, <-4
	.byte	<-23, $56, %00000000, 4
	.byte	<-15, $4A, %00000000, <-12
	.byte	<-15, $63, %00000000, <-4
	.byte	<-15, $64, %00000000, 4
	.byte	<-7, $44, %00000000, <-4
	.byte	MAP_END

pl_mapping_kick_back1: ; pre
	.byte	<-31, $70, %00000000, <-14
	.byte	<-31, $71, %00000000, <-6
	.byte	<-23, $80, %00000000, <-10
	.byte	<-23, $81, %00000000, <-2
	.byte	<-15, $90, %00000000, <-10
	.byte	<-15, $91, %00000000, <-2
	.byte	<-7, $65, %00000000, <-6
	.byte	MAP_END

pl_mapping_kick_back2: ; hair down
	.byte	<-31, $72, %00000000, <-12
	.byte	<-31, $73, %00000000, <-4
	.byte	<-23, $A6, %00000000, <-12
	.byte	<-23, $A7, %00000000, <-4
	.byte	<-23, $84, %00000000, 4
	.byte	<-15, $B6, %00000000, <-12
	.byte	<-15, $B7, %00000000, <-4
	.byte	<-15, $94, %00000000, 4
	.byte	<-7, $44, %00000000, <-4
	.byte	MAP_END

pl_mapping_kick_back2_ex: ; hair down more so
	.byte	<-31, $72, %00000000, <-12
	.byte	<-31, $73, %00000000, <-4
	.byte	<-23, $66, %00000000, <-12
	.byte	<-23, $67, %00000000, <-4
	.byte	<-23, $84, %00000000, 4
	.byte	<-15, $76, %00000000, <-12
	.byte	<-15, $77, %00000000, <-4
	.byte	<-15, $94, %00000000, 4
	.byte	<-7, $44, %00000000, <-4
	.byte	MAP_END

pl_mapping_kick_back3: ; progressively more wild
	.byte	<-31, $72, %00000000, <-12
	.byte	<-31, $73, %00000000, <-4
	.byte	<-23, $82, %00000000, <-12
	.byte	<-23, $83, %00000000, <-4
	.byte	<-23, $84, %00000000, 4
	.byte	<-15, $92, %00000000, <-12
	.byte	<-15, $93, %00000000, <-4
	.byte	<-15, $94, %00000000, 4
	.byte	<-7, $44, %00000000, <-4
	.byte	MAP_END

pl_mapping_kick_back4:
	.byte	<-31, $72, %00000000, <-12
	.byte	<-31, $73, %00000000, <-4
	.byte	<-23, $A3, %00000000, <-12
	.byte	<-23, $A4, %00000000, <-4
	.byte	<-23, $A5, %00000000, 4
	.byte	<-15, $B3, %00000000, <-12
	.byte	<-15, $B4, %00000000, <-4
	.byte	<-15, $94, %00000000, 4
	.byte	<-7, $44, %00000000, <-4
	.byte	MAP_END

pl_mapping_kick_back5:
	.byte	<-31, $72, %00000000, <-12
	.byte	<-31, $73, %00000000, <-4
	.byte	<-23, $A0, %00000000, <-12
	.byte	<-23, $A1, %00000000, <-4
	.byte	<-23, $A2, %00000000, 4
	.byte	<-15, $B0, %00000000, <-12
	.byte	<-15, $B1, %00000000, <-4
	.byte	<-15, $94, %00000000, 4
	.byte	<-7, $44, %00000000, <-4
	.byte	MAP_END

pl_mapping_kick_back6:
	.byte	<-31, $72, %00000000, <-12
	.byte	<-31, $73, %00000000, <-4
	.byte	<-23, $85, %00000000, <-12
	.byte	<-23, $86, %00000000, <-4
	.byte	<-23, $87, %00000000, 4
	.byte	<-15, $95, %00000000, <-12
	.byte	<-15, $96, %00000000, <-4
	.byte	<-15, $94, %00000000, 4
	.byte	<-7, $44, %00000000, <-4
	.byte	MAP_END

pl_mapping_dummy:
	.byte	<-$20, <-$20, 0, 0
	.byte	MAP_END


; =============== Animation Scripts ===============
; Sequences of mappings to form animation sequences
; Animation scripts are simply like this:
; 	Length
; 	Loop P oint in frames
; --------- Then, for every frame:
; 	Mapping address		(.addr)
; 	Length in frames	(.byte)
; 	Padding			(.byte)

pl_anim_dummy:
	.byte	1
	.byte	0
	.addr	pl_mapping_dummy
	.byte	1, 0

pl_anim_stand_fwd:
	.byte 	2
	.byte	0
	.addr	pl_mapping_stand_fwd1
	.byte	12, 0
	.addr	pl_mapping_stand_fwd2
	.byte	12, 0

pl_anim_stand_back:
	.byte 	2
	.byte	0
	.addr	pl_mapping_stand_back1
	.byte	12, 0
	.addr	pl_mapping_stand_back2
	.byte	12, 0

pl_anim_kick_fwd:
	.byte	11
	.byte	10
	.addr	pl_mapping_stand_fwd1
	.byte	1, 0
	.addr	pl_mapping_kick_fwd1
	.byte	1, 0
	.addr	pl_mapping_kick_fwd5
	.byte	1, 0
	.addr	pl_mapping_kick_fwd3
	.byte	1, 0
	.addr	pl_mapping_kick_fwd2
	.byte	4, 0
	.addr	pl_mapping_kick_fwd3
	.byte	2, 0
	.addr	pl_mapping_kick_fwd4
	.byte	1, 0
	.addr	pl_mapping_kick_fwd5
	.byte	1, 0
	.addr	pl_mapping_kick_fwd6
	.byte	1, 0
	.addr	pl_mapping_kick_fwd7
	.byte	2, 0
	.addr	pl_mapping_kick_fwd8
	.byte	1, 0

pl_anim_kick_back:
	.byte	11
	.byte	10
	.addr	pl_mapping_stand_back1
	.byte	1, 0
	.addr	pl_mapping_kick_back1
	.byte	1, 0
	.addr	pl_mapping_kick_back4
	.byte	1, 0
	.addr	pl_mapping_kick_back5
	.byte	1, 0
	.addr	pl_mapping_kick_back6
	.byte	4, 0
	.addr	pl_mapping_kick_back5
	.byte	2, 0
	.addr	pl_mapping_kick_back4
	.byte	1, 0
	.addr	pl_mapping_kick_back3
	.byte	1, 0
	.addr	pl_mapping_kick_back3
	.byte	1, 0
	.addr	pl_mapping_kick_back2
	.byte	2, 0
	.addr	pl_mapping_kick_back2_ex
	.byte	1, 0

; ============ Animation Number Map ====================
; An array containing the addresses of animation numbers. Used to
; number to an animation script.
pl_anim_num_map:
	.addr	pl_anim_dummy
	.addr	pl_anim_stand_fwd
	.addr	pl_anim_stand_back
	.addr	pl_anim_kick_fwd
	.addr	pl_anim_kick_back


; Character graphics

;	pl_chr:
;	.incbin "../assets/char/girl.chr";
;
;	pl_pal:
;	;	  null blck skin extra
;	.byte $00, $0F, $35, $30
;	.byte $00, $0F, $35, $11
;	;	  null blck skin extra
;	.byte $00, $0F, $26, $30
;	.byte $00, $0F, $26, $16
