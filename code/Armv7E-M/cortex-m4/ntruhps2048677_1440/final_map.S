
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

    add.w r11, r0, #123*strwidth
    _loop0:

    // 0 -> (0, 0)
    // 677 -> (37, 2)

    ldr.w r4, [r14, #0*width]
    ldr.w r5, [r14, #10*width]
    ldr.w r6, [r14, #20*width]
    ldr.w r7, [r14, #335*width]
    ldr.w r8, [r14, #345*width]
    ldr.w r9, [r14, #355*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #30*width]
    ldr.w r5, [r14, #40*width]
    ldr.w r6, [r14, #50*width]
    ldr.w r7, [r14, #365*width]
    ldr.w r8, [r14, #375*width]
    ldr.w r9, [r14, #385*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    cmp.w r0, r11
    beq.w _loop0_end

    ldr.w r4, [r14, #60*width]
    ldr.w r5, [r14, #70*width]
    ldr.w r6, [r14, #80*width]
    ldr.w r7, [r14, #395*width]
    ldr.w r8, [r14, #396*width]
    ldr.w r9, [r14, #406*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r14, r14, #81*width

    b.w _loop0

    _loop0_end:

    sub.w r14, r14, #81*12*width
    sub.w r14, r14, #81*width


    add.w r11, r0, #36*strwidth
    _loop0_tail:

    // 123 = (123, 6)
    // 800 = (0, 8)

    ldr.w r4, [r12, #393*width]
    ldr.w r5, [r12, #403*width]
    ldr.w r6, [r12, #413*width]
    ldr.w r7, [r14, #8*width]
    ldr.w r8, [r14, #9*width]
    ldr.w r9, [r14, #19*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r12, #414*width]
    ldr.w r5, [r12, #424*width]
    ldr.w r6, [r12, #434*width]
    ldr.w r7, [r14, #29*width]
    ldr.w r8, [r14, #39*width]
    ldr.w r9, [r14, #49*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r12, #444*width]
    ldr.w r5, [r12, #454*width]
    ldr.w r6, [r12, #464*width]
    ldr.w r7, [r14, #59*width]
    ldr.w r8, [r14, #69*width]
    ldr.w r9, [r14, #79*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r12, r12, #81*width
    add.w r14, r14, #81*width

    cmp.w r0, r11
    bne.w _loop0_tail

    ldr.w r4, [r12, #393*width]
    ldr.w r7, [r14, #8*width]
    add.w r4, r4, r7
    montgomery_mul_32 r4, r10, r2, r3, r8, r9
    central_reduce r4, r1, r3
    bic.w r4, r4, #0xf800f800
    strh.w r4, [r0], #strwidth

    sub.w r12, r12, #(81*4)*width
    sub.w r14, r14, #(81*4)*width

    add.w r11, r0, #123*strwidth
    _loop1:

    // 160 -> (0, 7)
    // 837 -> (37, 0)

    ldr.w r4, [r14, #7*width]
    ldr.w r5, [r14, #17*width]
    ldr.w r6, [r14, #18*width]
    ldr.w r7, [r14, #333*width]
    ldr.w r8, [r14, #343*width]
    ldr.w r9, [r14, #353*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #28*width]
    ldr.w r5, [r14, #38*width]
    ldr.w r6, [r14, #48*width]
    ldr.w r7, [r14, #363*width]
    ldr.w r8, [r14, #373*width]
    ldr.w r9, [r14, #383*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    cmp.w r0, r11
    beq.w _loop1_end

    ldr.w r4, [r14, #58*width]
    ldr.w r5, [r14, #68*width]
    ldr.w r6, [r14, #78*width]
    ldr.w r7, [r14, #393*width]
    ldr.w r8, [r14, #403*width]
    ldr.w r9, [r14, #413*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r14, r14, #81*width

    b.w _loop1

    _loop1_end:

    sub.w r14, r14, #(81*12)*width
    sub.w r14, r14, #81*width

    add.w r11, r0, #36*strwidth
    _loop1_tail:

    // 283 -> (123, 4)
    // 960 -> (0, 6)

    ldr.w r4, [r12, #391*width]
    ldr.w r5, [r12, #401*width]
    ldr.w r6, [r12, #411*width]
    ldr.w r7, [r14, #6*width]
    ldr.w r8, [r14, #16*width]
    ldr.w r9, [r14, #26*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r12, #421*width]
    ldr.w r5, [r12, #431*width]
    ldr.w r6, [r12, #432*width]
    ldr.w r7, [r14, #27*width]
    ldr.w r8, [r14, #37*width]
    ldr.w r9, [r14, #47*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r12, #442*width]
    ldr.w r5, [r12, #452*width]
    ldr.w r6, [r12, #462*width]
    ldr.w r7, [r14, #57*width]
    ldr.w r8, [r14, #67*width]
    ldr.w r9, [r14, #77*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r12, r12, #81*width
    add.w r14, r14, #81*width

    cmp.w r0, r11
    bne.w _loop1_tail

    ldr.w r4, [r12, #391*width]
    ldr.w r7, [r14, #6*width]
    add.w r4, r4, r7
    montgomery_mul_32 r4, r10, r2, r3, r8, r9
    central_reduce r4, r1, r3
    bic.w r4, r4, #0xf800f800
    strh.w r4, [r0], #strwidth

    sub.w r12, r12, #(81*4)*width
    sub.w r14, r14, #(81*4)*width

    add.w r11, r0, #123*strwidth
    _loop2:

    // 320 -> (0, 5)
    // 997 -> (37, 7)

    ldr.w r4, [r14, #5*width]
    ldr.w r5, [r14, #15*width]
    ldr.w r6, [r14, #25*width]
    ldr.w r7, [r14, #340*width]
    ldr.w r8, [r14, #350*width]
    ldr.w r9, [r14, #351*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #35*width]
    ldr.w r5, [r14, #36*width]
    ldr.w r6, [r14, #46*width]
    ldr.w r7, [r14, #361*width]
    ldr.w r8, [r14, #371*width]
    ldr.w r9, [r14, #381*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    cmp.w r0, r11
    beq.w _loop2_end

    ldr.w r4, [r14, #56*width]
    ldr.w r5, [r14, #66*width]
    ldr.w r6, [r14, #76*width]
    ldr.w r7, [r14, #391*width]
    ldr.w r8, [r14, #401*width]
    ldr.w r9, [r14, #411*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r14, r14, #81*width

    b.w _loop2

    _loop2_end:

    sub.w r14, r14, #(81*12)*width
    sub.w r14, r14, #81*width

    add.w r11, r0, #36*strwidth
    _loop2_tail:

    // 443 -> (123, 2)
    // 1120 -> (0, 4)

    ldr.w r4, [r12, #389*width]
    ldr.w r5, [r12, #399*width]
    ldr.w r6, [r12, #409*width]
    ldr.w r7, [r14, #4*width]
    ldr.w r8, [r14, #14*width]
    ldr.w r9, [r14, #24*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r12, #419*width]
    ldr.w r5, [r12, #429*width]
    ldr.w r6, [r12, #439*width]
    ldr.w r7, [r14, #34*width]
    ldr.w r8, [r14, #44*width]
    ldr.w r9, [r14, #45*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r12, #449*width]
    ldr.w r5, [r12, #450*width]
    ldr.w r6, [r12, #460*width]
    ldr.w r7, [r14, #55*width]
    ldr.w r8, [r14, #65*width]
    ldr.w r9, [r14, #75*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r12, r12, #81*width
    add.w r14, r14, #81*width

    cmp.w r0, r11
    bne.w _loop2_tail

    ldr.w r4, [r12, #389*width]
    ldr.w r7, [r14, #4*width]
    add.w r4, r4, r7
    montgomery_mul_32 r4, r10, r2, r3, r8, r9
    central_reduce r4, r1, r3
    bic.w r4, r4, #0xf800f800
    strh.w r4, [r0], #strwidth

    sub.w r12, r12, #(81*4)*width
    sub.w r14, r14, #(81*4)*width

    add.w r11, r0, #123*strwidth
    _loop3:

    // 480 -> (0, 3)
    // 1157 -> (37, 5)

    ldr.w r4, [r14, #3*width]
    ldr.w r5, [r14, #13*width]
    ldr.w r6, [r14, #23*width]
    ldr.w r7, [r14, #338*width]
    ldr.w r8, [r14, #348*width]
    ldr.w r9, [r14, #358*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #33*width]
    ldr.w r5, [r14, #43*width]
    ldr.w r6, [r14, #53*width]
    ldr.w r7, [r14, #368*width]
    ldr.w r8, [r14, #369*width]
    ldr.w r9, [r14, #379*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    cmp.w r0, r11
    beq.w _loop3_end

    ldr.w r4, [r14, #54*width]
    ldr.w r5, [r14, #64*width]
    ldr.w r6, [r14, #74*width]
    ldr.w r7, [r14, #389*width]
    ldr.w r8, [r14, #399*width]
    ldr.w r9, [r14, #409*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r14, r14, #81*width

    b.w _loop3

    _loop3_end:

    sub.w r14, r14, #(81*12)*width
    sub.w r14, r14, #81*width

    add.w r11, r0, #36*strwidth
    _loop3_tail:

    // 603 -> (123, 0)
    // 1280 -> (0, 2)

    ldr.w r4, [r12, #387*width]
    ldr.w r5, [r12, #397*width]
    ldr.w r6, [r12, #407*width]
    ldr.w r7, [r14, #2*width]
    ldr.w r8, [r14, #12*width]
    ldr.w r9, [r14, #22*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r12, #417*width]
    ldr.w r5, [r12, #427*width]
    ldr.w r6, [r12, #437*width]
    ldr.w r7, [r14, #32*width]
    ldr.w r8, [r14, #42*width]
    ldr.w r9, [r14, #52*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r12, #447*width]
    ldr.w r5, [r12, #457*width]
    ldr.w r6, [r12, #467*width]
    ldr.w r7, [r14, #62*width]
    ldr.w r8, [r14, #63*width]
    ldr.w r9, [r14, #73*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r12, r12, #81*width
    add.w r14, r14, #81*width

    cmp.w r0, r11
    bne.w _loop3_tail

    ldr.w r4, [r12, #387*width]
    ldr.w r7, [r14, #2*width]
    add.w r4, r4, r7
    montgomery_mul_32 r4, r10, r2, r3, r8, r9
    central_reduce r4, r1, r3
    bic.w r4, r4, #0xf800f800
    strh.w r4, [r0], #strwidth

    sub.w r12, r12, #(81*4)*width
    sub.w r14, r14, #(81*4)*width

    add.w r11, r0, #36*strwidth
    _loop_last:

    // 640 -> (0, 1)
    // 1317 (37, 3)

    ldr.w r4, [r14, #1*width]
    ldr.w r5, [r14, #11*width]
    ldr.w r6, [r14, #21*width]
    ldr.w r7, [r14, #336*width]
    ldr.w r8, [r14, #346*width]
    ldr.w r9, [r14, #356*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #31*width]
    ldr.w r5, [r14, #41*width]
    ldr.w r6, [r14, #51*width]
    ldr.w r7, [r14, #366*width]
    ldr.w r8, [r14, #376*width]
    ldr.w r9, [r14, #386*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    ldr.w r4, [r14, #61*width]
    ldr.w r5, [r14, #71*width]
    ldr.w r6, [r14, #72*width]
    ldr.w r7, [r14, #387*width]
    ldr.w r8, [r14, #397*width]
    ldr.w r9, [r14, #407*width]
    final_reducex2 r4, r5, r7, r8, r10, r2, r3, r1
    final_reduce r6, r9, r10, r2, r3, r1, r7, r8
    pkhbt.w r4, r4, r5, lsl #16
    bic.w r4, r4, #0xf800f800
    bic.w r6, r6, #0xf800f800
    strh.w r6, [r0, #2*strwidth]
    str.w r4, [r0], #3*strwidth

    add.w r14, r14, #81*width

    cmp.w r0, r11
    bne.w _loop_last

    ldr.w r4, [r14, #1*width]
    ldr.w r7, [r14, #336*width]
    add.w r4, r4, r7
    montgomery_mul_32 r4, r10, r2, r3, r8, r9
    central_reduce r4, r1, r3
    bic.w r4, r4, #0xf800f800
    strh.w r4, [r0], #strwidth


    pop.w {r4-r12, pc}






