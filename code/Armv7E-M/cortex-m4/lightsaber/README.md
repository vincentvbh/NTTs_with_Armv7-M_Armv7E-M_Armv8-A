

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
InnerProd (Enc, A): 28009 cycles

InnerProd (Dec, A): 39621 cycles

InnerProd (Dec, B): 46728 cycles

InnerProd (Dec, C): 39630 cycles

InnerProd (Dec, D): 65698 cycles
```

## 168 MHz
```
InnerProd (Enc, A): 29046 cycles

InnerProd (Dec, A): 41119 cycles

InnerProd (Dec, B): 48591 cycles

InnerProd (Dec, C): 41132 cycles

InnerProd (Dec, D): 68389 cycles
```

# MatrixVecotrMul (Enc)

## 24 MHz
```
MatrixVectorMul (Enc, A): 67624 cycles

MatrixVectorMul (Enc, B): 81844 cycles

MatrixVectorMul (Enc, C): 79225 cycles

MatrixVectorMul (Enc, D): 131373 cycles
```

## 168 MHz
```
MatrixVectorMul (Enc, A): 70172 cycles

MatrixVectorMul (Enc, B): 85109 cycles

MatrixVectorMul (Enc, C): 82177 cycles

MatrixVectorMul (Enc, D): 136671 cycles
```




