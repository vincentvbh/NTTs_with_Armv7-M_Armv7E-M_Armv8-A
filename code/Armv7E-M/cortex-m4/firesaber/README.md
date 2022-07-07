

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
InnerProd (Enc, A): 49456 cycles

InnerProd (Dec, A): 72708 cycles

InnerProd (Dec, B): 94049 cycles

InnerProd (Dec, C): 72706 cycles

InnerProd (Dec, D): 131993 cycles
```

## 168 MHz
```
InnerProd (Enc, A): 51165 cycles

InnerProd (Dec, A): 75404 cycles

InnerProd (Dec, B): 97855 cycles

InnerProd (Dec, C): 75354 cycles

InnerProd (Dec, D): 137372 cycles
```

# MatrixVecotrMul (Enc)

## 24 MHz
```
MatrixVectorMul (Enc, A): 221006 cycles

MatrixVectorMul (Enc, B): 306387 cycles

MatrixVectorMul (Enc, C): 290681 cycles

MatrixVectorMul (Enc, D): 527770 cycles
```

## 168 MHz
```
MatrixVectorMul (Enc, A): 228741 cycles

MatrixVectorMul (Enc, B): 318609 cycles

MatrixVectorMul (Enc, C): 301200 cycles

MatrixVectorMul (Enc, D): 549413 cycles
```




