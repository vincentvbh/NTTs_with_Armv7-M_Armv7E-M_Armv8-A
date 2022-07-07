
This folder describes the file generating the tables of twiddle factors.
There are three folders.

- `Armv7-M`
- `Armv7E-M`
- `Armv8-A`

# Requirements
- `Armv7-M`: a C compiler.
- `Armv7E-M`: a C compiler and a Haskell compiler.
- `Armv8-A`: a C compiler.

# How to verify the generation

- Go to a folder `./{arch}/{cpu}/{build}/`.
    - For `{arch}` = `Armv7-M` and `{cpu}` = `cortex-m3`, `{build}` is one of the following:
        - `saber`
    - For `{arch}` = `Armv7E-M` and `{cpu}` = `cortex-m4`, `{build}` is one of the following:
        - `ntruhps2048677_1440`
        - `ntruhps2048677_1536`
        - `ntruhps4096821`
        - `ntruhrss701_1440`
        - `ntruhrss701_1440`
        - `ntrup1013`
        - `ntrup1277`
        - `ntrup653`
        - `ntrup761`
        - `ntrup857`
    - For `{arch}` = `Armv8-A` and `{cpu}` = `cortex-a72`, `{build}` is one of the following:
        - `dilithium`
        - `kyber`
        - `saber`
- Type `make`.
- Type `./gen_table`.

After typing `make`, the file `call_gen` is compiled into the binary `gen_table`.

# How to switch to a different modulus or root of unity
Modify the file `NTT_params.h` accordingly.
If there are lines enclosed with `// getIO = ` and `// end of getIO`, you can find the IO action `getIO` in the file `gen_table.hs`. In `get_table.hs`, modify accordingly.
You can also calculate the constants yourself as the names are already indicating how they are computed.












