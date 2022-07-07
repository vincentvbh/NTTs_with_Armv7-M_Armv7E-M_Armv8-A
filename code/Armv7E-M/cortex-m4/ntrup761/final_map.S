
#include "macros.i"

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
    ldr.w r8, [r1, #0]
    ldr.w r9, [r1, #4]
    ldr.w r10, [r1, #8]

    vmov.w s10, r10

    add.w r12, r14, #768*ldrwidth

    lsr.w r1, r3, #1

    mov.w r6, #0

// (0, 761)

    add.w r10, r14, #18*43*ldrwidth
    vmov.w s2, r10
    _loop0:

    ldr.w r4, [r14, #(0*3+0)*ldrwidth]
    ldr.w r5, [r14, #(1*3+1)*ldrwidth]
    ldr.w r7, [r14, #(249*3+2)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(250*3+0)*ldrwidth]
    add r5, r6
    add r5, r7
    montgomery_mul_32 r4, r8, r2, r3, r10, r11
    montgomery_mul_32 r5, r8, r2, r3, r10, r11
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    vmov.w r10, s10
    barrett_32 r4, r9, r10, r11
    barrett_32 r5, r9, r10, r11
    pkhbt.w r4, r4, r5, lsl #16
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(2*3+2)*ldrwidth]
    ldr.w r5, [r14, #(3*3+0)*ldrwidth]
    ldr.w r7, [r14, #(251*3+1)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(252*3+2)*ldrwidth]
    add r5, r6
    add r5, r7
    montgomery_mul_32 r4, r8, r2, r3, r10, r11
    montgomery_mul_32 r5, r8, r2, r3, r10, r11
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    vmov.w r10, s10
    barrett_32 r4, r9, r10, r11
    barrett_32 r5, r9, r10, r11
    pkhbt.w r4, r4, r5, lsl #16
    str.w r4, [r0], #2*strwidth

    vmov.w r10, s2
    cmp.w r14, r10
    beq.w _loop0_end

    ldr.w r4, [r14, #(4*3+1)*ldrwidth]
    ldr.w r5, [r14, #(5*3+2)*ldrwidth]
    ldr.w r7, [r14, #(253*3+0)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(254*3+1)*ldrwidth]
    add r5, r6
    add r5, r7
    montgomery_mul_32 r4, r8, r2, r3, r10, r11
    montgomery_mul_32 r5, r8, r2, r3, r10, r11
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    vmov.w r10, s10
    barrett_32 r4, r9, r10, r11
    barrett_32 r5, r9, r10, r11
    pkhbt.w r4, r4, r5, lsl #16
    str.w r4, [r0], #2*strwidth

    add.w r14, r14, #18*ldrwidth

    b.w _loop0

    _loop0_end:

// (262, 1023)

    ldr.w r4, [r14, #(4*3+1)*ldrwidth]
    ldr.w r5, [r14, #(5*3+2)*ldrwidth]
    ldr.w r7, [r14, #(253*3+0)*ldrwidth]
    add r4, r7
    add r4, r6
    sub.w r14, r14, #(18*43)*ldrwidth
    ldr.w r6, [r14, #1*ldrwidth]
    add r5, r6
    add r5, r7
    montgomery_mul_32 r4, r8, r2, r3, r10, r11
    montgomery_mul_32 r5, r8, r2, r3, r10, r11
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    vmov.w r10, s10
    barrett_32 r4, r9, r10, r11
    barrett_32 r5, r9, r10, r11
    pkhbt.w r4, r4, r5, lsl #16
    str.w r4, [r0], #2*strwidth

// (264, 1025)

    add.w r10, r14, #18*41*ldrwidth
    vmov.w s2, r10
    _loop1:

    ldr.w r4, [r12, #(8*3+0)*ldrwidth]
    ldr.w r5, [r12, #(9*3+1)*ldrwidth]
    ldr.w r7, [r14, #(1*3+2)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(2*3+0)*ldrwidth]
    add r5, r6
    add r5, r7
    montgomery_mul_32 r4, r8, r2, r3, r10, r11
    montgomery_mul_32 r5, r8, r2, r3, r10, r11
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    vmov.w r10, s10
    barrett_32 r4, r9, r10, r11
    barrett_32 r5, r9, r10, r11
    pkhbt.w r4, r4, r5, lsl #16
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(10*3+2)*ldrwidth]
    ldr.w r5, [r12, #(11*3+0)*ldrwidth]
    ldr.w r7, [r14, #(3*3+1)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(4*3+2)*ldrwidth]
    add r5, r6
    add r5, r7
    montgomery_mul_32 r4, r8, r2, r3, r10, r11
    montgomery_mul_32 r5, r8, r2, r3, r10, r11
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    vmov.w r10, s10
    barrett_32 r4, r9, r10, r11
    barrett_32 r5, r9, r10, r11
    pkhbt.w r4, r4, r5, lsl #16
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r12, #(12*3+1)*ldrwidth]
    ldr.w r5, [r12, #(13*3+2)*ldrwidth]
    ldr.w r7, [r14, #(5*3+0)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(6*3+1)*ldrwidth]
    add r5, r6
    add r5, r7
    montgomery_mul_32 r4, r8, r2, r3, r10, r11
    montgomery_mul_32 r5, r8, r2, r3, r10, r11
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    vmov.w r10, s10
    barrett_32 r4, r9, r10, r11
    barrett_32 r5, r9, r10, r11
    pkhbt.w r4, r4, r5, lsl #16
    str.w r4, [r0], #2*strwidth

    add.w r12, r12, #18*ldrwidth
    add.w r14, r14, #18*ldrwidth

    vmov.w r10, s2
    cmp.w r14, r10
    bne.w _loop1

    sub.w r12, r12, #18*41*ldrwidth
    sub.w r14, r14, #18*41*ldrwidth

// (510, 1271)

    ldr.w r4, [r12, #(254*3+0)*ldrwidth]
    ldr.w r5, [r12, #(255*3+1)*ldrwidth]
    ldr.w r7, [r14, #(247*3+2)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(248*3+0)*ldrwidth]
    add r5, r6
    add r5, r7
    montgomery_mul_32 r4, r8, r2, r3, r10, r11
    montgomery_mul_32 r5, r8, r2, r3, r10, r11
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    vmov.w r10, s10
    barrett_32 r4, r9, r10, r11
    barrett_32 r5, r9, r10, r11
    pkhbt.w r4, r4, r5, lsl #16
    str.w r4, [r0], #2*strwidth

// (512, 1273)

    add.w r10, r14, #18*41*ldrwidth
    vmov.w s2, r10
    _loop2:

    ldr.w r4, [r14, #(0*3+2)*ldrwidth]
    ldr.w r5, [r14, #(1*3+0)*ldrwidth]
    ldr.w r7, [r14, #(249*3+1)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(250*3+2)*ldrwidth]
    add r5, r6
    add r5, r7
    montgomery_mul_32 r4, r8, r2, r3, r10, r11
    montgomery_mul_32 r5, r8, r2, r3, r10, r11
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    vmov.w r10, s10
    barrett_32 r4, r9, r10, r11
    barrett_32 r5, r9, r10, r11
    pkhbt.w r4, r4, r5, lsl #16
    str.w r4, [r0], #2*strwidth

    vmov.w r10, s2
    cmp.w r14, r10
    beq.w _loop2_end

    ldr.w r4, [r14, #(2*3+1)*ldrwidth]
    ldr.w r5, [r14, #(3*3+2)*ldrwidth]
    ldr.w r7, [r14, #(251*3+0)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(252*3+1)*ldrwidth]
    add r5, r6
    add r5, r7
    montgomery_mul_32 r4, r8, r2, r3, r10, r11
    montgomery_mul_32 r5, r8, r2, r3, r10, r11
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    vmov.w r10, s10
    barrett_32 r4, r9, r10, r11
    barrett_32 r5, r9, r10, r11
    pkhbt.w r4, r4, r5, lsl #16
    str.w r4, [r0], #2*strwidth

    ldr.w r4, [r14, #(4*3+0)*ldrwidth]
    ldr.w r5, [r14, #(5*3+1)*ldrwidth]
    ldr.w r7, [r14, #(253*3+2)*ldrwidth]
    add r4, r7
    add r4, r6
    ldr.w r6, [r14, #(254*3+0)*ldrwidth]
    add r5, r6
    add r5, r7
    montgomery_mul_32 r4, r8, r2, r3, r10, r11
    montgomery_mul_32 r5, r8, r2, r3, r10, r11
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    vmov.w r10, s10
    barrett_32 r4, r9, r10, r11
    barrett_32 r5, r9, r10, r11
    pkhbt.w r4, r4, r5, lsl #16
    str.w r4, [r0], #2*strwidth

    add.w r14, r14, #18*ldrwidth

    b.w _loop2

    _loop2_end:

// (760, 1521)

    ldr.w r4, [r14, #(2*3+1)*ldrwidth]
    add.w r4, r4, r6
    montgomery_mul_32 r4, r8, r2, r3, r10, r11
    central_reduce r4, r1, r3
    vmov.w r10, s10
    barrett_32 r4, r9, r10, r11
    strh.w r4, [r0]








    pop.w {r4-r12, pc}



