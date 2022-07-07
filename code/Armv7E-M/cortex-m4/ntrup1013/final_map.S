
#include "macros.i"

.macro map_and_store des, src, a0, a1, ap, ap1, mem1, memp, memp1, jump, jump2, invN, Qprime, Q, Qhalf, Qbar, OQbar, OQ tmp0, tmp1

    ldr.w \ap, [\src, \memp]
    ldr.w \a1, [\src, \mem1]
    ldr.w \a0, [\src], \jump
    add \a0, \ap1
    add \a0, \ap
    ldr.w \ap1, [\src, \memp1]
    vmov.w \tmp1, \Qbar
    barrett_32 \ap1, \tmp1, \Q, \tmp0
    add \a1, \ap
    add \a1, \ap1
    montgomery_mul_32 \a0, \invN, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \a1, \invN, \Qprime, \Q, \tmp0, \tmp1
    central_reduce \a0, \Qhalf, \Q
    central_reduce \a1, \Qhalf, \Q
    barrett_32 \a0, \OQbar, \OQ, \tmp0
    barrett_32 \a1, \OQbar, \OQ, \tmp0
    pkhbt \a0, \a0, \a1, lsl #16
    str.w \a0, [\des], \jump2

.endm

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_final_map
.type __asm_final_map, %function
__asm_final_map:
    push.w {r4-r12, lr}

    mov.w r6, r0
    ldr.w r0, [sp, #40]

    ldr.w r11, [r1, #0]
    ldr.w r12, [r1, #4]
    ldr.w r14, [r1, #8]
    vldr.w s4, [r1, #12]

    lsr.w r1, r3, #1

    .equ width, 4
    .equ strwidth, 2

    movw r8, #0

#ifdef LOOP
    add.w r9, r0, #4032
    vmov.w s2, r9
    _final_loop:
#else
.rept 56
#endif

// ================================

.rept 9
    map_and_store r6, r0, r4, r5, r7, r8, #width, #1013*width, #(1014-2)*width, #2*width, #width r11, r2, r3, r1, s4, r12, r14, r9, r10
.endr

// ================================

#ifdef LOOP
    vmov.w r9, s2
    cmp.w r0, r9
    bne.w _final_loop
#else
.endr
#endif

.rept 2
    map_and_store r6, r0, r4, r5, r7, r8, #width, #1013*width, #(1014-2)*width, #2*width, #width r11, r2, r3, r1, s4, r12, r14, r9, r10
.endr


    ldr.w r7, [r0, #4052]
    ldr.w r4, [r0]
    add r4, r8
    add r4, r7
    montgomery_mul_32 r4, r11, r2, r3, r9, r10
    central_reduce r4, r1, r3
    barrett_32 r4, r12, r14, r9
    strh.w r4, [r6]

    pop.w {r4-r12, pc}




