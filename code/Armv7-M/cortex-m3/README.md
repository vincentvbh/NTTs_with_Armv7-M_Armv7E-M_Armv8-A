
This folder contains the implementations of NTTs Saber on Cortex-M3.
We provide the standalone benchmarking environment for the NTT-based `MatrixVectorMul` and `InnerProd` for Saber.

The implementations of the schemes are also included in this thesis.
Note that cryptographic hash functions are required for compilation.
To obtain the benchmarks, replace the implementation folders in `pqm3/crypto_kem` with the ones in `crypto_kem`.

# Requirement
- `arm-none-eabi-gcc` with version 10.2.0
- `python3`
- Board `nucleo-f207zg`. If you use other boards, do the following:
    - Change the settings in the file `config.py`.
    - Provide a linker for your board.
    - Replace the first line `LDSCRIPT   = ../common/nucleo-f207zg.ld` in each `Makefile` with the name of the linker.
- `openocd`

# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| firesaber (100 executions) | m3speed | AVG: 1,519,470 <br /> MIN: 1,519,467 <br /> MAX: 1,519,508 | AVG: 1,838,800 <br /> MIN: 1,838,793 <br /> MAX: 1,838,834 | AVG: 1,915,955 <br /> MIN: 1,915,952 <br /> MAX: 1,915,994 |
| firesaber (100 executions) | m3speedstack | AVG: 1,788,577 <br /> MIN: 1,788,575 <br /> MAX: 1,788,624 | AVG: 2,151,960 <br /> MIN: 2,151,955 <br /> MAX: 2,151,996 | AVG: 2,233,419 <br /> MIN: 2,233,413 <br /> MAX: 2,233,453 |
| firesaber (100 executions) | m3stack | AVG: 2,042,295 <br /> MIN: 2,042,291 <br /> MAX: 2,042,330 | AVG: 2,507,503 <br /> MIN: 2,507,497 <br /> MAX: 2,507,539 | AVG: 2,584,699 <br /> MIN: 2,584,694 <br /> MAX: 2,584,737 |
| lightsaber (100 executions) | m3speed | AVG: 525,511 <br /> MIN: 525,511 <br /> MAX: 525,550 | AVG: 713,961 <br /> MIN: 713,960 <br /> MAX: 713,999 | AVG: 758,359 <br /> MIN: 758,357 <br /> MAX: 758,397 |
| lightsaber (100 executions) | m3speedstack | AVG: 570,172 <br /> MIN: 570,171 <br /> MAX: 570,212 | AVG: 794,930 <br /> MIN: 794,929 <br /> MAX: 794,969 | AVG: 841,603 <br /> MIN: 841,602 <br /> MAX: 841,642 |
| lightsaber (100 executions) | m3stack | AVG: 618,248 <br /> MIN: 618,247 <br /> MAX: 618,286 | AVG: 868,292 <br /> MIN: 868,290 <br /> MAX: 868,330 | AVG: 912,956 <br /> MIN: 912,955 <br /> MAX: 912,996 |
| saber (100 executions) | m3speed | AVG: 973,165 <br /> MIN: 973,163 <br /> MAX: 973,202 | AVG: 1,233,011 <br /> MIN: 1,233,009 <br /> MAX: 1,233,051 | AVG: 1,287,619 <br /> MIN: 1,287,616 <br /> MAX: 1,287,657 |
| saber (100 executions) | m3speedstack | AVG: 1,106,405 <br /> MIN: 1,106,403 <br /> MAX: 1,106,443 | AVG: 1,411,851 <br /> MIN: 1,411,848 <br /> MAX: 1,411,889 | AVG: 1,469,490 <br /> MIN: 1,469,487 <br /> MAX: 1,469,528 |
| saber (100 executions) | m3stack | AVG: 1,238,759 <br /> MIN: 1,238,756 <br /> MAX: 1,238,795 | AVG: 1,602,757 <br /> MIN: 1,602,754 <br /> MAX: 1,602,796 | AVG: 1,657,392 <br /> MIN: 1,657,389 <br /> MAX: 1,657,430 |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| firesaber | m3speed | 7,676 | 8,356 | 8,356 |
| firesaber | m3speedstack | 5,612 | 3,844 | 3,844 |
| firesaber | m3stack | 4,300 | 3,324 | 3,364 |
| lightsaber | m3speed | 5,628 | 6,300 | 6,300 |
| lightsaber | m3speedstack | 4,588 | 3,588 | 3,588 |
| lightsaber | m3stack | 3,276 | 3,068 | 3,364 |
| saber | m3speed | 6,652 | 7,332 | 7,332 |
| saber | m3speedstack | 5,100 | 3,716 | 3,716 |
| saber | m3stack | 3,788 | 3,196 | 3,364 |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
# Hashing Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| firesaber | m3speed | 51.6% | 52.5% | 42.4% |
| firesaber | m3speedstack | 43.8% | 44.9% | 36.4% |
| firesaber | m3stack | 38.4% | 38.5% | 31.5% |
| lightsaber | m3speed | 53.5% | 55.1% | 40.8% |
| lightsaber | m3speedstack | 49.3% | 49.5% | 36.8% |
| lightsaber | m3stack | 45.5% | 45.3% | 33.9% |
| saber | m3speed | 53.2% | 54.4% | 42.4% |
| saber | m3speedstack | 46.8% | 47.5% | 37.2% |
| saber | m3stack | 41.8% | 41.9% | 32.9% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
# Size Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| firesaber | m3speed | 26,152 | 0 | 0 | 26,152 |
| firesaber | m3speedstack | 26,400 | 0 | 0 | 26,400 |
| firesaber | m3stack | 26,140 | 0 | 0 | 26,140 |
| lightsaber | m3speed | 26,328 | 0 | 0 | 26,328 |
| lightsaber | m3speedstack | 26,584 | 0 | 0 | 26,584 |
| lightsaber | m3stack | 26,384 | 0 | 0 | 26,384 |
| saber | m3speed | 26,092 | 0 | 0 | 26,092 |
| saber | m3speedstack | 26,308 | 0 | 0 | 26,308 |
| saber | m3stack | 26,084 | 0 | 0 | 26,084 |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
