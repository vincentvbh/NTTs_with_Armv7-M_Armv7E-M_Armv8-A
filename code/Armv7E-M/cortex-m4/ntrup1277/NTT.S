
#include "macros.i"
#include "butterflies.i"

#include "NTT_params.h"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_ntt
.type __asm_ntt, %function
__asm_ntt:
    push {r4-r12, lr}

    // RmodQ1
    movw r4, :lower16:RmodQ1
    movt r4, :upper16:RmodQ1
    vmov.w s11, r4

    .equ unit, 5

    add.w r1, r1, #28
    vldm r1!, {s4-s10}
    vmov.w s1, r1

// ================================

#ifdef LOOP
    add.w r12, r0, #32*unit
    vmov.w s2, r12
    _3_4_5_light:
#else
.rept 8
#endif

.rept unit

    ldrstr4 ldr.w, r0, r5, r7, r8, r10, #32*unit, #96*unit, #160*unit, #224*unit
    _3_layer_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r6, r8, r10, #0*unit, #64*unit, #128*unit, #192*unit
    _3_layer_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #32*unit, #64*unit, #96*unit, #128*unit, #160*unit, #192*unit, #224*unit, #4

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3_4_5_light
#else
.endr
#endif

    add.w r0, r0, #224*unit

// ================================

#ifdef LOOP
    add.w r12, r0, #256*7*unit
    vmov.w s2, r12
    _3_4_5:
#else
.rept 7
#endif

    vmov.w r1, s1
    vldm r1!, {s4-s10}
    vmov.w s1, r1

// ================================

#ifdef LOOP
    add.w r14, r0, #32*unit
    vmov.w s3, r14
    _3_4_5_inner:
#else
.rept 4*unit
#endif

.rept 2
    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*unit, #32*unit, #64*unit, #96*unit, #128*unit, #160*unit, #192*unit, #224*unit
    _3_layer_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #32*unit, #64*unit, #96*unit, #128*unit, #160*unit, #192*unit, #224*unit, #4
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _3_4_5_inner
#else
.endr
#endif

    add.w r0, r0, #224*unit

// ================================

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3_4_5
#else
.endr
#endif

// ================================

    sub.w r0, r0, #2048*unit

    vmov.w r1, s1
    vldm r1!, {s4-s10}
    vmov.w s1, r1

// ================================

.rept unit
    ldrstr4 ldr.w, r0, r5, r7, r8, r10, #4*unit, #12*unit, #20*unit, #28*unit
    _3_layer_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r6, r8, r10, #0*unit, #8*unit, #16*unit, #24*unit
    _3_layer_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #4*unit, #8*unit, #12*unit, #16*unit, #20*unit, #24*unit, #28*unit, #4
.endr

    add.w r0, r0, #28*unit

// ================================

#ifdef LOOP
    add.w r12, r0, #10240
    sub.w r12, r12, #160
    vmov.w s2, r12
    _6_7_8:
#else
.rept 63
#endif

    vmov.w r1, s1
    vldm r1!, {s4-s10}
    vmov.w s1, r1

// ================================

#ifdef LOOP
    add.w r14, r0, #16
    vmov.w s3, r14
    _6_7_8_inner:
#else
.rept 2
#endif

.rept 2

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*unit, #4*unit, #8*unit, #12*unit, #16*unit, #20*unit, #24*unit, #28*unit
    _3_layer_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #4*unit, #8*unit, #12*unit, #16*unit, #20*unit, #24*unit, #28*unit, #4

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _6_7_8_inner
#else
.endr
#endif

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*unit, #4*unit, #8*unit, #12*unit, #16*unit, #20*unit, #24*unit, #28*unit
    _3_layer_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #4*unit, #8*unit, #12*unit, #16*unit, #20*unit, #24*unit, #28*unit, #4

    add.w r0, r0, #28*unit

// ================================

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _6_7_8
#else
.endr
#endif

// ================================


    pop {r4-r12, pc}








