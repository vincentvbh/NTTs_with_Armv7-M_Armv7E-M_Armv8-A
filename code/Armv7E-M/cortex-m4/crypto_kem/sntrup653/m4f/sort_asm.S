
.syntax unified
.cpu cortex-m4

.macro minmax a0, a1

    cmp \a0, \a1 // a0 = c0, a1 = c1
    ittt gt
    eorgt \a0, \a0, \a1 // a0 = c0 ^ c1
    eorgt \a1, \a1, \a0 // a1 = c0
    eorgt \a0, \a0, \a1 // a0 = c1

.endm

.align 2
.global __asm_minmax
.type __asm_minmax, %function
__asm_minmax:
    push.w {r4-r6}

    .equ width, 4

    mov.w r4, r0
    mov.w r5, r1

    add.w r6, r4, r2, lsl #2
    minmax_loop2:

    ldr r0, [r4, #0*width]
    ldr r1, [r4, #1*width]
    ldr r2, [r5, #0*width]
    ldr r3, [r5, #1*width]

    minmax r0, r2
    minmax r1, r3

    str r1, [r4, #1*width]
    str r3, [r5, #1*width]
    str r0, [r4], #2*width
    str r2, [r5], #2*width

    cmp r4, r6
    bne minmax_loop2

    pop.w {r4-r6}

    bx lr

.align 2
.global __asm_minmax_quadjump
.type __asm_minmax_quadjump, %function
__asm_minmax_quadjump:


    push.w {r4-r8}

    .equ width, 4

    add.w r6, r0, r2, lsl #2
    add.w r7, r0, r1, lsl #2
    mov.w r8, r2

    ldr r0, [r7, #0*width]
    ldr r1, [r7, #1*width]
    ldr r2, [r7, #2*width]
    ldr r3, [r7, #3*width]

    quadjump_loop:

    cmp r6, r7
    it le
    ble.w quadjump_end

    ldr r4, [r6, #0*width]
    ldr r5, [r6, #1*width]

    minmax r0, r4
    minmax r1, r5

    str r4, [r6, #0*width]
    str r5, [r6, #1*width]

    ldr r4, [r6, #2*width]
    ldr r5, [r6, #3*width]

    minmax r2, r4
    minmax r3, r5

    str r4, [r6, #2*width]
    str r5, [r6, #3*width]

    lsr.w r8, r8, #1
    sub.w r6, r6, r8, lsl #2
    b.w quadjump_loop

    quadjump_end:

    str r0, [r7, #0*width]
    str r1, [r7, #1*width]
    str r2, [r7, #2*width]
    str r3, [r7, #3*width]

    pop.w {r4-r8}

    bx lr


















