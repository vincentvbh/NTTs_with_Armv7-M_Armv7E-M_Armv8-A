COMMON_SRC = \
	common/fips202.c \
	common/keccakf1600.S


obj/libcommon.a: $(call objs,$(COMMON_SRC))

obj/libcommon-prof.a:  CPPFLAGS += -DPROFILE_HASHING -DPROFILE_SORTING -DPROFILE_RAND
obj/libcommon-prof.a: $(call objs,$(COMMON_SRC))

ifeq ($(AIO),1)
LDLIBS +=
LIBDEPS += $(COMMON_SRC)
CPPFLAGS += $(if $(PROFILE),  -DPROFILE_HASHING -DPROFILE_SORTING -DPROFILE_RAND)
else
LDLIBS += -lcommon$(if $(PROFILE), -prof)
LIBDEPS += obj/libcommon$$(if $$(PROFILE), -prof).a
endif
