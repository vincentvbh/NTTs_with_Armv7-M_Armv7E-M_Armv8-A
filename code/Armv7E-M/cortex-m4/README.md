
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

# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| ntrulpr653 (100 executions) | m4f | AVG: 666,612 <br /> MIN: 666,611 <br /> MAX: 666,645 | AVG: 1,127,274 <br /> MIN: 1,127,272 <br /> MAX: 1,127,306 | AVG: 1,225,805 <br /> MIN: 1,225,803 <br /> MAX: 1,225,839 |
| ntrulpr761 (100 executions) | m4f | AVG: 709,917 <br /> MIN: 709,916 <br /> MAX: 709,950 | AVG: 1,266,367 <br /> MIN: 1,266,365 <br /> MAX: 1,266,400 | AVG: 1,365,333 <br /> MIN: 1,365,331 <br /> MAX: 1,365,366 |
| ntrulpr857 (100 executions) | m4f | AVG: 882,449 <br /> MIN: 882,448 <br /> MAX: 882,486 | AVG: 1,460,221 <br /> MIN: 1,460,219 <br /> MAX: 1,460,254 | AVG: 1,587,772 <br /> MIN: 1,587,769 <br /> MAX: 1,587,803 |
| ntrulpr953 (100 executions) | m4f | AVG: 967,101 <br /> MIN: 967,099 <br /> MAX: 967,135 | AVG: 1,591,751 <br /> MIN: 1,591,748 <br /> MAX: 1,591,784 | AVG: 1,717,839 <br /> MIN: 1,717,836 <br /> MAX: 1,717,872 |
| ntrulpr1013 (100 executions) | m4f | AVG: 1,059,377 <br /> MIN: 1,059,375 <br /> MAX: 1,059,410 | AVG: 1,741,947 <br /> MIN: 1,741,945 <br /> MAX: 1,741,979 | AVG: 1,898,899 <br /> MIN: 1,898,896 <br /> MAX: 1,898,930 |
| ntrulpr1277 (100 executions) | m4f | AVG: 1,359,711 <br /> MIN: 1,359,709 <br /> MAX: 1,359,745 | AVG: 2,206,544 <br /> MIN: 2,206,540 <br /> MAX: 2,206,574 | AVG: 2,401,460 <br /> MIN: 2,401,456 <br /> MAX: 2,401,491 |
| sntrup653 (100 executions) | m4f | AVG: 6,673,287 <br /> MIN: 6,623,665 <br /> MAX: 7,863,891 | AVG: 618,941 <br /> MIN: 618,941 <br /> MAX: 618,976 | AVG: 522,405 <br /> MIN: 522,405 <br /> MAX: 522,441 |
| sntrup761 (100 executions) | m4f | AVG: 7,936,990 <br /> MIN: 7,936,975 <br /> MAX: 7,937,010 | AVG: 666,492 <br /> MIN: 666,491 <br /> MAX: 666,525 | AVG: 562,694 <br /> MIN: 562,693 <br /> MAX: 562,728 |
| sntrup857 (100 executions) | m4f | AVG: 10,188,830 <br /> MIN: 10,188,810 <br /> MAX: 10,188,846 | AVG: 808,949 <br /> MIN: 808,948 <br /> MAX: 808,983 | AVG: 679,149 <br /> MIN: 679,148 <br /> MAX: 679,182 |
| sntrup953 (100 executions) | m4f | AVG: 12,698,384 <br /> MIN: 12,675,241 <br /> MAX: 14,987,085 | AVG: 895,773 <br /> MIN: 895,773 <br /> MAX: 895,806 | AVG: 733,290 <br /> MIN: 733,289 <br /> MAX: 733,323 |
| sntrup1013 (100 executions) | m4f | AVG: 13,840,955 <br /> MIN: 13,840,928 <br /> MAX: 13,840,965 | AVG: 981,193 <br /> MIN: 981,191 <br /> MAX: 981,226 | AVG: 826,650 <br /> MIN: 826,649 <br /> MAX: 826,683 |
| sntrup1277 (100 executions) | m4f | AVG: 22,983,973 <br /> MIN: 22,755,854 <br /> MAX: 26,557,649 | AVG: 1,253,400 <br /> MIN: 1,253,387 <br /> MAX: 1,253,433 | AVG: 1,058,260 <br /> MIN: 1,058,257 <br /> MAX: 1,058,292 |
| firesaber (100 executions) | m4fspeed | AVG: 988,958 <br /> MIN: 988,956 <br /> MAX: 988,990 | AVG: 1,198,654 <br /> MIN: 1,198,652 <br /> MAX: 1,198,686 | AVG: 1,144,025 <br /> MIN: 1,144,023 <br /> MAX: 1,144,058 |
| firesaber (100 executions) | m4fstack | AVG: 1,325,658 <br /> MIN: 1,325,656 <br /> MAX: 1,325,691 | AVG: 1,623,530 <br /> MIN: 1,623,527 <br /> MAX: 1,623,563 | AVG: 1,604,900 <br /> MIN: 1,604,897 <br /> MAX: 1,604,931 |
| lightsaber (100 executions) | m4fspeed | AVG: 351,686 <br /> MIN: 351,686 <br /> MAX: 351,686 | AVG: 479,970 <br /> MIN: 479,970 <br /> MAX: 479,970 | AVG: 451,353 <br /> MIN: 451,353 <br /> MAX: 451,353 |
| lightsaber (100 executions) | m4fstack | AVG: 423,931 <br /> MIN: 423,931 <br /> MAX: 423,965 | AVG: 593,825 <br /> MIN: 593,825 <br /> MAX: 593,858 | AVG: 583,921 <br /> MIN: 583,921 <br /> MAX: 583,954 |
| saber (100 executions) | m4fspeed | AVG: 643,940 <br /> MIN: 643,939 <br /> MAX: 643,973 | AVG: 818,790 <br /> MIN: 818,789 <br /> MAX: 818,823 | AVG: 771,609 <br /> MIN: 771,607 <br /> MAX: 771,641 |
| saber (100 executions) | m4fstack | AVG: 823,419 <br /> MIN: 823,418 <br /> MAX: 823,452 | AVG: 1,062,899 <br /> MIN: 1,062,898 <br /> MAX: 1,062,932 | AVG: 1,042,933 <br /> MIN: 1,042,931 <br /> MAX: 1,042,965 |

## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| ntrulpr1013 | m4f | 25,732 | 32,068 | 33,644 |
| ntrulpr1277 | m4f | 32,132 | 39,900 | 41,868 |
| ntrulpr653 | m4f | 18,152 | 22,720 | 23,736 |
| ntrulpr761 | m4f | 19,404 | 23,148 | 27,204 |
| ntrulpr857 | m4f | 21,812 | 34,156 | 35,468 |
| ntrulpr953 | m4f | 24,140 | 30,124 | 31,596 |
| sntrup653 | m4f | 90,632 | 17,816 | 21,592 |
| sntrup761 | m4f | 102,592 | 19,548 | 23,180 |
| sntrup1277 | m4f | 87,720 | 31,788 | 38,748 |
| firesaber | m4fspeed | 7,668 | 8,340 | 8,348 |
| firesaber | m4fstack | 4,300 | 3,316 | 3,324 |
| lightsaber | m4fspeed | 5,612 | 6,276 | 6,284 |
| lightsaber | m4fstack | 3,276 | 3,052 | 3,060 |
| saber | m4fspeed | 6,644 | 7,316 | 7,324 |
| saber | m4fstack | 3,788 | 3,180 | 3,188 |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
# Hashing Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| ntrulpr1013 | m4f | 21.7% | 40.8% | 37.4% |
| ntrulpr1277 | m4f | 21.3% | 40.5% | 37.2% |
| ntrulpr653 | m4f | 22.3% | 40.9% | 37.6% |
| ntrulpr761 | m4f | 24.3% | 42.4% | 39.4% |
| ntrulpr857 | m4f | 22.0% | 41.4% | 38.0% |
| ntrulpr953 | m4f | 22.3% | 42.1% | 39.0% |
| sntrup653 | m4f | 0.0% | 0.0% | 0.0% |
| sntrup761 | m4f | 0.0% | 0.0% | 0.0% |
| sntrup1277 | m4f | 0.0% | 0.0% | 0.0% |
| firesaber | m4fspeed | 71.8% | 73.0% | 64.4% |
| firesaber | m4fstack | 53.6% | 53.9% | 45.9% |
| lightsaber | m4fspeed | 72.4% | 74.1% | 62.0% |
| lightsaber | m4fstack | 60.1% | 60.0% | 48.0% |
| saber | m4fspeed | 72.8% | 74.2% | 64.1% |
| saber | m4fstack | 57.0% | 57.2% | 47.4% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
# Size Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| ntrulpr1013 | m4f | 30,152 | 0 | 0 | 30,152 |
| ntrulpr1277 | m4f | 57,200 | 0 | 0 | 57,200 |
| ntrulpr653 | m4f | 44,256 | 0 | 0 | 44,256 |
| ntrulpr761 | m4f | 28,184 | 0 | 0 | 28,184 |
| ntrulpr857 | m4f | 43,740 | 0 | 0 | 43,740 |
| ntrulpr953 | m4f | 133,340 | 0 | 0 | 133,340 |
| sntrup653 | m4f | 264,556 | 0 | 0 | 264,556 |
| sntrup761 | m4f | 357,744 | 0 | 0 | 357,744 |
| sntrup1277 | m4f | 400,096 | 0 | 0 | 400,096 |
| firesaber | m4fspeed | 16,980 | 0 | 0 | 16,980 |
| firesaber | m4fstack | 16,980 | 0 | 0 | 16,980 |
| lightsaber | m4fspeed | 17,108 | 0 | 0 | 17,108 |
| lightsaber | m4fstack | 17,108 | 0 | 0 | 17,108 |
| saber | m4fspeed | 16,876 | 0 | 0 | 16,876 |
| saber | m4fstack | 16,876 | 0 | 0 | 16,876 |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |





