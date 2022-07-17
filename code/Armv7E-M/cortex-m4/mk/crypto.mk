COMMON_SRC = \
	common/fips202.c \
	common/keccakf1600.S \
	common/sha512_hash.c \
	common/sha512_inner32.s \
	common/aes-encrypt.S \
	common/aes-keyschedule.S \
	common/aes-publicinputs.c \
	common/aes-publicinputs.S \
	common/aes.c \
	common/crypto_sort.c \
	common/sort_asm.S


obj/libcommon.a: $(call objs,$(COMMON_SRC))

obj/libcommon-prof.a: CPPFLAGS += -DPROFILE_HASHING -DPROFILE_SORTING
obj/libcommon-prof.a: $(call hashprofobjs,$(COMMON_SRC))

ifeq ($(AIO),1)
LDLIBS +=
LIBDEPS += $(COMMON_SRC)
CPPFLAGS+=$(if $(PROFILE), -DPROFILE_HASHING -DPROFILE_SORTING)
else
LDLIBS += -lcommon$(if $(PROFILE),-prof)
LIBDEPS += obj/libcommon$$(if $$(PROFILE),-prof).a
endif

