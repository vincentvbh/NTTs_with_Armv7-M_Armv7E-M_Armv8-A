
CFLAGS = -O3 -fomit-frame-pointer -march=native -mcpu=native \
	-Wall -Wextra -Wimplicit-function-declaration \
	-Wredundant-decls -Wmissing-prototypes \
	-Wundef -Wshadow

HEADERs = hal.h ntt.h NTT_params.h params.h macros_common.i macros.i
SRCs = hal.c speed.c
ASMs = __asm_NTT.S __asm_iNTT.S __asm_base_mul.S

all: speed

speed: speed.c $(HEADERs) $(SRCs) $(ASMs)
	gcc -o speed $(CFLAGS) $(SRCs) $(ASMs)

.PHONY: clean
clean:
	rm -f *.h.gch
	rm -f speed

