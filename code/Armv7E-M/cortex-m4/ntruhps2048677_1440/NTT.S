
#include "macros.i"
#include "butterflies.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_3x2block_ntt
.type __asm_3x2block_ntt, %function
__asm_3x2block_ntt:
    push.w {r4-r12, lr}
    vpush.w {s16-s20}

    .equ width, 4

    vldm.w r1, {s4-s18}

// ================================

    vmov.w r10, r11, s5, s6

#ifdef LOOP
    add.w r1, r0, #360*width
    _3x2_00:
#else
.rept 10
#endif

.rept 4

    ldm.w r0, {r4-r6}
    ldr.w r7, [r0, #(360+0)*width]
    ldr.w r8, [r0, #(360+1)*width]
    ldr.w r9, [r0, #(360+2)*width]

    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9

    _3_ntt_light r4, r5, r6, r10, r11, r2, r3, r12, r14
    _3_ntt_light r7, r8, r9, r10, r11, r2, r3, r12, r14

    str.w r5, [r0, #1*width]
    str.w r6, [r0, #2*width]
    str.w r7, [r0, #(360+0)*width]
    str.w r8, [r0, #(360+1)*width]
    str.w r9, [r0, #(360+2)*width]
    str.w r4, [r0], #9*width

.endr

#ifdef LOOP
    cmp.w r0, r1
    bne.w _3x2_00
#else
.endr
#endif

    sub.w r0, r0, #360*width
    add.w r0, r0, #3*width

// ================

    vmov.w r10, r11, s9, s10

#ifdef LOOP
    add.w r12, r0, #360*width
    vmov.w s2, r12
    _3x2_01:
#else
.rept 10
#endif

.rept 4

    ldm.w r0, {r4-r6}
    ldr.w r7, [r0, #(360+0)*width]
    ldr.w r8, [r0, #(360+1)*width]
    ldr.w r9, [r0, #(360+2)*width]

    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9

    _3_ntt r4, r5, r6, s7, s8, r10, r11, r1, r2, r3, r12, r14
    _3_ntt r7, r8, r9, s7, s8, r10, r11, r1, r2, r3, r12, r14

    str.w r5, [r0, #1*width]
    str.w r6, [r0, #2*width]
    str.w r7, [r0, #(360+0)*width]
    str.w r8, [r0, #(360+1)*width]
    str.w r9, [r0, #(360+2)*width]
    str.w r4, [r0], #9*width

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3x2_01
#else
.endr
#endif

    sub.w r0, r0, #360*width
    add.w r0, r0, #3*width

// ================

    vmov.w r10, r11, s11, s12

#ifdef LOOP
    add.w r12, r0, #360*width
    vmov.w s2, r12
    _3x2_02:
#else
.rept 10
#endif

.rept 4

    ldm.w r0, {r4-r6}
    ldr.w r7, [r0, #(360+0)*width]
    ldr.w r8, [r0, #(360+1)*width]
    ldr.w r9, [r0, #(360+2)*width]

    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9

    _3_ntt r4, r5, r6, s8, s9, r10, r11, r1, r2, r3, r12, r14
    _3_ntt r7, r8, r9, s8, s9, r10, r11, r1, r2, r3, r12, r14

    str.w r5, [r0, #1*width]
    str.w r6, [r0, #2*width]
    str.w r7, [r0, #(360+0)*width]
    str.w r8, [r0, #(360+1)*width]
    str.w r9, [r0, #(360+2)*width]
    str.w r4, [r0], #9*width

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3x2_02
#else
.endr
#endif

    sub.w r0, r0, #360*width
    sub.w r0, r0, #6*width

    add.w r0, r0, #720*width

// ================================

    vmov.w r10, r11, s5, s6

#ifdef LOOP
    add.w r12, r0, #360*width
    vmov.w s2, r12
    _3x2_10:
#else
.rept 10
#endif

.rept 4

    ldm.w r0, {r4-r6}
    ldr.w r7, [r0, #(360+0)*width]
    ldr.w r8, [r0, #(360+1)*width]
    ldr.w r9, [r0, #(360+2)*width]

    vmov.w r1, s4
    montgomery_mul_32 r7, r1, r2, r3, r12, r14
    montgomery_mul_32 r8, r1, r2, r3, r12, r14
    montgomery_mul_32 r9, r1, r2, r3, r12, r14

    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9

    _3_ntt_light r4, r5, r6, r10, r11, r2, r3, r12, r14
    _3_ntt_light r7, r8, r9, r10, r11, r2, r3, r12, r14

    str.w r5, [r0, #1*width]
    str.w r6, [r0, #2*width]
    str.w r7, [r0, #(360+0)*width]
    str.w r8, [r0, #(360+1)*width]
    str.w r9, [r0, #(360+2)*width]
    str.w r4, [r0], #9*width

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3x2_10
#else
.endr
#endif

    sub.w r0, r0, #360*width
    add.w r0, r0, #3*width

// ================

    // (s7, s8, s9, s10) = (1, 2, 4, 8)
    // (s13, s14, s15, s16) = omega4 (1, 2, 4, 8)
    vmov.w r10, r11, s9, s10

#ifdef LOOP
    add.w r12, r0, #360*width
    vmov.w s2, r12
    _3x2_11:
#else
.rept 10
#endif

.rept 4

    ldm.w r0, {r4-r6}
    ldr.w r7, [r0, #(360+0)*width]
    ldr.w r8, [r0, #(360+1)*width]
    ldr.w r9, [r0, #(360+2)*width]

    _3_ntt r4, r5, r6, s7, s8, r10, r11, r1, r2, r3, r12, r14

    vmov.w r1, s4
    montgomery_mul_32 r7, r1, r2, r3, r12, r14

    _3_ntt_f r7, r8, r9, s13, s14, s15, s16, r1, r2, r3, r12, r14

    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9

    str.w r5, [r0, #1*width]
    str.w r6, [r0, #2*width]
    str.w r7, [r0, #(360+0)*width]
    str.w r8, [r0, #(360+1)*width]
    str.w r9, [r0, #(360+2)*width]
    str.w r4, [r0], #9*width

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3x2_11
#else
.endr
#endif

    sub.w r0, r0, #360*width
    add.w r0, r0, #3*width

// ================

    vmov.w r10, r11, s11, s12

#ifdef LOOP
    add.w r12, r0, #360*width
    vmov.w s2, r12
    _3x2_12:
#else
.rept 10
#endif

.rept 4

    ldm.w r0, {r4-r6}
    ldr.w r7, [r0, #(360+0)*width]
    ldr.w r8, [r0, #(360+1)*width]
    ldr.w r9, [r0, #(360+2)*width]

    _3_ntt r4, r5, r6, s8, s9, r10, r11, r1, r2, r3, r12, r14

    vmov.w r1, s4
    montgomery_mul_32 r7, r1, r2, r3, r12, r14

    _3_ntt_f r7, r8, r9, s14, s15, s17, s18, r1, r2, r3, r12, r14

    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9

    str.w r5, [r0, #1*width]
    str.w r6, [r0, #2*width]
    str.w r7, [r0, #(360+0)*width]
    str.w r8, [r0, #(360+1)*width]
    str.w r9, [r0, #(360+2)*width]
    str.w r4, [r0], #9*width

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3x2_12
#else
.endr
#endif

// ================


    vpop.w {s16-s20}
    pop.w {r4-r12, pc}

.align 2
.global __asm_ntt_32
.type __asm_ntt_32, %function
__asm_ntt_32:
    push.w {r4-r12, lr}

    .equ width, 4

    add.w r1, r1, #3*width
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #(4*8*45)*width
    vmov.w s2, r12
    _2_3_4:
#else
.rept 4
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #45*width
    vmov.w s3, r14
    _2_3_4_inner:
#else
.rept 15
#endif

.rept 3

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(0*45)*width, #(1*45)*width, #(2*45)*width, #(3*45)*width, #(4*45)*width, #(5*45)*width, #(6*45)*width, #(7*45)*width

    _3_layer_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14

    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*45)*width, #(2*45)*width, #(3*45)*width, #(4*45)*width, #(5*45)*width, #(6*45)*width, #(7*45)*width, #width

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _2_3_4_inner
#else
.endr
#endif

    add.w r0, r0, #(7*45)*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _2_3_4
#else
.endr
#endif

    pop.w {r4-r12, pc}









