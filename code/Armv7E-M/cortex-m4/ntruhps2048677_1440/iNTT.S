
#include "macros.i"
#include "butterflies.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_3x2block_intt
.type __asm_3x2block_intt, %function
__asm_3x2block_intt:
    push.w {r4-r12, lr}
    vpush.w {s16-s18}

    vldm.w r1, {s4-s18}

    .equ step, 45

    vmov.w r10, r11, s5, s6

#ifdef LOOP
    add.w r12, r0, #1440*width
    vmov.w s2, r12
    _i_3x2_0:
#else
.rept 16
#endif

#ifdef LOOP
    add.w r14, r0, #45*width
    vmov.w s3, r14
    _i_3x2_0_inner:
#else
.rept 3
#endif

.rept 5

    ldm.w r0, {r4-r6}
    ldr.w r7, [r0, #(step+0)*width]
    ldr.w r8, [r0, #(step+1)*width]
    ldr.w r9, [r0, #(step+2)*width]

    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9

    _3_ntt_light r4, r5, r6, r10, r11, r2, r3, r12, r14
    _3_ntt_light r7, r8, r9, r10, r11, r2, r3, r12, r14

    str.w r5, [r0, #1*width]
    str.w r6, [r0, #2*width]
    str.w r7, [r0, #(step+0)*width]
    str.w r8, [r0, #(step+1)*width]
    str.w r9, [r0, #(step+2)*width]
    str.w r4, [r0], #3*width

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _i_3x2_0_inner
#else
.endr
#endif

    add.w r0, r0, #step*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_3x2_0
#else
.endr
#endif

    sub.w r0, r0, #1440*width

    .equ step, 90

    vmov.w r10, r11, s5, s6

#ifdef LOOP
    add.w r12, r0, #1440*width
    vmov.w s2, r12
    _i_3x2_11_light:
#else
.rept 8
#endif

#ifdef LOOP
    add.w r14, r0, #45*width
    vmov.w s3, r14
    _i_3x2_11_light_inner:
#else
.rept 5
#endif

// ================

    ldr.w r4, [r0, #0*width]
    ldr.w r5, [r0, #3*width]
    ldr.w r6, [r0, #6*width]
    ldr.w r7, [r0, #(step+0)*width]
    ldr.w r8, [r0, #(step+3)*width]
    ldr.w r9, [r0, #(step+6)*width]

    _3_ntt_light r4, r5, r6, r10, r11, r2, r3, r12, r14
    _3_ntt_light r7, r8, r9, r10, r11, r2, r3, r12, r14

    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9

    str.w r4, [r0, #0*width]
    str.w r5, [r0, #3*width]
    str.w r6, [r0, #6*width]
    str.w r7, [r0, #(step+0)*width]
    str.w r8, [r0, #(step+3)*width]
    str.w r9, [r0, #(step+6)*width]

// ================

    ldr.w r4, [r0, #45*width]
    ldr.w r5, [r0, #48*width]
    ldr.w r6, [r0, #51*width]
    ldr.w r7, [r0, #(step+45)*width]
    ldr.w r8, [r0, #(step+48)*width]
    ldr.w r9, [r0, #(step+51)*width]

    _3_ntt_light r4, r5, r6, r10, r11, r2, r3, r12, r14
    _3_ntt_light r7, r8, r9, r10, r11, r2, r3, r12, r14

    vmov.w r1, s4
    montgomery_mul_32 r7, r1, r2, r3, r12, r14
    montgomery_mul_32 r8, r1, r2, r3, r12, r14
    montgomery_mul_32 r9, r1, r2, r3, r12, r14
    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9

    str.w r4, [r0, #45*width]
    str.w r5, [r0, #48*width]
    str.w r6, [r0, #51*width]
    str.w r7, [r0, #(step+45)*width]
    str.w r8, [r0, #(step+48)*width]
    str.w r9, [r0, #(step+51)*width]

// ================

    add.w r0, r0, #9*width

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _i_3x2_11_light_inner
#else
.endr
#endif

    add.w r0, r0, #3*45*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_3x2_11_light
#else
.endr
#endif

    sub.w r0, r0, #1440*width

#ifdef LOOP
    add.w r12, r0, #1440*width
    vmov.w s2, r12
    _i_3x2_11:
#else
.rept 8
#endif

#ifdef LOOP
    add.w r14, r0, #45*width
    vmov.w s3, r14
    _i_3x2_11_inner:
#else
.rept 5
#endif

// ================

    vmov.w r10, r11, s9, s10

    ldr.w r4, [r0, #1*width]
    ldr.w r5, [r0, #4*width]
    ldr.w r6, [r0, #7*width]
    ldr.w r7, [r0, #(step+1)*width]
    ldr.w r8, [r0, #(step+4)*width]
    ldr.w r9, [r0, #(step+7)*width]

    _3_ntt r4, r5, r6, s7, s8, r10, r11, r1, r2, r3, r12, r14
    _3_ntt r7, r8, r9, s7, s8, r10, r11, r1, r2, r3, r12, r14

    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9

    str.w r4, [r0, #1*width]
    str.w r5, [r0, #4*width]
    str.w r6, [r0, #7*width]
    str.w r7, [r0, #(step+1)*width]
    str.w r8, [r0, #(step+4)*width]
    str.w r9, [r0, #(step+7)*width]

// ================

    ldr.w r4, [r0, #46*width]
    ldr.w r5, [r0, #49*width]
    ldr.w r6, [r0, #52*width]
    ldr.w r7, [r0, #(step+46)*width]
    ldr.w r8, [r0, #(step+49)*width]
    ldr.w r9, [r0, #(step+52)*width]

    vmov.w r1, s4
    montgomery_mul_32 r7, r1, r2, r3, r12, r14
    _3_ntt r4, r5, r6, s7, s8, r10, r11, r1, r2, r3, r12, r14
    _3_ntt_f r7, r8, r9, s13, s14, s15, s16, r1, r2, r3, r12, r14

    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9

    str.w r4, [r0, #46*width]
    str.w r5, [r0, #49*width]
    str.w r6, [r0, #52*width]
    str.w r7, [r0, #(step+46)*width]
    str.w r8, [r0, #(step+49)*width]
    str.w r9, [r0, #(step+52)*width]

// ================

    vmov.w r10, r11, s11, s12

    ldr.w r4, [r0, #2*width]
    ldr.w r5, [r0, #5*width]
    ldr.w r6, [r0, #8*width]
    ldr.w r7, [r0, #(step+2)*width]
    ldr.w r8, [r0, #(step+5)*width]
    ldr.w r9, [r0, #(step+8)*width]

    _3_ntt r4, r5, r6, s8, s9, r10, r11, r1, r2, r3, r12, r14
    _3_ntt r7, r8, r9, s8, s9, r10, r11, r1, r2, r3, r12, r14

    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9

    str.w r4, [r0, #2*width]
    str.w r5, [r0, #5*width]
    str.w r6, [r0, #8*width]
    str.w r7, [r0, #(step+2)*width]
    str.w r8, [r0, #(step+5)*width]
    str.w r9, [r0, #(step+8)*width]

// ================

    ldr.w r4, [r0, #47*width]
    ldr.w r5, [r0, #50*width]
    ldr.w r6, [r0, #53*width]
    ldr.w r7, [r0, #(step+47)*width]
    ldr.w r8, [r0, #(step+50)*width]
    ldr.w r9, [r0, #(step+53)*width]

    vmov.w r1, s4
    montgomery_mul_32 r7, r1, r2, r3, r12, r14
    _3_ntt r4, r5, r6, s8, s9, r10, r11, r1, r2, r3, r12, r14
    _3_ntt_f r7, r8, r9, s14, s15, s17, s18, r1, r2, r3, r12, r14

    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9

    str.w r4, [r0, #47*width]
    str.w r5, [r0, #50*width]
    str.w r6, [r0, #53*width]
    str.w r7, [r0, #(step+47)*width]
    str.w r8, [r0, #(step+50)*width]
    str.w r9, [r0, #(step+53)*width]

// ================

    add.w r0, r0, #9*width

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _i_3x2_11_inner
#else
.endr
#endif

    add.w r0, r0, #3*45*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_3x2_11
#else
.endr
#endif

    vpop.w {s16-s18}
    pop.w {r4-r12, pc}

.align 2
.global __asm_intt_32
.type __asm_intt_32, %function
__asm_intt_32:
    push.w {r4-r12, lr}

    .equ width, 4
    .equ step, 180

    add.w r14, r0, #720*width
    add.w r1, r1, #3*width
    vmov.w s0, r14
    vldm.w r1!, {s4-s10}
    vmov.w s0, s1, r14, r1

#ifdef LOOP
    add.w r12, r0, #45*width
    vmov.w s2, r12
    _i_2_3_4_light:
#else
.rept 15
#endif

.rept 3

    vmov.w r14, s0
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width
    ldrstr4 ldr.w, r14, r8, r9, r10, r11, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width

    _3_layer_inv_CT_light_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14

    vmov.w r14, s0
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #(1*step)*width, #(2*step)*width, #(3*step)*width, #width
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #(1*step)*width, #(2*step)*width, #(3*step)*width, #width
    vmov.w s0, r14

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_2_3_4_light
#else
.endr
#endif

#ifdef LOOP
    add.w r12, r0, #3*45*width
    vmov.w s2, r12
    _i_2_3_4:
#else
.rept 3
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #45*width
    vmov.w s3, r14
    _i_2_3_4_inner:
#else
.rept 15
#endif

.rept 3

    vmov.w r14, s0
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width
    ldrstr4 ldr.w, r14, r8, r9, r10, r11, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width

    _3_layer_inv_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14

    vmov.w r14, s0
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #(1*step)*width, #(2*step)*width, #(3*step)*width, #width
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #(1*step)*width, #(2*step)*width, #(3*step)*width, #width
    vmov.w s0, r14

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _i_2_3_4_inner
#else
.endr
#endif

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_2_3_4
#else
.endr
#endif

    pop.w {r4-r12, pc}





