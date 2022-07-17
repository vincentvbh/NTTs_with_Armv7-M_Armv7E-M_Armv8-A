
#include "macros.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_base_mul
.type __asm_base_mul, %function
__asm_base_mul:
    push.w {r4-r12, lr}

    .equ width, 4

    vmov.w s9, r0

    vldr.w s0, [sp, #40]
    vldr.w s1, [sp, #44]

    vmov.w s10, r1

#ifdef LOOP
    add.w r12, r0, #1440*width
    vmov.w s7, r12
    _mul_loop:
#else
.rept 16
#endif

    vmov.w r10, s10
    ldr.w r1, [r10], #width
    vmov.w s10, s11, r10, r1

// ================================

#ifdef LOOP
    add.w r14, r0, #9*width
    vmov.w s8, r14
    _mul_pos_loop:
#else
.rept 9
#endif

    vmov.w r0, r1, s0, s1
    ldr.w r5, [r0, #(1*9)*width]
    ldr.w r6, [r0, #(2*9)*width]
    ldr.w r7, [r0, #(3*9)*width]
    ldr.w r8, [r0, #(4*9)*width]
    ldr.w r4, [r0], #width
    ldr.w r10, [r1, #(1*9)*width]
    ldr.w r11, [r1, #(2*9)*width]
    ldr.w r12, [r1, #(3*9)*width]
    ldr.w r14, [r1, #(4*9)*width]
    ldr.w r9, [r1], #width
    vmov.w s0, s1, r0, r1

// c4 = a0 b4 + a1 b3 + a2 b2 + a3 b1 + a4 b0

    smull r0, r1, r4, r14
    smlal r0, r1, r5, r12
    smlal r0, r1, r6, r11
    smlal r0, r1, r7, r10
    smlal r0, r1, r8, r9

    vmov.w s4, r4
    mul.w r4, r0, r2
    smlal r0, r1, r4, r3

    vmov.w r0, s9
    str.w r1, [r0, #(4*9)*width]

// compute b4 * omega
    vmov.w r1, s11
    smull r0, r14, r1, r14
    mul.w r4, r0, r2
    smlal r0, r14, r4, r3

    vmov.w r4, s4

// c3 = a0 b3 + a1 b2 + a2 b1 + a3 b0 + a4 (b4 omega)

    smull r0, r1, r4, r12
    smlal r0, r1, r5, r11
    smlal r0, r1, r6, r10
    smlal r0, r1, r7, r9
    smlal r0, r1, r8, r14

    vmov.w s4, r4
    mul.w r4, r0, r2
    smlal r0, r1, r4, r3

    vmov.w r0, s9
    str.w r1, [r0, #(3*9)*width]

// compute b3 * omega
    vmov.w r1, s11
    smull r0, r12, r1, r12
    mul.w r4, r0, r2
    smlal r0, r12, r4, r3

    vmov.w r4, s4

// c2 = a0 b2 + a1 b1 + a2 b0 + a3 (b4 omega) + a4 (b3 omega)

    smull r0, r1, r4, r11
    smlal r0, r1, r5, r10
    smlal r0, r1, r6, r9
    smlal r0, r1, r7, r14
    smlal r0, r1, r8, r12

    vmov.w s4, r4
    mul.w r4, r0, r2
    smlal r0, r1, r4, r3

    vmov.w r0, s9
    str.w r1, [r0, #(2*9)*width]

// compute b2 * omega
    vmov.w r1, s11
    smull r0, r11, r1, r11
    mul.w r4, r0, r2
    smlal r0, r11, r4, r3

    vmov.w r4, s4

// c1 = a0 b1 + a1 b0 + a2 (b4 omega) + a3 (b3 omega) + a4 (b2 omega)

    smull r0, r1, r4, r10
    smlal r0, r1, r5, r9
    smlal r0, r1, r6, r14
    smlal r0, r1, r7, r12
    smlal r0, r1, r8, r11

    vmov.w s4, r4
    mul.w r4, r0, r2
    smlal r0, r1, r4, r3

    vmov.w r0, s9
    str.w r1, [r0, #(1*9)*width]

// compute b1 * omega
    vmov.w r1, s11
    smull r0, r10, r1, r10
    mul.w r4, r0, r2
    smlal r0, r10, r4, r3

    vmov.w r4, s4

// c0 = a0 b0 + a1 (b4 omega) + a2 (b3 omega) + a3 (b2 omega) + a4 (b1 omega)

    smull r0, r1, r4, r9
    smlal r0, r1, r5, r14
    smlal r0, r1, r6, r12
    smlal r0, r1, r7, r11
    smlal r0, r1, r8, r10

    mul.w r4, r0, r2
    smlal r0, r1, r4, r3

    vmov.w r0, s9
    str.w r1, [r0], #width
    vmov.w s9, r0

#ifdef LOOP
    vmov.w r14, s8
    cmp.w r0, r14
    bne.w _mul_pos_loop
#else
.endr
#endif

    add.w r0, r0, #36*width
    vmov.w s9, r0

    vmov.w r4, r1, s0, s1
    add.w r4, r4, #36*width
    add.w r1, r1, #36*width
    vmov.w s0, s1, r4, r1

// ================

    vmov.w r1, s11
    neg.w r1, r1
    vmov.w s11, r1

// ================

#ifdef LOOP
    add.w r14, r0, #9*width
    vmov.w s8, r14
    _mul_neg_loop:
#else
.rept 9
#endif

    vmov.w r0, r1, s0, s1
    ldr.w r5, [r0, #(1*9)*width]
    ldr.w r6, [r0, #(2*9)*width]
    ldr.w r7, [r0, #(3*9)*width]
    ldr.w r8, [r0, #(4*9)*width]
    ldr.w r4, [r0], #width
    ldr.w r10, [r1, #(1*9)*width]
    ldr.w r11, [r1, #(2*9)*width]
    ldr.w r12, [r1, #(3*9)*width]
    ldr.w r14, [r1, #(4*9)*width]
    ldr.w r9, [r1], #width
    vmov.w s0, s1, r0, r1

// c4 = a0 b4 + a1 b3 + a2 b2 + a3 b1 + a4 b0

    smull r0, r1, r4, r14
    smlal r0, r1, r5, r12
    smlal r0, r1, r6, r11
    smlal r0, r1, r7, r10
    smlal r0, r1, r8, r9

    vmov.w s4, r4
    mul.w r4, r0, r2
    smlal r0, r1, r4, r3

    vmov.w r0, s9
    str.w r1, [r0, #(4*9)*width]

// compute b4 * omega
    vmov.w r1, s11
    smull r0, r14, r1, r14
    mul.w r4, r0, r2
    smlal r0, r14, r4, r3

    vmov.w r4, s4

// c3 = a0 b3 + a1 b2 + a2 b1 + a3 b0 + a4 (b4 omega)

    smull r0, r1, r4, r12
    smlal r0, r1, r5, r11
    smlal r0, r1, r6, r10
    smlal r0, r1, r7, r9
    smlal r0, r1, r8, r14

    vmov.w s4, r4
    mul.w r4, r0, r2
    smlal r0, r1, r4, r3

    vmov.w r0, s9
    str.w r1, [r0, #(3*9)*width]

// compute b3 * omega
    vmov.w r1, s11
    smull r0, r12, r1, r12
    mul.w r4, r0, r2
    smlal r0, r12, r4, r3

    vmov.w r4, s4

// c2 = a0 b2 + a1 b1 + a2 b0 + a3 (b4 omega) + a4 (b3 omega)

    smull r0, r1, r4, r11
    smlal r0, r1, r5, r10
    smlal r0, r1, r6, r9
    smlal r0, r1, r7, r14
    smlal r0, r1, r8, r12

    vmov.w s4, r4
    mul.w r4, r0, r2
    smlal r0, r1, r4, r3

    vmov.w r0, s9
    str.w r1, [r0, #(2*9)*width]

// compute b2 * omega
    vmov.w r1, s11
    smull r0, r11, r1, r11
    mul.w r4, r0, r2
    smlal r0, r11, r4, r3

    vmov.w r4, s4

// c1 = a0 b1 + a1 b0 + a2 (b4 omega) + a3 (b3 omega) + a4 (b2 omega)

    smull r0, r1, r4, r10
    smlal r0, r1, r5, r9
    smlal r0, r1, r6, r14
    smlal r0, r1, r7, r12
    smlal r0, r1, r8, r11

    vmov.w s4, r4
    mul.w r4, r0, r2
    smlal r0, r1, r4, r3

    vmov.w r0, s9
    str.w r1, [r0, #(1*9)*width]

// compute b1 * omega
    vmov.w r1, s11
    smull r0, r10, r1, r10
    mul.w r4, r0, r2
    smlal r0, r10, r4, r3

    vmov.w r4, s4

// c0 = a0 b0 + a1 (b4 omega) + a2 (b3 omega) + a3 (b2 omega) + a4 (b1 omega)

    smull r0, r1, r4, r9
    smlal r0, r1, r5, r14
    smlal r0, r1, r6, r12
    smlal r0, r1, r7, r11
    smlal r0, r1, r8, r10

    mul.w r4, r0, r2
    smlal r0, r1, r4, r3

    vmov.w r0, s9
    str.w r1, [r0], #width
    vmov.w s9, r0

#ifdef LOOP
    vmov.w r14, s8
    cmp.w r0, r14
    bne.w _mul_neg_loop
#else
.endr
#endif

    add.w r0, r0, #36*width
    vmov.w s9, r0

    vmov.w r4, r1, s0, s1
    add.w r4, r4, #36*width
    add.w r1, r1, #36*width
    vmov.w s0, s1, r4, r1

// ================================

#ifdef LOOP
    vmov.w r12, s7
    cmp.w r0, r12
    bne.w _mul_loop
#else
.endr
#endif


    pop.w {r4-r12, pc}







