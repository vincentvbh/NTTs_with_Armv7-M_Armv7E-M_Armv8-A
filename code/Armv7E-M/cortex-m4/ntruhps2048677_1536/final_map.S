
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

#ifdef LOOP
    add.w r11, r0, #(3*115)*strwidth
    _final_loop1:
#else
.rept 23
#endif

.rept 5

    ldr.w r5, [r14, #4*ldrwidth]
    ldr.w r6, [r14, #8*ldrwidth]
    ldr.w r7, [r14, #497*ldrwidth]
    ldr.w r8, [r14, #498*ldrwidth]
    ldr.w r9, [r14, #502*ldrwidth]
    ldr.w r4, [r14], #9*ldrwidth
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

.endr

#ifdef LOOP
    cmp.w r0, r11
    bne.w _final_loop1
#else
.endr
#endif

    ldr.w r4, [r14, #0*ldrwidth]
    ldr.w r5, [r14, #4*ldrwidth]
    ldr.w r7, [r14, #497*ldrwidth]
    ldr.w r8, [r14, #498*ldrwidth]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    str.w r4, [r0], #2*strwidth

    add.w r12, r12, #275*ldrwidth
    sub.w r14, r12, #768*ldrwidth
    sub.w r14, r14, #274*ldrwidth

#ifdef LOOP
    add.w r11, r0, #(3*55)*strwidth
    _final_loop2:
#else
.rept 11
#endif

.rept 5

    ldr.w r5, [r12, #1*ldrwidth]
    ldr.w r6, [r12, #5*ldrwidth]
    ldr.w r4, [r12], #9*ldrwidth
    ldr.w r8, [r14, #4*ldrwidth]
    ldr.w r9, [r14, #5*ldrwidth]
    ldr.w r7, [r14], #9*ldrwidth
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

.endr

#ifdef LOOP
    cmp.w r0, r11
    bne.w _final_loop2
#else
.endr
#endif

    sub.w r14, r14, #(9*55-1)*ldrwidth

#ifdef LOOP
    add.w r11, r0, #(3*54)*strwidth
    _final_loop3:
#else
.rept 9
#endif

.rept 6

    ldr.w r5, [r14, #1*ldrwidth]
    ldr.w r6, [r14, #5*ldrwidth]
    ldr.w r7, [r14, #494*ldrwidth]
    ldr.w r8, [r14, #498*ldrwidth]
    ldr.w r9, [r14, #499*ldrwidth]
    ldr.w r4, [r14], #9*ldrwidth
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

.endr

#ifdef LOOP
    cmp.w r0, r11
    bne.w _final_loop3
#else
.endr
#endif

    ldr.w r4, [r14, #0*ldrwidth]
    ldr.w r5, [r14, #1*ldrwidth]
    ldr.w r6, [r14, #5*ldrwidth]
    ldr.w r7, [r14, #494*ldrwidth]
    ldr.w r8, [r14, #498*ldrwidth]
    movw r9, #0
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth


    pop.w {r4-r12, pc}



