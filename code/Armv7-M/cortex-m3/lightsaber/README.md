
# Produced binaries
- `NTT_test.elf`
- `NTT_speed.elf`
- `MatrixVectorMul_test.elf`
- `MatrixVectorMul_speed.elf`
- `InnerProd_test.elf`
- `InnerProd_speed.elf`

# NTT

## 30 MHz
```
polymul: 70089 cycles

16-bit NTT: 8688 cycles

mul: 5987 cycles

16-bit iNTT: 9553 cycles

CRT: 4639 cycles
```

## 120 MHz
```
polymul: 70618 cycles

16-bit NTT: 8775 cycles

mul: 6035 cycles

16-bit iNTT: 9679 cycles

CRT: 4656 cycles
```

# MatrixVecotrMul

## 30 MHz
```
MatrixVectorMul (Enc, A): 204452 cycles

MatrixVectorMul (Enc, B): 249100 cycles

MatrixVectorMul (Enc, C): 239013 cycles

MatrixVectorMul (Enc, D): 283649 cycles
```

## 120 MHz
```
MatrixVectorMul (Enc, A): 205940 cycles

MatrixVectorMul (Enc, B): 251113 cycles

MatrixVectorMul (Enc, C): 240680 cycles

MatrixVectorMul (Enc, D): 285857 cycles
```

# InnerProd

## 30 MHz
```
InnerProd (Enc, A): 84938 cycles

InnerProd (Dec, A): 119488 cycles

InnerProd (Dec, B): 141837 cycles

InnerProd (Dec, C): 119499 cycles

InnerProd (Dec, D): 141835 cycles
```

## 120 MHz
```
InnerProd (Enc, A): 85586 cycles

InnerProd (Dec, A): 120330 cycles

InnerProd (Dec, B): 142960 cycles

InnerProd (Dec, C): 120331 cycles

InnerProd (Dec, D): 142997 cycles
```








