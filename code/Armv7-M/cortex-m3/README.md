
This folder contains the implementations of NTT-based Saber on Cortex-M3.

We provide the standalone benchmarking environment for the NTT-based `MatrixVectorMul` and `InnerProd` for Saber, and the schemes.

This folder corresponds to the following sections.
- Section 8.5 **Cortex-M3:Saber**
- Section 9.2 **Cortex-M3 Results**

# Basic information

## Requirements
- `arm-non-eabi-gcc` with version 10.3.1
- `openocd`
- Board `nucleo-f207zg`. This implies the following
    - Submodule `libopencm3`
    - Linker `nucleo-f207zg.ld`
    - Configuration `nucleo-f2.cfg`


## Flashing binaries
For flashing a binary `XXX.elf`, type the following
```
openocd -f nucleo-f2.cfg -c "program XXX.elf reset exit"
```

## Read from board
Type 
```
python3 ./read_serial.py
```

# Benchmarking NTT-based `MatrixVectorMul` and `InnerProd`

Go to the following folders
- `lightsaber`
- `saber`
- `firesaber`

## Compilation
Type 
```
make
```

The following files are required for compilation.
- `Makefile`. This file require the following files from the folder `common`:
    - `make.mk`
    - `hal-opencm3.c`
    - `nucleo-f207zg.ld`
- In folder `common`:
    - `hal-opencm3.c`
    - `hal.h`
    - `make.mk`
    - `naive_mult.h`
    - `naive_mult.c`
    - `nucleo-f207zg.ld`. This is tied with the board `nucleo-f207zg`. If you want to use other boards, do the following:
        - Provide a linker for your board.
        - Replace the first line `LDSCRIPT   = ../common/nucleo-f207zg.ld` in each `Makefile` with the name of the linker.
    - `tools.h`
    - `tools.c`


# Benchmarking Saber

## Compilation
Type 
```
make -j8
```

The following files are required for compilation.
- In folder `mk`:
    - `config.mk`: The variable `PLATFORM` is set to `nucleo-f207zg.mk`. Change it if you want to use other boards.
    - `crypto.mk`
    - `nucleo-f207zg.mk`. This is for the board `nucleo-f207zg.mk`. Modify and rename it (called in `config.mk`) if you want to use other boards.
    - `opencm3.mk`
    - `rule3.mk`
    - `schemes.mk`. The schemes are set. You can pass with your own definition of `IMPLEMENTATION_PATH` for other schemes or implementations.
- In folder `common`:
    - `hal-opencm3.c`
    - `hal.h`
    - `make.mk`
    - `fips202.h`
    - `fips202.c`
    - `keccakf1600.h`
    - `keccakf1600.S`
    - `randombytest.h`
    - `randombytest.c`
    - `sendfn.h`

The binary file `crypto_kem_{scheme}_{imple}_{test}.elf` will be produced in the folder `elf`, where
- `{scheme}` is one of
    - `lightsaber`
    - `saber`
    - `firesaber`
- `{imple}` is one of
    - `m3ref`
    - `m3speed`
    - `m3speedstack`
    - `m3stack`
- `{test}` is one of
    - `speed`
    - `stack`
    - `test`
    - `testvectors`

## Scripts
If you use the `python` scripts, you'll need the following:
- `config.py`
- `speed.py`
- `stack.py`
- `test.py`
- `testvectors.py`





