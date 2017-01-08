# Script for NROM32
# Based on Damian Yerrick's original script
# The original copyright information is reproduced at the bottom
# of this linker script.

MEMORY
{
    # RAM
    ZEROPAGE:   start = 0, size=$100, file="";
    STACK:      start = $100, size=$100, file="";
    OAM:        start = $200, size=$100, file="";
    RAM:        start = $300, size=$500, file="";

    HEADER:     start = 0, size=$10, fill=yes, fillval=$FF;
    ROM:        start = $8000, size = $7300, type = ro, file = %O, fill=yes, fillval=$EA;
    DMC:        start = $F300, size = $CFA, type = ro, file = %O, fill=yes, fillval=$56;
    VEC:        start = $FFFA, size = $0006, type = ro, file = %O, fill=yes, fillval=$00;
    CHR:        start = 0, size = $2000, fill=yes, fillval = $55;
}

SEGMENTS
{
    ZEROPAGE:  load = ZEROPAGE, type=zp;
    RAM:       load = RAM, type=bss, define = yes, align = $100;

    HEADER:    load = HEADER;

    FIXED:     load = ROM, type = ro, start = $8000;
    DATUM:     load = DMC, type = ro, start = $F300;
    VECTORS:   load = VEC, type = ro, start = $FFFa;

    CHR:       load = CHR;

}

# Copyright 2010 Damian Yerrick
#
# Copying and distribution of this file, with or without
# modification, are permitted in any medium without royalty
# provided the copyright notice and this notice are preserved.
# This file is offered as-is, without any warranty.
#
