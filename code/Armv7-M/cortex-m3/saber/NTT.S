
#include "macros.i"
#include "CT_butterflies.i"

#ifndef LOOP
#define LOOP
#endif

.syntax unified
.cpu cortex-m3

.align 2
.global __asm_negacyclic_ntt
.type __asm_negacyclic_ntt, %function
__asm_negacyclic_ntt:
    push {r4-r12, lr}

    .equ width, 2

    sub.w sp, sp, #16
    str.w r0, [sp, #12]
    ldr.w r0, [sp, #56]
    ldr.w r12, [sp, #60]
    str.w r12, [sp, #8]

#ifdef LOOP
    add.w r12, r0, #32*width
    str.w r12, [sp, #0]
    _0_1_2:
#else
.rept 16
#endif

.set step, 32
.set count, 2
.set indx, count

.rept count
.set indx, indx-1

.if indx == 0
    ldrstr8jump ldrsh.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(step*1*width), #(step*2*width), #(step*3*width), #(step*4*width), #(step*5*width), #(step*6*width), #(step*7*width), #count*width
.else
    ldrstr8 ldrsh.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #((step*0+indx)*width), #((step*1+indx)*width), #((step*2+indx)*width), #((step*3+indx)*width), #((step*4+indx)*width), #((step*5+indx)*width), #((step*6+indx)*width), #((step*7+indx)*width)
.endif

    _3_layer_CT_16 r4, r5, r6, r7, r8, r9, r10, r11, r1, r12, r2, r3, r14

    ldr.w r14, [sp, #12]
.if indx == 0
    ldrstr8jump strh.w, r14, r4, r5, r6, r7, r8, r9, r10, r11, #(step*1*width), #(step*2*width), #(step*3*width), #(step*4*width), #(step*5*width), #(step*6*width), #(step*7*width), #count*width
    str.w r14, [sp, #12]
.else
    ldrstr8 strh.w, r14, r4, r5, r6, r7, r8, r9, r10, r11, #((step*0+indx)*width), #((step*1+indx)*width), #((step*2+indx)*width), #((step*3+indx)*width), #((step*4+indx)*width), #((step*5+indx)*width), #((step*6+indx)*width), #((step*7+indx)*width)
.endif


.endr

#ifdef LOOP
    ldr.w r12, [sp, #0]
    cmp.w r0, r12
    bne.w _0_1_2
#else
.endr
#endif

    add.w r1, r1, #28
    ldr.w r0, [sp, #12]
    sub.w r0, r0, #32*width

#ifdef LOOP
    add.w r12, r0, #256*width
    str.w r12, [sp, #0]
    _3_4_5:
#else
.rept 8
#endif

#ifdef LOOP
    add.w r14, r0, #4*width
    str.w r14, [sp, #4]
    _3_4_5_inner:
#else
.rept 2
#endif

.rept 2

    ldr.w r12, [sp, #8]
    ldrstr8 ldrsh.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*width, #4*width, #8*width, #12*width, #16*width, #20*width, #24*width, #28*width
    barrett r4, r12, r3, r14
    barrett r5, r12, r3, r14
    barrett r6, r12, r3, r14
    barrett r7, r12, r3, r14
    _3_layer_CT_16 r4, r5, r6, r7, r8, r9, r10, r11, r1, r12, r2, r3, r14
    ldrstr8jump strh.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #4*width, #8*width, #12*width, #16*width, #20*width, #24*width, #28*width, #width

.endr

#ifdef LOOP
    ldr.w r14, [sp, #4]
    cmp.w r0, r14
    bne.w _3_4_5_inner
#else
.endr
#endif

    add.w r1, r1, #28
    add.w r0, r0, #28*width

#ifdef LOOP
    ldr.w r12, [sp, #0]
    cmp.w r0, r12
    bne.w _3_4_5
#else
.endr
#endif

    add.w sp, sp, #16
    pop {r4-r12, pc}


















