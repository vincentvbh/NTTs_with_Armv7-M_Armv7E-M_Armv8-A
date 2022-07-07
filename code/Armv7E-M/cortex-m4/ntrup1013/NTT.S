
#include "macros.i"
#include "butterflies.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_ntt_0_1_2
.type __asm_ntt_0_1_2, %function
__asm_ntt_0_1_2:
    push.w {r4-r12, lr}

    .equ srcwidth, 2
    .equ width, 4
    .equ step, 256

    add.w r4, r0, #1024*width
    vmov.w s0, s1, r0, r4
    ldr.w r0, [sp, #40]

    vldm.w r1, {s4-s10}

#ifdef LOOP
    add.w r12, r0, #256*srcwidth
    vmov.w s2, r12
    _0_1_2_32:
#else
.rept 64
#endif

.rept 4

    ldrstr4jump ldrsh.w, r0, r4, r5, r6, r7, #(step*1)*srcwidth, #(step*2)*srcwidth, #(step*3)*srcwidth, #srcwidth
    _3_layer_CT_light_1111_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, r14, s0, s1
    ldrstr4jump str.w, r1, r4, r5, r6, r7, #(step*1)*width, #(step*2)*width, #(step*3)*width, #width
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #(step*1)*width, #(step*2)*width, #(step*3)*width, #width
    vmov.w s0, s1, r1, r14

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _0_1_2_32
#else
.endr
#endif

    pop.w {r4-r12, pc}

.align 2
.global __asm_ntt_0_1_2_small
.type __asm_ntt_0_1_2_small, %function
__asm_ntt_0_1_2_small:
    push.w {r4-r12, lr}

    .equ srcwidth, 1
    .equ width, 4
    .equ step, 256

    add.w r4, r0, #1024*width
    vmov.w s0, s1, r0, r4
    ldr.w r0, [sp, #40]

    vldm.w r1, {s4-s10}

#ifdef LOOP
    add.w r12, r0, #256*srcwidth
    vmov.w s2, r12
    _0_1_2_small_32:
#else
.rept 64
#endif

.rept 4

    ldrstr4jump ldrsb.w, r0, r4, r5, r6, r7, #(step*1)*srcwidth, #(step*2)*srcwidth, #(step*3)*srcwidth, #srcwidth
    _3_layer_CT_light_small_1111_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, r14, s0, s1
    ldrstr4jump str.w, r1, r4, r5, r6, r7, #(step*1)*width, #(step*2)*width, #(step*3)*width, #width
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #(step*1)*width, #(step*2)*width, #(step*3)*width, #width
    vmov.w s0, s1, r1, r14

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _0_1_2_small_32
#else
.endr
#endif

    pop.w {r4-r12, pc}

.align 2
.global __asm_ntt_3_4_5_6_7_8
.type __asm_ntt_3_4_5_6_7_8, %function
__asm_ntt_3_4_5_6_7_8:
    push.w {r4-r12, lr}

    .equ width, 4

// layers 3, 4, 5 start

    .equ step, 32

    add.w r1, r1, #28
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

// handle NTT over (x^32)^8 - 1 separately

#ifdef LOOP
    add.w r12, r0, #32*width
    vmov.w s2, r12
    _3_4_5_light_32:
#else
.rept 8
#endif

.rept 4

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(step*0)*width, #(step*1)*width, #(step*2)*width, #(step*3)*width, #(step*4)*width, #(step*5)*width, #(step*6)*width, #(step*7)*width
    _3_layer_CT_light_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(step*1)*width, #(step*2)*width, #(step*3)*width, #(step*4)*width, #(step*5)*width, #(step*6)*width, #(step*7)*width, #width

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3_4_5_light_32
#else
.endr
#endif

    add.w r0, r0, #224*width

// loop over NTT over (x^32)^8 - omega_8^i
// for i = 4, 2, 6, 1, 5, 3, 7

#ifdef LOOP
    add.w r12, r0, #1792*width
    vmov.w s2, r12
    _3_4_5_32:
#else
.rept 7
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #32*width
    vmov.w s3, r14
    _3_4_5_inner_32:
#else
.rept 16
#endif

.rept 2

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(step*0)*width, #(step*1)*width, #(step*2)*width, #(step*3)*width, #(step*4)*width, #(step*5)*width, #(step*6)*width, #(step*7)*width
    _3_layer_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(step*1)*width, #(step*2)*width, #(step*3)*width, #(step*4)*width, #(step*5)*width, #(step*6)*width, #(step*7)*width, #width

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _3_4_5_inner_32
#else
.endr
#endif

    add.w r0, r0, #224*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3_4_5_32
#else
.endr
#endif

    sub.w r0, r0, #2048*width

// layers 3, 4, 5 end

// layers 6, 7, 8 start

    .equ step, 4

#ifdef LOOP
    add.w r12, r0, #2048*width
    vmov.w s2, r12
    _6_7_8_32:
#else
.rept 64
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #4*width
    vmov.w s3, r14
    _6_7_8_inner_32:
#else
.rept 2
#endif

.rept 2

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(step*0)*width, #(step*1)*width, #(step*2)*width, #(step*3)*width, #(step*4)*width, #(step*5)*width, #(step*6)*width, #(step*7)*width
    _3_layer_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(step*1)*width, #(step*2)*width, #(step*3)*width, #(step*4)*width, #(step*5)*width, #(step*6)*width, #(step*7)*width, #width

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _6_7_8_inner_32
#else
.endr
#endif

    add.w r0, r0, #28*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _6_7_8_32
#else
.endr
#endif

// layers 6, 7, 8 end



    pop {r4-r12, pc}








