
This folder contains the implementations of NTTs for NTRU, NTRU Prime, and Saber on Cortex-M4.
We provide the standalone benchmarking environment for the NTT-based polynomial multiplications for NTRU and NTRU Prime, NTT-based `MatrixVectorMul` and `InnerProd` for Saber.

The implementations of the schemes are also included in this thesis.
Note that cryptographic hash functions in the folder `hash` are required for compilation.
To obtain the benchmarks, do the following
- Replace the implementation folders in `pqm4/crypto_kem` with the ones in `crypto_kem`.
- Throw the files in `hash` into `pqm4/common/`.
- Add the following to the variable `SYMCRYPTO_SRC` in `pqm4/mk/crypto.mk`.
```
common/sha512_hash.c
common/sha512_inner32.s
```

# Requirement
- `arm-none-eabi-gcc` with version 10.2.0
- `python3`
- Board `stm32f4discovery`. If you use other boards, do the following:
    - Change the settings in the file `config.py`.
    - Provide a linker for your board.
    - Replace the first line `LDSCRIPT   = ../common/stm32f4discovery.ld` in each `Makefile` with the name of the linker.
- `stlink`




