
#include "macros.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_final_map
.type __asm_final_map, %function
__asm_final_map:
    push.w {r4-r12, lr}

    .equ width, 4
    .equ strwidth, 2

    ldr.w r8, [sp, #40]

    ldm.w r1, {r9-r11}

    lsr.w r1, r3, #1

    mov.w r6, #0

#ifdef LOOP
    add.w r12, r8, #(2*428)*width
    vmov.w s2, r12
    _final_loop:
#else
.rept 107
#endif

.rept 4

    ldr.w r5, [r8, #1*width]
    ldr.w r7, [r8, #857*width]
    ldr.w r4, [r8], #2*width
    add r4, r7
    add r4, r6
    ldr.w r6, [r8, #856*width]
    add r5, r6
    add r5, r7
    montgomery_mul_32 r4, r9, r2, r3, r12, r14
    montgomery_mul_32 r5, r9, r2, r3, r12, r14
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    barrett_32 r4, r11, r10, r12
    barrett_32 r5, r11, r10, r12
    pkhbt r4, r4, r5, lsl #16
    str.w r4, [r0], #2*strwidth

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r8, r12
    bne.w _final_loop
#else
.endr
#endif

    ldr.w r7, [r8, #857*width]
    ldr.w r4, [r8], #2*width
    add r4, r7
    add r4, r6
    montgomery_mul_32 r4, r9, r2, r3, r12, r14
    central_reduce r4, r1, r3
    barrett_32 r4, r11, r10, r12
    strh.w r4, [r0]

    pop.w {r4-r12, pc}





