
#include "macros.i"
#include "butterflies.i"
#include "special_butterflies.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_Good_3x2
.type __asm_Good_3x2, %function
__asm_Good_3x2:
    push.w {r4-r12, lr}

    .equ ldrwidth, 2
    .equ strwidth, 4

    ldm.w r1, {r10-r11}

    ldr.w r14, [sp, #40]

    add.w r12, r0, #(9*86)*strwidth
    _Good_3x2:

    ldrsh.w r6, [r14, #512*ldrwidth]
    ldrsh.w r8, [r14, #256*ldrwidth]
    ldrsh.w r4, [r14], #3*ldrwidth
    _6_ntt_101 r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #770*strwidth]
    str.w r8, [r0, #769*strwidth]
    str.w r7, [r0, #768*strwidth]
    str.w r6, [r0, #2*strwidth]
    str.w r5, [r0, #1*strwidth]
    str.w r4, [r0], #9*strwidth

    cmp.w r0, r12
    beq.w _Good_3x2_end

    ldrsh.w r5, [r14, #(514-3)*ldrwidth]
    ldrsh.w r6, [r14, #(2-3)*ldrwidth]
    ldrsh.w r7, [r14, #(258-3)*ldrwidth]
    _6_ntt_011 r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #(776-9)*strwidth]
    str.w r8, [r0, #(775-9)*strwidth]
    str.w r7, [r0, #(774-9)*strwidth]
    str.w r6, [r0, #(8-9)*strwidth]
    str.w r5, [r0, #(7-9)*strwidth]
    str.w r4, [r0, #(6-9)*strwidth]

    ldrsh.w r4, [r14, #(513-3)*ldrwidth]
    ldrsh.w r5, [r14, #(1-3)*ldrwidth]
    ldrsh.w r9, [r14, #(257-3)*ldrwidth]
    _6_ntt_110 r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #(773-9)*strwidth]
    str.w r8, [r0, #(772-9)*strwidth]
    str.w r7, [r0, #(771-9)*strwidth]
    str.w r6, [r0, #(5-9)*strwidth]
    str.w r5, [r0, #(4-9)*strwidth]
    str.w r4, [r0, #(3-9)*strwidth]

    b.w _Good_3x2

    _Good_3x2_end:

    pop.w {r4-r12, pc}

.align 2
.global __asm_Good_3x2_small
.type __asm_Good_3x2_small, %function
__asm_Good_3x2_small:
    push.w {r4-r12, lr}

    .equ ldrwidth, 1
    .equ strwidth, 4

    ldm.w r1, {r10-r11}

    ldr.w r14, [sp, #40]

    add.w r12, r0, #(9*86)*strwidth
    _Good_3x2_small:

    ldrsb.w r6, [r14, #512*ldrwidth]
    ldrsb.w r8, [r14, #256*ldrwidth]
    ldrsb.w r4, [r14], #3*ldrwidth
    _6_ntt_101_small r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #770*strwidth]
    str.w r8, [r0, #769*strwidth]
    str.w r7, [r0, #768*strwidth]
    str.w r6, [r0, #2*strwidth]
    str.w r5, [r0, #1*strwidth]
    str.w r4, [r0], #9*strwidth

    cmp.w r0, r12
    beq.w _Good_3x2_small_end

    ldrsb.w r5, [r14, #(514-3)*ldrwidth]
    ldrsb.w r6, [r14, #(2-3)*ldrwidth]
    ldrsb.w r7, [r14, #(258-3)*ldrwidth]
    _6_ntt_011_small r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #(776-9)*strwidth]
    str.w r8, [r0, #(775-9)*strwidth]
    str.w r7, [r0, #(774-9)*strwidth]
    str.w r6, [r0, #(8-9)*strwidth]
    str.w r5, [r0, #(7-9)*strwidth]
    str.w r4, [r0, #(6-9)*strwidth]

    ldrsb.w r4, [r14, #(513-3)*ldrwidth]
    ldrsb.w r5, [r14, #(1-3)*ldrwidth]
    ldrsb.w r9, [r14, #(257-3)*ldrwidth]
    _6_ntt_110_small r4, r7, r5, r8, r6, r9, r10, r11, r2, r3, r1
    str.w r9, [r0, #(773-9)*strwidth]
    str.w r8, [r0, #(772-9)*strwidth]
    str.w r7, [r0, #(771-9)*strwidth]
    str.w r6, [r0, #(5-9)*strwidth]
    str.w r5, [r0, #(4-9)*strwidth]
    str.w r4, [r0, #(3-9)*strwidth]

    b.w _Good_3x2_small

    _Good_3x2_small_end:


    pop.w {r4-r12, pc}













