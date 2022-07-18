
This folder contains the implementations of NTRU, NTRU Prime, and Saber on Cortex-M4.

We provide the standalone benchmarking environment for the NTT-based polynomial multiplications for NTRU and NTRU Prime, NTT-based `MatrixVectorMul` and `InnerProd` for Saber, and the schemes.

This folder corresponds to the following sections.
- Section 8.4 **Cortex-M4:NTRU, NTRU Prime, and Saber**
- Section 9.1 **Cortex-M4 Results**

# Basic information

## Requirements
- `arm-none-eabi-gcc` with version 10.3.1
- Board `stm32f4discovery`. This implies the following
    - Submodule `libopencm3`
    - Linker `stm32f4discovery.ld`
- `stlink`

## Flashing binaries
For flashing a binary `XXX.bin`, type the following
```
st-flash write XXX.bin 0x8000000
```

## Read from board
Type
```
python3 ./read_serial.py
```

# Benchmarking NTT-based operations
Go to the following folders
- `ntruhps2048677_1440`
- `ntruhps2048677_1536`
- `ntruhrss701_1440`
- `ntruhrss701_1536`
- `ntruhps4096821`
- `ntrup653`
- `ntrup761`
- `ntrup857`
- `ntrup1013`
- `ntrup1277`

## Compilation
Type
```
make
```

The following files are required for compilation.
- `Makefile`. This file requires the following files from the folder `common`:
    - `make.mk`
    - `hal-opencm3.c`
    - `stm32f4discovery.ld`
- In folder `common`:
    - `hal-opencm3.c`
    - `hal.h`
    - `make.mk`
    - `naive_mult.h`
    - `naive_mult.c`
    - `stm32f4discovery.ld`. This is tied to the board `stm32f4discovery`. If you want to use other boards, do the following:
        - Provide a linker for your board.
        - Replace the first line `LDSCRIPT   = ../common/stm32f4discovery.ld` in each `Makefile` with the name of the linker.
    - `tools.h`
    - `tools.c`

# Benchmarking schemes

## Compilation
Type
```
make -j8
```

The following files are required for compilation.
- In folder `mk`:
    - `config.mk`: The variable `PLATFORM` is set to `stm32f4discovery`. Change it if you want to use other boards.
    - `crypto.mk`
    - `stm32f4discovery.mk`. This is for the board `stm32f4discovery.mk`. Modify and rename it (called in `config.mk`) if you want to use other boards.
    - `opencm3.mk`
    - `rule3.mk`
    - `schemes.mk`. The schemes are set. You can pass with your own definition of `IMPLEMENTATION_PATH` for other schemes or implementations.
- In folder `common`:
    - `hal-opencm3.c`
    - `hal.h`
    - `fips202.h`
    - `fips202.c`
    - `keccakf1600.h`
    - `keccakf1600.S`
    - `sha512_hash.h`
    - `sha512_hash.c`
    - `sha512_inner32.s`
    - `aes-encrypt.S`
    - `aes-keyschedule.S`
    - `aes-publicinputs.h`
    - `aes-publicinputs.c`
    - `aes-publicinputs.S`
    - `aes.h`
    - `aes.c`
    - `crypto_sort.h`
    - `crypto_sort.c`
    - `sort_asm.S`
    - `randombytest.h`
    - `randombytest.c`
    - `sendfn.h`

The binary file `crypto_kem_{scheme}_{imple}_{test}.elf` will be produced in the folder `elf` where
- if `{scheme}` is one of
    - `ntruhps2048677`
    - `ntruhrss701`,

  `{imple}` is one of
    - `m4f_1440`
    - `m4f_1536`
    - `m4fref`;
- if `{scheme}` is one of
    - `lightsaber`
    - `saber`
    - `firesaber`,

  `{imple}` is one of
    - `m4fspeed`
    - `m4fstack`
    - `m4fref`;
- if `{scheme}` is one of
    - `ntruhps4096821`
    - `ntrulpr653`
    - `ntrulpr761`
    - `ntrulpr857`
    - `ntrulpr1013`
    - `ntrulpr1277`
    - `sntrup653`
    - `sntrup761`
    - `sntrup857`
    - `sntrup1013`
    - `sntrup1277`,

  `{imple}` is one of
    - `m4fref`
    - `m4f`.
- `{test}` is one of
    - `profile`
    - `speed`
    - `stack`
    - `test`
    - `testvectors`

## Scripts
The following `python` scripts are provided.
- `profile.py` reports and write the cycles spent on hashing, sorting, and generating randombytes to the file `profile.txt`.
- `speed.py` reports and write the overall performance numbers to the file `speed.txt`.
- `stack.py` reports and write the stack usage to the file `stack.txt`.
- `test.py` tests for the correctness of the KEM.
- `testvectors.py` generates and write the testvectors to the file `testvectors_{scheme}_{imple}.txt`.






