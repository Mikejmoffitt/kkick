; Player top-level

ANIM_NULL = 0
ANIM_STAND_FWD = 1
ANIM_STAND_BACK = 2
ANIM_KICK_FWD = 3
ANIM_KICK_BACK = 4
MAX_PL_SPRITES = (16*4)

.segment "FIXED"

player_init:
rts

.include "player_anims.asm"
.include "player_render.asm"
