LDSCRIPT   = ../common/nucleo-f207zg.ld
LIBNAME    = opencm3_stm32f2
ARCH_FLAGS = -mthumb -mcpu=cortex-m3
DEFINES    = -DSTM32F2 -DSTM32F207ZG
OBJS       = ../common/hal-opencm3.o

HEADER = naive_mult.h NTT_params.h NTT.h SABER_params.h tools.h
SRC = naive_mult.c tools.c
ASM_I = macros.i CT_butterflies.i schoolbooks.i
ASM = NTT.S iNTT.S auxiliary.S mul.S CRTm3.S

all: NTT_test.elf NTT_speed.elf MatrixVectorMul_test.elf MatrixVectorMul_speed.elf InnerProd_test.elf InnerProd_speed.elf

NTT_test.elf: $(HEADER) $(SRC) $(ASM_I) $(ASM) NTT_test.o $(OBJS) $(LDSCRIPT)
		$(LD) -o $@ NTT_test.o $(SRC) $(ASM) $(OBJS) $(LDFLAGS) -l$(LIBNAME)

NTT_speed.elf: $(HEADER) $(SRC) $(ASM_I) $(ASM) NTT_speed.o $(OBJS) $(LDSCRIPT)
		$(LD) -o $@ NTT_speed.o $(SRC) $(ASM) $(OBJS) $(LDFLAGS) -l$(LIBNAME)

MatrixVectorMul_test.elf: $(HEADER) $(SRC) $(ASM_I) $(ASM) MatrixVectorMul_test.o $(OBJS) $(LDSCRIPT)
		$(LD) -o $@ MatrixVectorMul_test.o $(SRC) $(ASM) $(OBJS) $(LDFLAGS) -l$(LIBNAME)

MatrixVectorMul_speed.elf: $(HEADER) $(SRC) $(ASM_I) $(ASM) MatrixVectorMul_speed.o $(OBJS) $(LDSCRIPT)
		$(LD) -o $@ MatrixVectorMul_speed.o $(SRC) $(ASM) $(OBJS) $(LDFLAGS) -l$(LIBNAME)

InnerProd_test.elf: $(HEADER) $(SRC) $(ASM_I) $(ASM) InnerProd_test.o $(OBJS) $(LDSCRIPT)
		$(LD) -o $@ InnerProd_test.o $(SRC) $(ASM) $(OBJS) $(LDFLAGS) -l$(LIBNAME)

InnerProd_speed.elf: $(HEADER) $(SRC) $(ASM_I) $(ASM) InnerProd_speed.o $(OBJS) $(LDSCRIPT)
		$(LD) -o $@ InnerProd_speed.o $(SRC) $(ASM) $(OBJS) $(LDFLAGS) -l$(LIBNAME)


include ../common/make.mk
