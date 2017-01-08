TOOLSDIR := tools/cc65
AS := $(TOOLSDIR)/ca65
LD := $(TOOLSDIR)/ld65
ASFLAGS := -g 
SRCDIR := src
CONFIGNAME := ldscripts/nes.ld
OBJNAME := main.o
MAPNAME := map.txt
LABELSNAME := labels.txt
LISTNAME := listing.txt
LDFLAGS := -Ln $(LABELSNAME)

TOPLEVEL := main.asm

EXECUTABLE := kkick.nes

.PHONY: all resources build $(EXECUTABLE)

build: $(EXECUTABLE)

all: $(EXECUTABLE)

clean:
	rm -f $(EXECUTABLE) main.o $(LISTNAME) $(LABELSNAME) $(MAPNAME)

resources:
	-tools/text2data/text2data -ca65 raw_resources/kk_main.txt
	mv raw_resources/kk_main.s resources/kk_main.asm
	tools/rle_nt/comp raw_resources/main_table.nam > resources/main_table.bin

$(EXECUTABLE):
	$(AS) $(SRCDIR)/$(TOPLEVEL) $(ASFLAGS) -I $(SRCDIR) -l $(LISTNAME) -o $(OBJNAME)
	$(LD) $(LDFLAGS) -C $(CONFIGNAME) -o $(EXECUTABLE) -m $(MAPNAME) -vm $(OBJNAME)

run: $(EXECUTABLE)
	nestopia ./$(EXECUTABLE)
	
debug: $(EXECUTABLE)
	wine tools/fceuxw/fceux.exe ./$(EXECUTABLE)

test: $(EXECUTABLE)
	tools/edn8usb $(EXECUTABLE)
