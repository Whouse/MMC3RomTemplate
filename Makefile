
.PHONY: clean mrproper doc

SRC_DIR := ./src/
SRC_FILES := $(wildcard $(SRC_DIR)*.asm)
SRC_FILES += $(wildcard $(SRC_DIR)**/*.asm)
SRC_FILES += $(wildcard $(SRC_DIR)**/**/*.asm)

CST_DIR := $(SRC_DIR)constants/
MCR_DIR := $(SRC_DIR)macros/


OBJ_DIR := ./build/
OBJ_FILES := $(addprefix $(OBJ_DIR), $(notdir $(SRC_FILES:.asm=.o)))

BIN_DIR := ./bin/

RES_DIR := ./resources/
PAL_DIR := $(RES_DIR)palettes/
CHR_DIR := $(RES_DIR)chrs/

DOC_DIR := ./doc/

CA=ca65
CAFLAGS= -g \
	--include-dir $(CST_DIR) --include-dir $(MCR_DIR)  \
	--bin-include-dir $(PAL_DIR) --bin-include-dir $(CHR_DIR)
LD=ld65
LDFLAGS= -C nes.cfg
EXEC=main


all: build 

clean:
	echo $(SRC_FILES)
	-rm -f $(OBJ_FILES)
	-rm -f $(DOC_DIR)*

mrproper: clean
	-rm -f $(BIN_DIR)*

build: $(EXEC)

$(EXEC): $(OBJ_FILES)
	$(LD) $(OBJ_FILES) \
	$(LDFLAGS) \
	-o $(addprefix $(BIN_DIR), $(EXEC).nes) \
	--dbgfile $(addprefix $(BIN_DIR), $(EXEC).dbg)

$(OBJ_DIR)%.o: $(SRC_DIR)%.asm
	$(CA) $(CAFLAGS) $< -o $@

$(OBJ_DIR)%.o: $(SRC_DIR)**/%.asm
	$(CA) $(CAFLAGS) $< -o $@

$(OBJ_DIR)%.o: $(SRC_DIR)**/**/%.asm
	$(CA) $(CAFLAGS) $< -o $@

doc:
	-asmdocgen -s $(SRC_DIR) -o $(DOC_DIR)doc_$(EXEC).md

run: all
	mesen $(BIN_DIR)$(EXEC).nes

new: mrproper build doc