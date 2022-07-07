
#include "macros.i"

.macro final_reduce c0, cn, invN, Qprime, Q, Qhalf, tmp0, tmp1
    add.w \c0, \c0, \cn
    montgomery_mul_32 \c0, \invN, \Qprime, \Q, \tmp0, \tmp1
    central_reduce \c0, \Qhalf, \Q
.endm

.macro final_reducex2 c0, c1, cn, cn1, invN, Qprime, Q, Qhalf
    add \c0, \c0, \cn
    add \c1, \c1, \cn1
    montgomery_mul_32 \c0, \invN, \Qprime, \Q, \cn, \cn1
    montgomery_mul_32 \c1, \invN, \Qprime, \Q, \cn, \cn1
    central_reduce \c0, \Qhalf, \Q
    central_reduce \c1, \Qhalf, \Q
.endm

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_final_map
.type __asm_final_map, %function
__asm_final_map:
    push.w {r4-r12, lr}

    .equ ldrwidth, 4
    .equ strwidth, 2

    ldr.w r14, [sp, #40]
    ldr.w r10, [r1, #0]
    add.w r12, r14, #768*ldrwidth

    lsr.w r1, r3, #1

// 0

#ifdef LOOP
    add.w r11, r0, #(3*105)*strwidth
    _final_loop0:
#else
.rept 15
#endif

.rept 7

    ldr.w r5, [r14, #(1*3+1)*ldrwidth]
    ldr.w r6, [r14, #(2*3+2)*ldrwidth]
    ldr.w r7, [r14, #(189*3+2)*ldrwidth]
    ldr.w r8, [r14, #(190*3+0)*ldrwidth]
    ldr.w r9, [r14, #(191*3+1)*ldrwidth]
    ldr.w r4, [r14], #9*ldrwidth
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

.endr

#ifdef LOOP
    cmp.w r0, r11
    bne.w _final_loop0
#else
.endr
#endif

.rept 2

    ldr.w r5, [r14, #(1*3+1)*ldrwidth]
    ldr.w r6, [r14, #(2*3+2)*ldrwidth]
    ldr.w r7, [r14, #(189*3+2)*ldrwidth]
    ldr.w r8, [r14, #(190*3+0)*ldrwidth]
    ldr.w r9, [r14, #(191*3+1)*ldrwidth]
    ldr.w r4, [r14], #9*ldrwidth
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

.endr

    ldr.w r4, [r14, #(0*3+0)*ldrwidth]
    ldr.w r5, [r14, #(1*3+1)*ldrwidth]
    ldr.w r7, [r14, #(189*3+2)*ldrwidth]
    ldr.w r8, [r14, #(190*3+0)*ldrwidth]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    str.w r4, [r0], #2*strwidth

    sub.w r14, r14, #(9*107)*ldrwidth

// 323

#ifdef LOOP
    add.w r11, r0, #(3*63)*strwidth
    _final_loop1:
#else
.rept 9
#endif

.rept 7

    ldr.w r4, [r12, #(67*3+2)*ldrwidth]
    ldr.w r5, [r12, #(68*3+0)*ldrwidth]
    ldr.w r6, [r12, #(69*3+1)*ldrwidth]
    ldr.w r7, [r14, #(0*3+1)*ldrwidth]
    ldr.w r8, [r14, #(1*3+2)*ldrwidth]
    ldr.w r9, [r14, #(2*3+0)*ldrwidth]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r12, r12, #9*ldrwidth
    add.w r14, r14, #9*ldrwidth

.endr

#ifdef LOOP
    cmp.w r0, r11
    bne.w _final_loop1
#else
.endr
#endif

// 512

    sub.w r14, r14, #(9*63)*ldrwidth

#ifdef LOOP
    add.w r11, r0, #(3*63)*strwidth
    _final_loop2:
#else
.rept 9
#endif

.rept 7

    ldr.w r4, [r14, #(0*3+2)*ldrwidth]
    ldr.w r5, [r14, #(1*3+0)*ldrwidth]
    ldr.w r6, [r14, #(2*3+1)*ldrwidth]
    ldr.w r7, [r14, #(189*3+1)*ldrwidth]
    ldr.w r8, [r14, #(190*3+2)*ldrwidth]
    ldr.w r9, [r14, #(191*3+0)*ldrwidth]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r14, r14, #9*ldrwidth

.endr

#ifdef LOOP
    cmp.w r0, r11
    bne.w _final_loop2
#else
.endr
#endif



    pop.w {r4-r12, pc}






