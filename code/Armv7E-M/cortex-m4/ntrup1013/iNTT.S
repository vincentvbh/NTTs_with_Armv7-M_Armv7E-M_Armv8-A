
#include "macros.i"
#include "butterflies.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_intt
.type __asm_intt, %function
__asm_intt:
    push.w {r4-r12, lr}

    .equ width, 4

// layers 0, 1, 2 start

    .equ step, 4

    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #2048*width
    vmov.w s2, r12
    _i_0_1_2_32:
#else
.rept 64
#endif

.rept 4

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(0*step)*width, #(1*step)*width, #(2*step)*width, (3*step)*width, (4*step)*width, (5*step)*width, (6*step)*width, (7*step)*width
    _3_layer_inv_CT_light_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*step)*width, #(2*step)*width, (3*step)*width, (4*step)*width, (5*step)*width, (6*step)*width, (7*step)*width, #width

.endr

    add.w r0, r0, #28*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_0_1_2_32
#else
.endr
#endif

    sub.w r0, r0, #2048*width

// layers 0, 1, 2 end

// layers 3, 4, 5 start

    .equ step, 32

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #2048*width
    vmov.w s2, r12
    _i_3_4_5_light_32:
#else
.rept 8
#endif

.rept 4

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width
    _3_layer_inv_CT_light_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width

.endr

    add.w r0, r0, #(256-4)*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_3_4_5_light_32
#else
.endr
#endif

    sub.w r0, r0, #2048*width
    add.w r0, r0, #4*width

#ifdef LOOP
    add.w r12, r0, #28*width
    vmov.w s2, r12
    _i_3_4_5_32:
#else
.rept 7
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #2048*width
    vmov.w s3, r14
    _i_3_4_5_inner_32:
#else
.rept 8
#endif

#ifdef LOOP
    add.w r12, r0, #4*width
    vmov.w s12, r12
    _i_3_4_5_most_inner_32:
#else
.rept 2
#endif

.rept 2

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width
    _3_layer_inv_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width

.endr

#ifdef LOOP
    vmov.w r12, s12
    cmp.w r0, r12
    bne.w _i_3_4_5_most_inner_32
#else
.endr
#endif

    add.w r0, r0, #(256-4)*width

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _i_3_4_5_inner_32
#else
.endr
#endif

    sub.w r0, r0, #2048*width
    add.w r0, r0, #4*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_3_4_5_32
#else
.endr
#endif

    sub.w r0, r0, #32*width

// layers 3, 4, 5 end

// layers 6, 7, 8 start

    add.w r14, r0, #1024*width
    vmov.w s13, r14

    .equ step, 256

#ifdef LOOP
    add.w r12, r0, #256*width
    vmov.w s2, r12
    _i_6_7_8_32:
#else
.rept 64
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #4*width
    vmov.w s3, r14
    _i_6_7_8_inner_32:
#else
.rept 2
#endif

.rept 2

    vmov.w r14, s13
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width
    ldrstr4 ldr.w, r14, r8, r9, r10, r11, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width
    _3_layer_inv_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s13
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #(1*step)*width, #(2*step)*width, #(3*step)*width, #width
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #(1*step)*width, #(2*step)*width, #(3*step)*width, #width
    vmov.w s13, r14

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _i_6_7_8_inner_32
#else
.endr
#endif

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_6_7_8_32
#else
.endr
#endif

// layers 6, 7, 8 end

    pop.w {r4-r12, pc}










