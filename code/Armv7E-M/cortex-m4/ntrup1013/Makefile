LDSCRIPT   = ../common/stm32f4discovery.ld
LIBNAME    = opencm3_stm32f4
ARCH_FLAGS = -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
DEFINES    = -DSTM32F4 -DSTM32F407VG
OBJS       = ../common/hal-opencm3.o

HEADER = naive_mult.h tools.h NTT_params.h
SRC = naive_mult.c tools.c
ASM_I = macros.i butterflies.i schoolbooks.i
ASM = NTT.S mul.S iNTT.S final_map.S

all: NTT_test.bin NTT_speed.bin


NTT_test.elf: $(HEADER) $(SRC) $(ASM_I) $(ASM) NTT_test.o $(OBJS) $(LDSCRIPT)
		$(LD) -o $@ NTT_test.o $(SRC) $(ASM) $(OBJS) $(LDFLAGS) -l$(LIBNAME)

NTT_speed.elf: $(HEADER) $(SRC) $(ASM_I) $(ASM) NTT_speed.o $(OBJS) $(LDSCRIPT)
		$(LD) -o $@ NTT_speed.o $(SRC) $(ASM) $(OBJS) $(LDFLAGS) -l$(LIBNAME)



include ../common/make.mk





