.segment "HEADER"
; Borrowed from https://github.com/furrykef/pacman

; Magic cookie
.byte "NES", $1a

; 4: Size of PRG in 16 KB units
.byte $02

; 5: Size of CHR in 8 KB units (0 = CHR RAM)
.byte $01

; 6: Mirroring, save RAM, trainer, mapper low nybble
.byte $01

; 7: Vs., PlayChoice-10, NES 2.0, mapper high nybble
.byte $00

; 8: PRG RAM
.byte $00

; 9: NTSC
.byte 00

