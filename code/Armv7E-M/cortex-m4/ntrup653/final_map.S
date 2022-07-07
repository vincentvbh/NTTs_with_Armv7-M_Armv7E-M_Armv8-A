
#include "macros.i"

.syntax unified
.cpu cortex-m4

.macro final_reducex2 c0, c1, invN, Qprime, Q, Qhalf, f_O_Q, O_Qbar, tmp0, tmp1
    montgomery_mul_32 \c0, \invN, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c1, \invN, \Qprime, \Q, \tmp0, \tmp1
    central_reduce \c0, \Qhalf, \Q
    central_reduce \c1, \Qhalf, \Q
    vmov.w \tmp0, \f_O_Q
    barrett_32 \c0, \O_Qbar, \tmp0, \tmp1
    barrett_32 \c1, \O_Qbar, \tmp0, \tmp1
    pkhbt.w \c0, \c0, \c1, lsl #16
.endm

.macro final_reduce c0, invN, Qprime, Q, Qhalf, f_O_Q, O_Qbar, tmp0, tmp1
    montgomery_mul_32 \c0, \invN, \Qprime, \Q, \tmp0, \tmp1
    central_reduce \c0, \Qhalf, \Q
    vmov.w \tmp0, \f_O_Q
    barrett_32 \c0, \O_Qbar, \tmp0, \tmp1
.endm

