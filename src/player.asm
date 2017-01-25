; Player top-level

ANIM_NULL = 0
ANIM_STAND_FWD = 1
ANIM_STAND_BACK = 2
ANIM_KICK_FWD = 3
ANIM_KICK_BACK = 4
MAX_PL_SPRITES = (16*4)

.segment "FIXED"

player_init:
	ldx #$00
	stx player_dir
	stx player_anim_num
	stx player_kick_cnt
	stx player_score
	stx player_score_acc
	stx player_score_acc+1
	ldx #03
	stx player_health
	stx player_lives
rts

.include "player_anims.asm"
.include "player_render.asm"
.include "player_logic.asm"
