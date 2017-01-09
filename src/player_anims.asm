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
	.byte	<-32, $01, %00000000, <-4
	.byte	<-32, $02, %00000000, 4
	.byte	<-24, $10, %00000000, <-12
	.byte	<-24, $11, %00000000, <-4
	.byte	<-24, $12, %00000000, 4
	.byte	<-16, $20, %00000000, <-12
	.byte	<-16, $21, %00000000, <-4
	.byte	<-8,  $30, %00000000, <-10
	.byte	<-8,  $31, %00000000, <-2
	.byte	MAP_END

pl_mapping_stand_fwd2:
	.byte	<-31, $04, %00000000, <-4
	.byte	<-31, $05, %00000000, 4
	.byte	<-23, $13, %00000000, <-8
	.byte	<-23, $14, %00000000, 0
	.byte	<-15, $23, %00000000, <-12
	.byte	<-15, $24, %00000000, <-4
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
	.byte	<-7, $70, %00000000, <-6
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

pl_anim_kick_fwd:
	.byte	11
	.byte	0
	.addr	pl_mapping_stand_fwd1
	.byte	2, 0
	.addr	pl_mapping_kick_fwd1
	.byte	2, 0
	.addr	pl_mapping_kick_fwd5
	.byte	2, 0
	.addr	pl_mapping_kick_fwd3
	.byte	2, 0
	.addr	pl_mapping_kick_fwd2
	.byte	4, 0
	.addr	pl_mapping_kick_fwd3
	.byte	3, 0
	.addr	pl_mapping_kick_fwd4
	.byte	2, 0
	.addr	pl_mapping_kick_fwd5
	.byte	2, 0
	.addr	pl_mapping_kick_fwd6
	.byte	2, 0
	.addr	pl_mapping_kick_fwd7
	.byte	3, 0
	.addr	pl_mapping_kick_fwd8
	.byte	4, 0

; ============ Animation Number Map ====================
; An array containing the addresses of animation numbers. Used to
; number to an animation script.
pl_anim_num_map:
	.addr	pl_anim_dummy
	.addr	pl_anim_stand_fwd
	.addr	pl_anim_dummy
	.addr	pl_anim_kick_fwd
	.addr	pl_anim_dummy


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