.align 2
.global __asm_final_map
.type __asm_final_map, %function
__asm_final_map:
    push.w {r4-r12, lr}

    .equ ldrwidth, 4
    .equ strwidth, 2

    ldr.w r14, [sp, #40]
    ldr.w r8, [r1, #0]
    ldr.w r9, [r1, #4]
    ldr.w r10, [r1, #8]

    vmov.w s10, r10

    add.w r12, r14, #720*ldrwidth

    lsr.w r1, r3, #1

    mov.w r6, #0

// 0 -> (0, 0)
// 653 -> (13, 5)

    add.w r10, r0, #(9*16)*strwidth
    vmov.w s2, r10
    _loop0:

.rept 4

    ldr.w r4, [r14, #(0*9+0)*ldrwidth]
    ldr.w r5, [r14, #(1*9+1)*ldrwidth]
    ldr.w r7, [r14, #(13*9+5)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(14*9+6)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(2*9+2)*ldrwidth]
    ldr.w r5, [r14, #(3*9+3)*ldrwidth]
    ldr.w r7, [r14, #(15*9+7)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(16*9+8)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(4*9+4)*ldrwidth]
    ldr.w r5, [r14, #(5*9+5)*ldrwidth]
    ldr.w r7, [r14, #(17*9+0)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(18*9+1)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(6*9+6)*ldrwidth]
    ldr.w r5, [r14, #(7*9+7)*ldrwidth]
    ldr.w r7, [r14, #(19*9+2)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(20*9+3)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(8*9+8)*ldrwidth]
    ldr.w r7, [r14, #(21*9+4)*ldrwidth]
    add r4, r7
    add r4, r6
    final_reduce r4, r8, r2, r3, r1, s10, r9, r10, r11
    strh.w r4, [r0], #strwidth

    mov.w r6, r7

    add.w r14, r14, #81*ldrwidth

.endr

    vmov.w r10, s2
    cmp.w r0, r10
    bne.w _loop0

// 144 -> (144, 0)
// 797 -> (157, 5)

    ldr.w r4, [r14, #(0*9+0)*ldrwidth]
    ldr.w r5, [r14, #(1*9+1)*ldrwidth]
    ldr.w r7, [r14, #(13*9+5)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(14*9+6)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

// 146 -> (146, 2)
// 799 -> (159, 7)

    ldr.w r4, [r14, #(2*9+2)*ldrwidth]
    ldr.w r5, [r14, #(3*9+3)*ldrwidth]
    ldr.w r7, [r14, #(15*9+7)*ldrwidth]
    add r4, r7
    add r4, r6
    sub.w r14, r14, #(81*16)*ldrwidth
    ldr.w r6, [r14, #(0*9+8)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

// 148 -> (148, 4)
// 801 -> (1, 0)

    ldr.w r4, [r12, #(68*9+4)*ldrwidth]
    ldr.w r5, [r12, #(69*9+5)*ldrwidth]
    ldr.w r7, [r14, #(1*9+0)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(2*9+1)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(70*9+6)*ldrwidth]
    ldr.w r5, [r12, #(71*9+7)*ldrwidth]
    ldr.w r7, [r14, #(3*9+2)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(4*9+3)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

// 152
// 805

    ldr.w r4, [r12, #(72*9+8)*ldrwidth]
    ldr.w r5, [r12, #(73*9+0)*ldrwidth]
    ldr.w r7, [r14, #(5*9+4)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(6*9+5)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(74*9+1)*ldrwidth]
    ldr.w r5, [r12, #(75*9+2)*ldrwidth]
    ldr.w r7, [r14, #(7*9+6)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(8*9+7)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(76*9+3)*ldrwidth]
    ldr.w r5, [r12, #(77*9+4)*ldrwidth]
    ldr.w r7, [r14, #(9*9+8)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(10*9+0)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(78*9+5)*ldrwidth]
    ldr.w r5, [r12, #(79*9+6)*ldrwidth]
    ldr.w r7, [r14, #(11*9+1)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(12*9+2)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

// 160 -> (0, 7)
// 813 -> (13, 3)

    add.w r10, r0, #(9*16)*strwidth
    vmov.w s2, r10
    _loop1:

.rept 4

    ldr.w r4, [r14, #(0*9+7)*ldrwidth]
    ldr.w r5, [r14, #(1*9+8)*ldrwidth]
    ldr.w r7, [r14, #(13*9+3)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(14*9+4)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(2*9+0)*ldrwidth]
    ldr.w r5, [r14, #(3*9+1)*ldrwidth]
    ldr.w r7, [r14, #(15*9+5)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(16*9+6)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(4*9+2)*ldrwidth]
    ldr.w r5, [r14, #(5*9+3)*ldrwidth]
    ldr.w r7, [r14, #(17*9+7)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(18*9+8)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(6*9+4)*ldrwidth]
    ldr.w r5, [r14, #(7*9+5)*ldrwidth]
    ldr.w r7, [r14, #(19*9+0)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(20*9+1)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(8*9+6)*ldrwidth]
    ldr.w r7, [r14, #(21*9+2)*ldrwidth]
    add r4, r7
    add r4, r6
    final_reduce r4, r8, r2, r3, r1, s10, r9, r10, r11
    strh.w r4, [r0], #strwidth

    mov.w r6, r7

    add.w r14, r14, #81*ldrwidth

.endr

    vmov.w r10, s2
    cmp.w r0, r10
    bne.w _loop1

// 304 -> (144, 7)
// 957 -> (157, 3)

    ldr.w r4, [r14, #(0*9+7)*ldrwidth]
    ldr.w r5, [r14, #(1*9+8)*ldrwidth]
    ldr.w r7, [r14, #(13*9+3)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(14*9+4)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

// 306 -> (146, 0)
// 959 -> (159, 5)

    ldr.w r4, [r14, #(2*9+0)*ldrwidth]
    ldr.w r5, [r14, #(3*9+1)*ldrwidth]
    ldr.w r7, [r14, #(15*9+5)*ldrwidth]
    add r4, r7
    add r4, r6
    sub.w r14, r14, #(81*16)*ldrwidth
    ldr.w r6, [r14, #(0*9+6)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

// 308 -> (148, 2)
// 961 -> (1, 7)

    ldr.w r4, [r12, #(68*9+2)*ldrwidth]
    ldr.w r5, [r12, #(69*9+3)*ldrwidth]
    ldr.w r7, [r14, #(1*9+7)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(2*9+8)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(70*9+4)*ldrwidth]
    ldr.w r5, [r12, #(71*9+5)*ldrwidth]
    ldr.w r7, [r14, #(3*9+0)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(4*9+1)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(72*9+6)*ldrwidth]
    ldr.w r5, [r12, #(73*9+7)*ldrwidth]
    ldr.w r7, [r14, #(5*9+2)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(6*9+3)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(74*9+8)*ldrwidth]
    ldr.w r5, [r12, #(75*9+0)*ldrwidth]
    ldr.w r7, [r14, #(7*9+4)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(8*9+5)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(76*9+1)*ldrwidth]
    ldr.w r5, [r12, #(77*9+2)*ldrwidth]
    ldr.w r7, [r14, #(9*9+6)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(10*9+7)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(78*9+3)*ldrwidth]
    ldr.w r5, [r12, #(79*9+4)*ldrwidth]
    ldr.w r7, [r14, #(11*9+8)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(12*9+0)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

// 320 -> (0, 5)
// 973 -> (13, 1)

    add.w r10, r0, #(9*16)*strwidth
    vmov.w s2, r10
    _loop2:

.rept 4

    ldr.w r4, [r14, #(0*9+5)*ldrwidth]
    ldr.w r5, [r14, #(1*9+6)*ldrwidth]
    ldr.w r7, [r14, #(13*9+1)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(14*9+2)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(2*9+7)*ldrwidth]
    ldr.w r5, [r14, #(3*9+8)*ldrwidth]
    ldr.w r7, [r14, #(15*9+3)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(16*9+4)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(4*9+0)*ldrwidth]
    ldr.w r5, [r14, #(5*9+1)*ldrwidth]
    ldr.w r7, [r14, #(17*9+5)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(18*9+6)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(6*9+2)*ldrwidth]
    ldr.w r5, [r14, #(7*9+3)*ldrwidth]
    ldr.w r7, [r14, #(19*9+7)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(20*9+8)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(8*9+4)*ldrwidth]
    ldr.w r7, [r14, #(21*9+0)*ldrwidth]
    add r4, r7
    add r4, r6
    final_reduce r4, r8, r2, r3, r1, s10, r9, r10, r11
    strh.w r4, [r0], #strwidth

    mov.w r6, r7

    add.w r14, r14, #81*ldrwidth

.endr

    vmov.w r10, s2
    cmp.w r0, r10
    bne.w _loop2

// 464 -> (144, 5)
// 1117 -> (157, 1)

    ldr.w r4, [r14, #(0*9+5)*ldrwidth]
    ldr.w r5, [r14, #(1*9+6)*ldrwidth]
    ldr.w r7, [r14, #(13*9+1)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(14*9+2)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

// 466 -> (146, 7)
// 1119 -> (159, 3)

    ldr.w r4, [r14, #(2*9+7)*ldrwidth]
    ldr.w r5, [r14, #(3*9+8)*ldrwidth]
    ldr.w r7, [r14, #(15*9+3)*ldrwidth]
    add r4, r7
    add r4, r6
    sub.w r14, r14, #(81*16)*ldrwidth
    ldr.w r6, [r14, #(0*9+4)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

// 468 -> (148, 0)
// 1121 -> (1, 5)

    ldr.w r4, [r12, #(68*9+0)*ldrwidth]
    ldr.w r5, [r12, #(69*9+1)*ldrwidth]
    ldr.w r7, [r14, #(1*9+5)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(2*9+6)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(70*9+2)*ldrwidth]
    ldr.w r5, [r12, #(71*9+3)*ldrwidth]
    ldr.w r7, [r14, #(3*9+7)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(4*9+8)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(72*9+4)*ldrwidth]
    ldr.w r5, [r12, #(73*9+5)*ldrwidth]
    ldr.w r7, [r14, #(5*9+0)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(6*9+1)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(74*9+6)*ldrwidth]
    ldr.w r5, [r12, #(75*9+7)*ldrwidth]
    ldr.w r7, [r14, #(7*9+2)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(8*9+3)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(76*9+8)*ldrwidth]
    ldr.w r5, [r12, #(77*9+0)*ldrwidth]
    ldr.w r7, [r14, #(9*9+4)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(10*9+5)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(78*9+1)*ldrwidth]
    ldr.w r5, [r12, #(79*9+2)*ldrwidth]
    ldr.w r7, [r14, #(11*9+6)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(12*9+7)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

// 480 -> (0, 3)
// 1133 -> (13, 8)

    add.w r10, r0, #(9*16)*strwidth
    vmov.w s2, r10
    _loop3:

.rept 4

    ldr.w r4, [r14, #(0*9+3)*ldrwidth]
    ldr.w r5, [r14, #(1*9+4)*ldrwidth]
    ldr.w r7, [r14, #(13*9+8)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(14*9+0)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(2*9+5)*ldrwidth]
    ldr.w r5, [r14, #(3*9+6)*ldrwidth]
    ldr.w r7, [r14, #(15*9+1)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(16*9+2)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(4*9+7)*ldrwidth]
    ldr.w r5, [r14, #(5*9+8)*ldrwidth]
    ldr.w r7, [r14, #(17*9+3)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(18*9+4)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(6*9+0)*ldrwidth]
    ldr.w r5, [r14, #(7*9+1)*ldrwidth]
    ldr.w r7, [r14, #(19*9+5)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(20*9+6)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(8*9+2)*ldrwidth]
    ldr.w r7, [r14, #(21*9+7)*ldrwidth]
    add r4, r7
    add r4, r6
    final_reduce r4, r8, r2, r3, r1, s10, r9, r10, r11
    strh.w r4, [r0], #strwidth

    mov.w r6, r7

    add.w r14, r14, #81*ldrwidth

.endr

    vmov.w r10, s2
    cmp.w r0, r10
    bne.w _loop3

// 624 -> (144, 3)
// 1277 -> (157, 8)

    ldr.w r4, [r14, #(0*9+3)*ldrwidth]
    ldr.w r5, [r14, #(1*9+4)*ldrwidth]
    ldr.w r7, [r14, #(13*9+8)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(14*9+0)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

// 626 -> (146, 5)
// 1279 -> (159, 1)

    ldr.w r4, [r14, #(2*9+5)*ldrwidth]
    ldr.w r5, [r14, #(3*9+6)*ldrwidth]
    ldr.w r7, [r14, #(15*9+1)*ldrwidth]
    add r4, r7
    add r4, r6
    sub.w r14, r14, #(81*16)*ldrwidth
    ldr.w r6, [r14, #(0*9+2)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

// 628 -> (148, 7)
// 1281 -> (1, 3)

    ldr.w r4, [r12, #(68*9+7)*ldrwidth]
    ldr.w r5, [r12, #(69*9+8)*ldrwidth]
    ldr.w r7, [r14, #(1*9+3)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(2*9+4)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(70*9+0)*ldrwidth]
    ldr.w r5, [r12, #(71*9+1)*ldrwidth]
    ldr.w r7, [r14, #(3*9+5)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(4*9+6)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(72*9+2)*ldrwidth]
    ldr.w r5, [r12, #(73*9+3)*ldrwidth]
    ldr.w r7, [r14, #(5*9+7)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(6*9+8)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(74*9+4)*ldrwidth]
    ldr.w r5, [r12, #(75*9+5)*ldrwidth]
    ldr.w r7, [r14, #(7*9+0)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(8*9+1)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(76*9+6)*ldrwidth]
    ldr.w r5, [r12, #(77*9+7)*ldrwidth]
    ldr.w r7, [r14, #(9*9+2)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(10*9+3)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(78*9+8)*ldrwidth]
    ldr.w r5, [r12, #(79*9+0)*ldrwidth]
    ldr.w r7, [r14, #(11*9+4)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(12*9+5)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

// 640 -> (0, 1)
// 1293 -> (13, 6)

    ldr.w r4, [r14, #(0*9+1)*ldrwidth]
    ldr.w r5, [r14, #(1*9+2)*ldrwidth]
    ldr.w r7, [r14, #(13*9+6)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(14*9+7)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(2*9+3)*ldrwidth]
    ldr.w r5, [r14, #(3*9+4)*ldrwidth]
    ldr.w r7, [r14, #(15*9+8)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(16*9+0)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(4*9+5)*ldrwidth]
    ldr.w r5, [r14, #(5*9+6)*ldrwidth]
    ldr.w r7, [r14, #(17*9+1)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(18*9+2)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(6*9+7)*ldrwidth]
    ldr.w r5, [r14, #(7*9+8)*ldrwidth]
    ldr.w r7, [r14, #(19*9+3)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(20*9+4)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(8*9+0)*ldrwidth]
    ldr.w r5, [r14, #(9*9+1)*ldrwidth]
    ldr.w r7, [r14, #(21*9+5)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(22*9+6)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(10*9+2)*ldrwidth]
    ldr.w r5, [r14, #(11*9+3)*ldrwidth]
    ldr.w r7, [r14, #(23*9+7)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(24*9+8)*ldrwidth]
    add r5, r6
    add r5, r7
    final_reducex2 r4, r5, r8, r2, r3, r1, s10, r9, r10, r11
    str.w r4, [r0], #2*strwidth

// 652

    ldr.w r4, [r14, #(12*9+4)*ldrwidth]
    ldr.w r7, [r14, #(25*9+0)*ldrwidth]
    add r4, r7
    add r4, r6
    final_reduce r4, r8, r2, r3, r1, s10, r9, r10, r11
    strh.w r4, [r0]








    pop.w {r4-r12, pc}






