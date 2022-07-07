
#include "macros.i"

.syntax unified
.cpu cortex-m4

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

.align 2
.global __asm_final_map
.type __asm_final_map, %function
__asm_final_map:
    push.w {r4-r12, lr}


    ldr.w r14, [sp, #40]
    add.w r12, r14, #720*4

    mov.w r10, r1
    lsr.w r1, r3, #1

    .equ width, 4
    .equ strwidth, 2

    // 0 -> (0, 0)
    // 701 -> (61, 8)

    add.w r11, r0, #99*strwidth
    _loop0:

    ldr.w r4, [r14, #(0*9+0)*width]
    ldr.w r5, [r14, #(1*9+1)*width]
    ldr.w r6, [r14, #(2*9+2)*width]
    ldr.w r7, [r14, #(61*9+8)*width]
    ldr.w r8, [r14, #(62*9+0)*width]
    ldr.w r9, [r14, #(63*9+1)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(3*9+3)*width]
    ldr.w r5, [r14, #(4*9+4)*width]
    ldr.w r6, [r14, #(5*9+5)*width]
    ldr.w r7, [r14, #(64*9+2)*width]
    ldr.w r8, [r14, #(65*9+3)*width]
    ldr.w r9, [r14, #(66*9+4)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(6*9+6)*width]
    ldr.w r5, [r14, #(7*9+7)*width]
    ldr.w r6, [r14, #(8*9+8)*width]
    ldr.w r7, [r14, #(67*9+5)*width]
    ldr.w r8, [r14, #(68*9+6)*width]
    ldr.w r9, [r14, #(69*9+7)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r14, r14, #81*width

    cmp.w r0, r11
    bne.w _loop0



    sub.w r14, r14, #(81*11)*width

    // 99 -> (99, 0)
    // 800 -> (0, 8)

    add.w r11, r0, #54*strwidth
    _loop1:

    ldr.w r4, [r14, #(99*9+0)*width]
    ldr.w r5, [r14, #(100*9+1)*width]
    ldr.w r6, [r14, #(101*9+2)*width]
    ldr.w r7, [r14, #(0*9+8)*width]
    ldr.w r8, [r14, #(1*9+0)*width]
    ldr.w r9, [r14, #(2*9+1)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(102*9+3)*width]
    ldr.w r5, [r14, #(103*9+4)*width]
    ldr.w r6, [r14, #(104*9+5)*width]
    ldr.w r7, [r14, #(3*9+2)*width]
    ldr.w r8, [r14, #(4*9+3)*width]
    ldr.w r9, [r14, #(5*9+4)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(105*9+6)*width]
    ldr.w r5, [r14, #(106*9+7)*width]
    ldr.w r6, [r14, #(107*9+8)*width]
    ldr.w r7, [r14, #(6*9+5)*width]
    ldr.w r8, [r14, #(7*9+6)*width]
    ldr.w r9, [r14, #(8*9+7)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r14, r14, #81*width

    cmp.w r0, r11
    bne.w _loop1

    ldr.w r4, [r14, #(99*9+0)*width]
    ldr.w r5, [r14, #(100*9+1)*width]
    ldr.w r6, [r14, #(101*9+2)*width]
    ldr.w r7, [r14, #(0*9+8)*width]
    ldr.w r8, [r14, #(1*9+0)*width]
    ldr.w r9, [r14, #(2*9+1)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(102*9+3)*width]
    ldr.w r5, [r14, #(103*9+4)*width]
    ldr.w r6, [r14, #(104*9+5)*width]
    ldr.w r7, [r14, #(3*9+2)*width]
    ldr.w r8, [r14, #(4*9+3)*width]
    ldr.w r9, [r14, #(5*9+4)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(105*9+6)*width]
    ldr.w r7, [r14, #(6*9+5)*width]
    final_reduce r4, r7, r10, r2, r3, r1, r7, r8
    bic.w r4, r4, #0xe000e000
    strh.w r4, [r0], #strwidth

    sub.w r14, r14, #81*6*width

    // 160 -> (0, 7)
    // 861 -> (61, 6)

    add.w r11, r0, #99*strwidth
    _loop2:

    ldr.w r4, [r14, #(0*9+7)*width]
    ldr.w r5, [r14, #(1*9+8)*width]
    ldr.w r6, [r14, #(2*9+0)*width]
    ldr.w r7, [r14, #(61*9+6)*width]
    ldr.w r8, [r14, #(62*9+7)*width]
    ldr.w r9, [r14, #(63*9+8)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(3*9+1)*width]
    ldr.w r5, [r14, #(4*9+2)*width]
    ldr.w r6, [r14, #(5*9+3)*width]
    ldr.w r7, [r14, #(64*9+0)*width]
    ldr.w r8, [r14, #(65*9+1)*width]
    ldr.w r9, [r14, #(66*9+2)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(6*9+4)*width]
    ldr.w r5, [r14, #(7*9+5)*width]
    ldr.w r6, [r14, #(8*9+6)*width]
    ldr.w r7, [r14, #(67*9+3)*width]
    ldr.w r8, [r14, #(68*9+4)*width]
    ldr.w r9, [r14, #(69*9+5)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r14, r14, #81*width

    cmp.w r0, r11
    bne.w _loop2

    sub.w r14, r14, #(81*11)*width

    // 259 -> (99, 7)
    // 960 -> (0, 6)

    add.w r11, r0, #54*strwidth
    _loop3:

    ldr.w r4, [r14, #(99*9+7)*width]
    ldr.w r5, [r14, #(100*9+8)*width]
    ldr.w r6, [r14, #(101*9+0)*width]
    ldr.w r7, [r14, #(0*9+6)*width]
    ldr.w r8, [r14, #(1*9+7)*width]
    ldr.w r9, [r14, #(2*9+8)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(102*9+1)*width]
    ldr.w r5, [r14, #(103*9+2)*width]
    ldr.w r6, [r14, #(104*9+3)*width]
    ldr.w r7, [r14, #(3*9+0)*width]
    ldr.w r8, [r14, #(4*9+1)*width]
    ldr.w r9, [r14, #(5*9+2)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(105*9+4)*width]
    ldr.w r5, [r14, #(106*9+5)*width]
    ldr.w r6, [r14, #(107*9+6)*width]
    ldr.w r7, [r14, #(6*9+3)*width]
    ldr.w r8, [r14, #(7*9+4)*width]
    ldr.w r9, [r14, #(8*9+5)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r14, r14, #81*width

    cmp.w r0, r11
    bne.w _loop3



    ldr.w r4, [r14, #(99*9+7)*width]
    ldr.w r5, [r14, #(100*9+8)*width]
    ldr.w r6, [r14, #(101*9+0)*width]
    ldr.w r7, [r14, #(0*9+6)*width]
    ldr.w r8, [r14, #(1*9+7)*width]
    ldr.w r9, [r14, #(2*9+8)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(102*9+1)*width]
    ldr.w r5, [r14, #(103*9+2)*width]
    ldr.w r6, [r14, #(104*9+3)*width]
    ldr.w r7, [r14, #(3*9+0)*width]
    ldr.w r8, [r14, #(4*9+1)*width]
    ldr.w r9, [r14, #(5*9+2)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(105*9+4)*width]
    ldr.w r7, [r14, #(6*9+3)*width]
    final_reduce r4, r7, r10, r2, r3, r1, r7, r8
    bic.w r4, r4, #0xe000e000
    strh.w r4, [r0], #strwidth

    sub.w r14, r14, #(81*6)*width

    // 320 -> (0, 5)
    // 1021 -> (61, 4)

    add.w r11, r0, #99*strwidth
    _loop4:

    ldr.w r4, [r14, #(0*9+5)*width]
    ldr.w r5, [r14, #(1*9+6)*width]
    ldr.w r6, [r14, #(2*9+7)*width]
    ldr.w r7, [r14, #(61*9+4)*width]
    ldr.w r8, [r14, #(62*9+5)*width]
    ldr.w r9, [r14, #(63*9+6)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(3*9+8)*width]
    ldr.w r5, [r14, #(4*9+0)*width]
    ldr.w r6, [r14, #(5*9+1)*width]
    ldr.w r7, [r14, #(64*9+7)*width]
    ldr.w r8, [r14, #(65*9+8)*width]
    ldr.w r9, [r14, #(66*9+0)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(6*9+2)*width]
    ldr.w r5, [r14, #(7*9+3)*width]
    ldr.w r6, [r14, #(8*9+4)*width]
    ldr.w r7, [r14, #(67*9+1)*width]
    ldr.w r8, [r14, #(68*9+2)*width]
    ldr.w r9, [r14, #(69*9+3)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r14, r14, #81*width

    cmp.w r0, r11
    bne.w _loop4

    sub.w r14, r14, #(81*11)*width

    // 419 -> (99, 5)
    // 1120 -> (0, 4)

    add.w r11, r0, #54*strwidth
    _loop5:

    ldr.w r4, [r14, #(99*9+5)*width]
    ldr.w r5, [r14, #(100*9+6)*width]
    ldr.w r6, [r14, #(101*9+7)*width]
    ldr.w r7, [r14, #(0*9+4)*width]
    ldr.w r8, [r14, #(1*9+5)*width]
    ldr.w r9, [r14, #(2*9+6)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(102*9+8)*width]
    ldr.w r5, [r14, #(103*9+0)*width]
    ldr.w r6, [r14, #(104*9+1)*width]
    ldr.w r7, [r14, #(3*9+7)*width]
    ldr.w r8, [r14, #(4*9+8)*width]
    ldr.w r9, [r14, #(5*9+0)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(105*9+2)*width]
    ldr.w r5, [r14, #(106*9+3)*width]
    ldr.w r6, [r14, #(107*9+4)*width]
    ldr.w r7, [r14, #(6*9+1)*width]
    ldr.w r8, [r14, #(7*9+2)*width]
    ldr.w r9, [r14, #(8*9+3)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r14, r14, #81*width

    cmp.w r0, r11
    bne.w _loop5

    ldr.w r4, [r14, #(99*9+5)*width]
    ldr.w r5, [r14, #(100*9+6)*width]
    ldr.w r6, [r14, #(101*9+7)*width]
    ldr.w r7, [r14, #(0*9+4)*width]
    ldr.w r8, [r14, #(1*9+5)*width]
    ldr.w r9, [r14, #(2*9+6)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(102*9+8)*width]
    ldr.w r5, [r14, #(103*9+0)*width]
    ldr.w r6, [r14, #(104*9+1)*width]
    ldr.w r7, [r14, #(3*9+7)*width]
    ldr.w r8, [r14, #(4*9+8)*width]
    ldr.w r9, [r14, #(5*9+0)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(105*9+2)*width]
    ldr.w r7, [r14, #(6*9+1)*width]
    final_reduce r4, r7, r10, r2, r3, r1, r7, r8
    bic.w r4, r4, #0xe000e000
    strh.w r4, [r0], #strwidth

    sub.w r14, r14, #(81*6)*width

    // 480 -> (0, 3)
    // 1181 -> (61, 2)

    add.w r11, r0, #99*strwidth
    _loop6:

    ldr.w r4, [r14, #(0*9+3)*width]
    ldr.w r5, [r14, #(1*9+4)*width]
    ldr.w r6, [r14, #(2*9+5)*width]
    ldr.w r7, [r14, #(61*9+2)*width]
    ldr.w r8, [r14, #(62*9+3)*width]
    ldr.w r9, [r14, #(63*9+4)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(3*9+6)*width]
    ldr.w r5, [r14, #(4*9+7)*width]
    ldr.w r6, [r14, #(5*9+8)*width]
    ldr.w r7, [r14, #(64*9+5)*width]
    ldr.w r8, [r14, #(65*9+6)*width]
    ldr.w r9, [r14, #(66*9+7)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(6*9+0)*width]
    ldr.w r5, [r14, #(7*9+1)*width]
    ldr.w r6, [r14, #(8*9+2)*width]
    ldr.w r7, [r14, #(67*9+8)*width]
    ldr.w r8, [r14, #(68*9+0)*width]
    ldr.w r9, [r14, #(69*9+1)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r14, r14, #81*width

    cmp.w r0, r11
    bne.w _loop6



    sub.w r14, r14, #(81*11)*width

    // 579 -> (99, 3)
    // 1280 -> (0, 2)

    add.w r11, r0, #54*strwidth
    _loop7:

    ldr.w r4, [r14, #(99*9+3)*width]
    ldr.w r5, [r14, #(100*9+4)*width]
    ldr.w r6, [r14, #(101*9+5)*width]
    ldr.w r7, [r14, #(0*9+2)*width]
    ldr.w r8, [r14, #(1*9+3)*width]
    ldr.w r9, [r14, #(2*9+4)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(102*9+6)*width]
    ldr.w r5, [r14, #(103*9+7)*width]
    ldr.w r6, [r14, #(104*9+8)*width]
    ldr.w r7, [r14, #(3*9+5)*width]
    ldr.w r8, [r14, #(4*9+6)*width]
    ldr.w r9, [r14, #(5*9+7)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(105*9+0)*width]
    ldr.w r5, [r14, #(106*9+1)*width]
    ldr.w r6, [r14, #(107*9+2)*width]
    ldr.w r7, [r14, #(6*9+8)*width]
    ldr.w r8, [r14, #(7*9+0)*width]
    ldr.w r9, [r14, #(8*9+1)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r14, r14, #81*width

    cmp.w r0, r11
    bne.w _loop7

    ldr.w r4, [r14, #(99*9+3)*width]
    ldr.w r5, [r14, #(100*9+4)*width]
    ldr.w r6, [r14, #(101*9+5)*width]
    ldr.w r7, [r14, #(0*9+2)*width]
    ldr.w r8, [r14, #(1*9+3)*width]
    ldr.w r9, [r14, #(2*9+4)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(102*9+6)*width]
    ldr.w r5, [r14, #(103*9+7)*width]
    ldr.w r6, [r14, #(104*9+8)*width]
    ldr.w r7, [r14, #(3*9+5)*width]
    ldr.w r8, [r14, #(4*9+6)*width]
    ldr.w r9, [r14, #(5*9+7)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(105*9+0)*width]
    ldr.w r7, [r14, #(6*9+8)*width]
    final_reduce r4, r7, r10, r2, r3, r1, r7, r8
    bic.w r4, r4, #0xe000e000
    strh.w r4, [r0], #strwidth

    sub.w r14, r14, #(81*6)*width

    // 640 -> (0, 1)
    // 1341 -> (61, 0)

    add.w r11, r0, #54*strwidth
    _loop8:

    ldr.w r4, [r14, #(0*9+1)*width]
    ldr.w r5, [r14, #(1*9+2)*width]
    ldr.w r6, [r14, #(2*9+3)*width]
    ldr.w r7, [r14, #(61*9+0)*width]
    ldr.w r8, [r14, #(62*9+1)*width]
    ldr.w r9, [r14, #(63*9+2)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(3*9+4)*width]
    ldr.w r5, [r14, #(4*9+5)*width]
    ldr.w r6, [r14, #(5*9+6)*width]
    ldr.w r7, [r14, #(64*9+3)*width]
    ldr.w r8, [r14, #(65*9+4)*width]
    ldr.w r9, [r14, #(66*9+5)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(6*9+7)*width]
    ldr.w r5, [r14, #(7*9+8)*width]
    ldr.w r6, [r14, #(8*9+0)*width]
    ldr.w r7, [r14, #(67*9+6)*width]
    ldr.w r8, [r14, #(68*9+7)*width]
    ldr.w r9, [r14, #(69*9+8)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r14, r14, #81*width

    cmp.w r0, r11
    bne.w _loop8

    ldr.w r4, [r14, #(0*9+1)*width]
    ldr.w r5, [r14, #(1*9+2)*width]
    ldr.w r6, [r14, #(2*9+3)*width]
    ldr.w r7, [r14, #(61*9+0)*width]
    ldr.w r8, [r14, #(62*9+1)*width]
    ldr.w r9, [r14, #(63*9+2)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(3*9+4)*width]
    ldr.w r5, [r14, #(4*9+5)*width]
    ldr.w r6, [r14, #(5*9+6)*width]
    ldr.w r7, [r14, #(64*9+3)*width]
    ldr.w r8, [r14, #(65*9+4)*width]
    ldr.w r9, [r14, #(66*9+5)*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xe000e000
    bic.w r6, r6, #0xe000e000
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #(6*9+7)*width]
    ldr.w r7, [r14, #(67*9+6)*width]
    final_reduce r4, r7, r10, r2, r3, r1, r7, r8
    bic.w r4, r4, #0xe000e000
    strh.w r4, [r0]





    pop.w {r4-r12, pc}






