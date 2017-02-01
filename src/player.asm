; Player top-level

ANIM_NULL = 0
ANIM_STAND_FWD = 1
ANIM_STAND_BACK = 2
ANIM_KICK_FWD = 3
ANIM_KICK_BACK = 4
ANIM_HURT = 5
ANIM_DEATH = 6
MAX_PL_SPRITES = (16*4)

PLAYER_KICK_LEN = 21
PLAYER_COOLDOWN_LEN = 8

DEATH_TIME = 180
ACK_TIME = 125
HURT_TIME = 9

.segment "FIXED"

player_init:
	ldx #$00
	stx player_dir
	stx player_disp_dir
	stx player_anim_num
	stx player_anim_addr
	stx player_anim_addr+1
	stx player_anim_len
	stx player_anim_cnt
	stx player_hurt_cnt
	stx player_kick_cnt
	stx player_cooldown
	stx player_score
	stx player_score+1
	stx player_score+2
	stx player_score_acc
	stx player_death_cnt
	ldx #03
	stx player_health
	stx player_lives
rts

.include "player_anims.asm"
.include "player_render.asm"
.include "player_logic.asm"
