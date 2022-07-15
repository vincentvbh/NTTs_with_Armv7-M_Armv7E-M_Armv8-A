
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
MatrixVectorMul (Enc, A): 635269 cycles

MatrixVectorMul (Enc, B): 904660 cycles

MatrixVectorMul (Enc, C): 832063 cycles

MatrixVectorMul (Enc, D): 1097587 cycles
```

## 120 MHz
```
MatrixVectorMul (Enc, A): 639462 cycles

MatrixVectorMul (Enc, B): 912688 cycles

MatrixVectorMul (Enc, C): 837424 cycles

MatrixVectorMul (Enc, D): 1106774 cycles
```

# InnerProd

## 30 MHz
```
InnerProd (Enc, A): 143856 cycles

InnerProd (Dec, A): 210355 cycles

InnerProd (Dec, B): 280127 cycles

InnerProd (Dec, C): 210352 cycles

InnerProd (Dec, D): 280071 cycles
```

## 120 MHz
```
InnerProd (Enc, A): 144810 cycles

InnerProd (Dec, A): 211701 cycles

InnerProd (Dec, B): 282419 cycles

InnerProd (Dec, C): 211692 cycles

InnerProd (Dec, D): 282335 cycles
```








