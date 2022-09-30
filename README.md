
# NTTs_with_Armv7-M_Armv7E-M_Armv8-A
This repository accompanies my master's thesis **Case Studies on Implementing Number--Theoretic Transforms with Armv7-M, Armv7E-M, and Armv8-A**.
You can find a copy of the thesis in this repository.
This repository contains the implementations described in Chapters 8 and 9.


# Selected works
This thesis collects two published works and one submitted work during the study of the master's program.
- **Multi-moduli NTTs for Saber on Cortex-M3 and Cortex-M4**
    - Available as [TCHES 2022, Issue 1, Pages 127-151](https://tches.iacr.org/index.php/TCHES/article/view/9292).
    - Full version available as [IACR ePrint, 2021/995](https://eprint.iacr.org/2021/995).
- **Neon NTT: Faster Dilithium, Kyber, and Saber on Cortex-A72 and Apple M1**.
    - Available as [TCHES 2022, Issue 1, Pages 221-244](https://tches.iacr.org/index.php/TCHES/article/view/9295).
    - Full version available as [IACR ePrint, 2021/986](https://eprint.iacr.org/2021/986).
- **Multi-Parameter Support with NTTs for NTRU and NTRU Prime on Cortex-M4**
    - Available as [TCHES 2022, Issue 4, Pages 349-371](https://tches.iacr.org/index.php/TCHES/article/view/9823).
    - Full version available as [IACR ePrint, 2022/930](https://eprint.iacr.org/2022/930).


# Errata
- Page 3: "Single-Instruction-Multiple-Data" instead of "Simple-Instruction-Multiple-Data".
- Table 2.3: the q of ntruhrss1373 is 16384.
- Page 89: "min(v_2(q_0), v_3(q_1))" instead of "gcd(v_2(q_0), v_3(q_1))".
- Algorithm 11 is wrong. Please ignore it.


# Structure of this repository
This repository is structured as follows.
- `common`:
    This folder contains the C functions used during the development of the assembly programs. The functions are designed to support user-defined coefficient rings. For documentation, please refer to the Appendix B **Toolkit for Development** in the thesis.
- `code`:
    This folder contains the implementations. Please refer to the folders `Armv7-M`, `Armv7E-M`, and `Armv8-A`.
- `bound`:
    This folder contains the output bounds of each assembly subroutines. Currently, bounds for `Armv7-M` and `Armv7E-M` implementations are given.
    The bounds of `Armv8-A` is left as future work. It is expected that implementations in `Armv8-A` will be improved in the future, and with high probability, only bounds for the improved programs will be given.
- `gen_table`:
    This folder demonstrates how to generate the tables of twiddle factors.


# Implementations
- `code/Armv7E-M/cortex-m4` constains the implementations of NTRU, NTRU Prime, and Saber on Cortex-M4. This corresponds to the following sections in the thesis:
    - Section 8.4 **Cortex-M4:NTRU, NTRU Prime, and Saber**
    - Section 9.1 **Cortex-M4 Results**
- `code/Armv7-M/cortex-m3` constains the implementations of Saber on Cortex-M3. This corresponds to the following sections in the thesis:
    - Section 8.5 **Cortex-M3:Saber**
    - Section 9.2 **Cortex-M3 Results**
- `code/Armv8-A/cortex-a72` contains the implementations of Dilithium, Kyber, and Saber on Cortex-A72. This corresponds to the following sections in the thesis:
    - Section 8.6 **Cortex-A72:Dilithium, Kyber, and Saber**
    - Section 9.3 **Cortex-A72 Results**


# Computing bounds
The folder `bound` constains bounds for the assembly subroutines.
- Folders in `bound/Armv7-M` correspond to the implementations in `code/Armv7-M`.
- Folders in `bound/Armv7E-M` correspond to the implementations in `code/Armv7E-M`.


# Generating twiddle factors
The folder `gen_table` contains programs generating the twiddle factors for the assembly subroutines.
- Folders in `gen_table/Armv7-M` correspond to the implementations in `code/Armv7-M`.
- Folders in `gen_table/Armv7E-M` correspond to the implementations in `code/Armv7E-M`.
- Folders in `gen_table/Armv8-A` correspond to the implementations in `code/Armv8-A`.


# Future works
This is a short summary of Chapter 10 **Future Works**.
- Butterfly scheduling.
    - Generalize the scheduling with $\mathrm{rev}_{(2:k)}^{\mathrm{rev}}$.
- Generalize the CT--GS butterfly.
- Combining vectorization-friendly Good--Thomas and Schönhage.
- Systemization.
- Verification.





















