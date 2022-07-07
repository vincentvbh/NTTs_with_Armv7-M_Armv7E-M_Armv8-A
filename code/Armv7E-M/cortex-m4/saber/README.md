
# NTT

## 24 MHz
```
polymul: 23077 cycles

polymul with 32-bit and 2x16-bit: 32555 cycles

32-bit NTT: 5855 cycles

16-bit NTT: 4918 cycles

16-bit light NTT: 4470 cycles

32-bit to 16-bit: 1181 cycles

32-bit base_mul: 4186 cycles

16-bit base_mul: 2966 cycles

32x16-bit base_mul: 3734 cycles

CRT: 2439 cycles

32-bit iNTT: 7318 cycles
```

## 168 MHz
```
polymul: 23969 cycles

polymul with 32-bit and 2x16-bit: 33857 cycles

32-bit NTT: 6118 cycles

16-bit NTT: 5163 cycles

16-bit light NTT: 4707 cycles

32-bit to 16-bit: 1250 cycles

32-bit base_mul: 4300 cycles

16-bit base_mul: 3051 cycles

32x16-bit base_mul: 3831 cycles

CRT: 2521 cycles

32-bit iNTT: 7661 cycles
```

# InnerProd

## 24 MHz
```
InnerProd (Enc, A): 38736 cycles

InnerProd (Dec, A): 56172 cycles

InnerProd (Dec, B): 70397 cycles

InnerProd (Dec, C): 56170 cycles

InnerProd (Dec, D): 98847 cycles
```

## 168 MHz
```
InnerProd (Enc, A): 40156 cycles

InnerProd (Dec, A): 58311 cycles

InnerProd (Dec, B): 73288 cycles

InnerProd (Dec, C): 58301 cycles

InnerProd (Dec, D): 102920 cycles
```

# MatrixVecotrMul (Enc)

## 24 MHz
```
MatrixVectorMul (Enc, A): 133587 cycles

MatrixVectorMul (Enc, B): 176277 cycles

MatrixVectorMul (Enc, C): 168417 cycles

MatrixVectorMul (Enc, D): 296370 cycles
```

## 168 MHz
```
MatrixVectorMul (Enc, A): 138386 cycles

MatrixVectorMul (Enc, B): 183335 cycles

MatrixVectorMul (Enc, C): 174556 cycles

MatrixVectorMul (Enc, D): 308516 cycles
```





