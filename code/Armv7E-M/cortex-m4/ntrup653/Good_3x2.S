
   

#include "macros.i"
#include "special_butterflies.i"

.syntax unified
.cpu cortex-m4

.macro _str_jump jump
    str.w r6, [r0, #3*width]
    str.w r8, [r0, #6*width]
    str.w r5, [r0, #720*width]
    str.w r7, [r0, #723*width]
    str.w r9, [r0, #726*width]
    str.w r4, [r0], #\jump*width
.endm


.align 2
.global __asm_Good_3x2
.type __asm_Good_3x2, %function
__asm_Good_3x2:
    push.w {r4-r12, lr}

    ldr.w r14, [sp, #40]

    .equ ldrwidth, 2
    .equ width, 4
    .equ base, 5

    ldm.w r1, {r9-r11}

    add.w r12, r0, #720*width

    _Good_loop0:

//    0,  640, 1280,  480, 1120,  320,  960,  160,  800
//  720, 1360,  560, 1200,  400, 1040,  240,  880,   80

// ================

    ldrsh.w r4, [r14, #0*ldrwidth]
    ldrsh.w r6, [r14, #480*ldrwidth]
    ldrsh.w r9, [r14, #240*ldrwidth]
    _6_ntt_110 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  801,    1,  641, 1281,  481, 1121,  321,  961,  161
//   81,  721, 1361,  561, 1201,  401, 1041,  241,  881

// ================

    ldrsh.w r5, [r14, #81*ldrwidth]
    ldrsh.w r7, [r14, #561*ldrwidth]
    ldrsh.w r8, [r14, #321*ldrwidth]
    _6_ntt_001 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  162,  802,    2,  642, 1282,  482, 1122,  322,  962
//  882,   82,  722, 1362,  562, 1202,  402, 1042,  242

// ================

    ldrsh.w r4, [r14, #162*ldrwidth]
    ldrsh.w r6, [r14, #642*ldrwidth]
    ldrsh.w r9, [r14, #402*ldrwidth]
    _6_ntt_110 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  963,  163,  803,    3,  643, 1283,  483, 1123,  323
//  243,  883,   83,  723, 1363,  563, 1203,  403, 1043

// ================

    ldrsh.w r5, [r14, #243*ldrwidth]
    ldrsh.w r6, [r14, #3*ldrwidth]
    ldrsh.w r8, [r14, #483*ldrwidth]
    _6_ntt_011 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  324,  964,  164,  804,    4,  644, 1284,  484, 1124
// 1044,  244,  884,   84,  724, 1364,  564, 1204,  404

// ================

    ldrsh.w r4, [r14, #324*ldrwidth]
    ldrsh.w r7, [r14, #84*ldrwidth]
    ldrsh.w r9, [r14, #564*ldrwidth]
    _6_ntt_100 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

// 1125,  325,  965,  165,  805,    5,  645, 1285,  485
//  405, 1045,  245,  885,   85,  725, 1365,  565, 1205

// ================

    ldrsh.w r5, [r14, #405*ldrwidth]
    ldrsh.w r6, [r14, #165*ldrwidth]
    ldrsh.w r8, [r14, #645*ldrwidth]
    _6_ntt_011 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  486, 1126,  326,  966,  166,  806,    6,  646, 1286
// 1206,  406, 1046,  246,  886,   86,  726, 1366,  566

// ================

    ldrsh.w r4, [r14, #486*ldrwidth]
    ldrsh.w r7, [r14, #246*ldrwidth]
    ldrsh.w r8, [r14, #6*ldrwidth]
    _6_ntt_101 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

// 1287,  487, 1127,  327,  967,  167,  807,    7,  647
//  567, 1207,  407, 1047,  247,  887,   87,  727, 1367

// ================

    ldrsh.w r5, [r14, #567*ldrwidth]
    ldrsh.w r6, [r14, #327*ldrwidth]
    ldrsh.w r9, [r14, #87*ldrwidth]
    _6_ntt_010 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  648, 1288,  488, 1128,  328,  968,  168,  808,    8
// 1368,  568, 1208,  408, 1048,  248,  888,   88,  728

    cmp.w r0, r12
    beq.w _Good_loop0_end

// ================

    ldrsh.w r4, [r14, #648*ldrwidth]
    ldrsh.w r7, [r14, #408*ldrwidth]
    ldrsh.w r8, [r14, #168*ldrwidth]
    _6_ntt_101 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

    add.w r14, r14, #9*ldrwidth

    b.w _Good_loop0

    _Good_loop0_end:

    sub.w r14, r14, #72*ldrwidth
    sub.w r0, r0, #720*width
    add.w r0, r0, #width

    add.w r12, r0, #720*width

    _Good_loop1:

//    0,  640, 1280,  480, 1120,  320,  960,  160,  800
//  720, 1360,  560, 1200,  400, 1040,  240,  880,   80

// ================

    ldrsh.w r4, [r14, #640*ldrwidth]
    ldrsh.w r7, [r14, #400*ldrwidth]
    ldrsh.w r8, [r14, #160*ldrwidth]
    _6_ntt_101 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  801,    1,  641, 1281,  481, 1121,  321,  961,  161
//   81,  721, 1361,  561, 1201,  401, 1041,  241,  881

// ================

    ldrsh.w r4, [r14, #1*ldrwidth]
    ldrsh.w r6, [r14, #481*ldrwidth]
    ldrsh.w r9, [r14, #241*ldrwidth]
    _6_ntt_110 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  162,  802,    2,  642, 1282,  482, 1122,  322,  962
//  882,   82,  722, 1362,  562, 1202,  402, 1042,  242

// ================

    ldrsh.w r5, [r14, #82*ldrwidth]
    ldrsh.w r7, [r14, #562*ldrwidth]
    ldrsh.w r8, [r14, #322*ldrwidth]
    _6_ntt_001 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  963,  163,  803,    3,  643, 1283,  483, 1123,  323
//  243,  883,   83,  723, 1363,  563, 1203,  403, 1043

// ================

    ldrsh.w r4, [r14, #163*ldrwidth]
    ldrsh.w r6, [r14, #643*ldrwidth]
    ldrsh.w r9, [r14, #403*ldrwidth]
    _6_ntt_110 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  324,  964,  164,  804,    4,  644, 1284,  484, 1124
// 1044,  244,  884,   84,  724, 1364,  564, 1204,  404

// ================

    ldrsh.w r5, [r14, #244*ldrwidth]
    ldrsh.w r6, [r14, #4*ldrwidth]
    ldrsh.w r8, [r14, #484*ldrwidth]
    _6_ntt_011 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

// 1125,  325,  965,  165,  805,    5,  645, 1285,  485
//  405, 1045,  245,  885,   85,  725, 1365,  565, 1205

// ================

    ldrsh.w r4, [r14, #325*ldrwidth]
    ldrsh.w r7, [r14, #85*ldrwidth]
    ldrsh.w r9, [r14, #565*ldrwidth]
    _6_ntt_100 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  486, 1126,  326,  966,  166,  806,    6,  646, 1286
// 1206,  406, 1046,  246,  886,   86,  726, 1366,  566

// ================

    ldrsh.w r5, [r14, #406*ldrwidth]
    ldrsh.w r6, [r14, #166*ldrwidth]
    ldrsh.w r8, [r14, #646*ldrwidth]
    _6_ntt_011 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

// 1287,  487, 1127,  327,  967,  167,  807,    7,  647
//  567, 1207,  407, 1047,  247,  887,   87,  727, 1367

// ================

    ldrsh.w r4, [r14, #487*ldrwidth]
    ldrsh.w r7, [r14, #247*ldrwidth]
    ldrsh.w r8, [r14, #7*ldrwidth]
    _6_ntt_101 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  648, 1288,  488, 1128,  328,  968,  168,  808,    8
// 1368,  568, 1208,  408, 1048,  248,  888,   88,  728

    cmp.w r0, r12
    beq.w _Good_loop1_end

// ================

    ldrsh.w r5, [r14, #568*ldrwidth]
    ldrsh.w r6, [r14, #328*ldrwidth]
    ldrsh.w r9, [r14, #88*ldrwidth]
    _6_ntt_010 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

    add.w r14, r14, #9*ldrwidth

    b.w _Good_loop1

    _Good_loop1_end:

    sub.w r14, r14, #72*ldrwidth
    sub.w r0, r0, #720*width
    add.w r0, r0, #width

    add.w r12, r0, #720*width

    _Good_loop2:

//    0,  640, 1280,  480, 1120,  320,  960,  160,  800
//  720, 1360,  560, 1200,  400, 1040,  240,  880,   80

// ================

    ldrsh.w r5, [r14, #560*ldrwidth]
    ldrsh.w r6, [r14, #320*ldrwidth]
    ldrsh.w r9, [r14, #80*ldrwidth]
    _6_ntt_010 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  801,    1,  641, 1281,  481, 1121,  321,  961,  161
//   81,  721, 1361,  561, 1201,  401, 1041,  241,  881

// ================

    ldrsh.w r4, [r14, #641*ldrwidth]
    ldrsh.w r7, [r14, #401*ldrwidth]
    ldrsh.w r8, [r14, #161*ldrwidth]
    _6_ntt_101 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  162,  802,    2,  642, 1282,  482, 1122,  322,  962
//  882,   82,  722, 1362,  562, 1202,  402, 1042,  242

// ================

    ldrsh.w r4, [r14, #2*ldrwidth]
    ldrsh.w r6, [r14, #482*ldrwidth]
    ldrsh.w r9, [r14, #242*ldrwidth]
    _6_ntt_110 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  963,  163,  803,    3,  643, 1283,  483, 1123,  323
//  243,  883,   83,  723, 1363,  563, 1203,  403, 1043

// ================

    ldrsh.w r5, [r14, #83*ldrwidth]
    ldrsh.w r7, [r14, #563*ldrwidth]
    ldrsh.w r8, [r14, #323*ldrwidth]
    _6_ntt_001 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  324,  964,  164,  804,    4,  644, 1284,  484, 1124
// 1044,  244,  884,   84,  724, 1364,  564, 1204,  404

// ================

    ldrsh.w r4, [r14, #164*ldrwidth]
    ldrsh.w r6, [r14, #644*ldrwidth]
    ldrsh.w r9, [r14, #404*ldrwidth]
    _6_ntt_110 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

// 1125,  325,  965,  165,  805,    5,  645, 1285,  485
//  405, 1045,  245,  885,   85,  725, 1365,  565, 1205

// ================

    ldrsh.w r5, [r14, #245*ldrwidth]
    ldrsh.w r6, [r14, #5*ldrwidth]
    ldrsh.w r8, [r14, #485*ldrwidth]
    _6_ntt_011 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  486, 1126,  326,  966,  166,  806,    6,  646, 1286
// 1206,  406, 1046,  246,  886,   86,  726, 1366,  566

// ================

    ldrsh.w r4, [r14, #326*ldrwidth]
    ldrsh.w r7, [r14, #86*ldrwidth]
    ldrsh.w r9, [r14, #566*ldrwidth]
    _6_ntt_100 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

// 1287,  487, 1127,  327,  967,  167,  807,    7,  647
//  567, 1207,  407, 1047,  247,  887,   87,  727, 1367

// ================

    ldrsh.w r5, [r14, #407*ldrwidth]
    ldrsh.w r6, [r14, #167*ldrwidth]
    ldrsh.w r8, [r14, #647*ldrwidth]
    _6_ntt_011 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  648, 1288,  488, 1128,  328,  968,  168,  808,    8
// 1368,  568, 1208,  408, 1048,  248,  888,   88,  728

    cmp.w r0, r12
    beq.w _Good_loop2_end

// ================

    ldrsh.w r4, [r14, #488*ldrwidth]
    ldrsh.w r7, [r14, #248*ldrwidth]
    ldrsh.w r8, [r14, #8*ldrwidth]
    _6_ntt_101 r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

    add.w r14, r14, #9*ldrwidth

    b.w _Good_loop2

    _Good_loop2_end:


    pop.w {r4-r12, pc}

.align 2
.global __asm_Good_3x2_small
.type __asm_Good_3x2_small, %function
__asm_Good_3x2_small:
    push.w {r4-r12, lr}

    ldr.w r14, [sp, #40]

    .equ ldrwidth, 1
    .equ width, 4
    .equ base, 5

    ldm.w r1, {r9-r11}

    add.w r12, r0, #720*width

    _Good_loop0_small:

//    0,  640, 1280,  480, 1120,  320,  960,  160,  800
//  720, 1360,  560, 1200,  400, 1040,  240,  880,   80

// ================

    ldrsb.w r4, [r14, #0*ldrwidth]
    ldrsb.w r6, [r14, #480*ldrwidth]
    ldrsb.w r9, [r14, #240*ldrwidth]
    _6_ntt_110_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  801,    1,  641, 1281,  481, 1121,  321,  961,  161
//   81,  721, 1361,  561, 1201,  401, 1041,  241,  881

// ================

    ldrsb.w r5, [r14, #81*ldrwidth]
    ldrsb.w r7, [r14, #561*ldrwidth]
    ldrsb.w r8, [r14, #321*ldrwidth]
    _6_ntt_001_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  162,  802,    2,  642, 1282,  482, 1122,  322,  962
//  882,   82,  722, 1362,  562, 1202,  402, 1042,  242

// ================

    ldrsb.w r4, [r14, #162*ldrwidth]
    ldrsb.w r6, [r14, #642*ldrwidth]
    ldrsb.w r9, [r14, #402*ldrwidth]
    _6_ntt_110_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  963,  163,  803,    3,  643, 1283,  483, 1123,  323
//  243,  883,   83,  723, 1363,  563, 1203,  403, 1043

// ================

    ldrsb.w r5, [r14, #243*ldrwidth]
    ldrsb.w r6, [r14, #3*ldrwidth]
    ldrsb.w r8, [r14, #483*ldrwidth]
    _6_ntt_011_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  324,  964,  164,  804,    4,  644, 1284,  484, 1124
// 1044,  244,  884,   84,  724, 1364,  564, 1204,  404

// ================

    ldrsb.w r4, [r14, #324*ldrwidth]
    ldrsb.w r7, [r14, #84*ldrwidth]
    ldrsb.w r9, [r14, #564*ldrwidth]
    _6_ntt_100_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

// 1125,  325,  965,  165,  805,    5,  645, 1285,  485
//  405, 1045,  245,  885,   85,  725, 1365,  565, 1205

// ================

    ldrsb.w r5, [r14, #405*ldrwidth]
    ldrsb.w r6, [r14, #165*ldrwidth]
    ldrsb.w r8, [r14, #645*ldrwidth]
    _6_ntt_011_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  486, 1126,  326,  966,  166,  806,    6,  646, 1286
// 1206,  406, 1046,  246,  886,   86,  726, 1366,  566

// ================

    ldrsb.w r4, [r14, #486*ldrwidth]
    ldrsb.w r7, [r14, #246*ldrwidth]
    ldrsb.w r8, [r14, #6*ldrwidth]
    _6_ntt_101_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

// 1287,  487, 1127,  327,  967,  167,  807,    7,  647
//  567, 1207,  407, 1047,  247,  887,   87,  727, 1367

// ================

    ldrsb.w r5, [r14, #567*ldrwidth]
    ldrsb.w r6, [r14, #327*ldrwidth]
    ldrsb.w r9, [r14, #87*ldrwidth]
    _6_ntt_010_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  648, 1288,  488, 1128,  328,  968,  168,  808,    8
// 1368,  568, 1208,  408, 1048,  248,  888,   88,  728

    cmp.w r0, r12
    beq.w _Good_loop0_small_end

// ================

    ldrsb.w r4, [r14, #648*ldrwidth]
    ldrsb.w r7, [r14, #408*ldrwidth]
    ldrsb.w r8, [r14, #168*ldrwidth]
    _6_ntt_101_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

    add.w r14, r14, #9*ldrwidth

    b.w _Good_loop0_small

    _Good_loop0_small_end:

    sub.w r14, r14, #72*ldrwidth
    sub.w r0, r0, #720*width
    add.w r0, r0, #width

    add.w r12, r0, #720*width

    _Good_loop1_small:

//    0,  640, 1280,  480, 1120,  320,  960,  160,  800
//  720, 1360,  560, 1200,  400, 1040,  240,  880,   80

// ================

    ldrsb.w r4, [r14, #640*ldrwidth]
    ldrsb.w r7, [r14, #400*ldrwidth]
    ldrsb.w r8, [r14, #160*ldrwidth]
    _6_ntt_101_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  801,    1,  641, 1281,  481, 1121,  321,  961,  161
//   81,  721, 1361,  561, 1201,  401, 1041,  241,  881

// ================

    ldrsb.w r4, [r14, #1*ldrwidth]
    ldrsb.w r6, [r14, #481*ldrwidth]
    ldrsb.w r9, [r14, #241*ldrwidth]
    _6_ntt_110_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  162,  802,    2,  642, 1282,  482, 1122,  322,  962
//  882,   82,  722, 1362,  562, 1202,  402, 1042,  242

// ================

    ldrsb.w r5, [r14, #82*ldrwidth]
    ldrsb.w r7, [r14, #562*ldrwidth]
    ldrsb.w r8, [r14, #322*ldrwidth]
    _6_ntt_001_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  963,  163,  803,    3,  643, 1283,  483, 1123,  323
//  243,  883,   83,  723, 1363,  563, 1203,  403, 1043

// ================

    ldrsb.w r4, [r14, #163*ldrwidth]
    ldrsb.w r6, [r14, #643*ldrwidth]
    ldrsb.w r9, [r14, #403*ldrwidth]
    _6_ntt_110_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  324,  964,  164,  804,    4,  644, 1284,  484, 1124
// 1044,  244,  884,   84,  724, 1364,  564, 1204,  404

// ================

    ldrsb.w r5, [r14, #244*ldrwidth]
    ldrsb.w r6, [r14, #4*ldrwidth]
    ldrsb.w r8, [r14, #484*ldrwidth]
    _6_ntt_011_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

// 1125,  325,  965,  165,  805,    5,  645, 1285,  485
//  405, 1045,  245,  885,   85,  725, 1365,  565, 1205

// ================

    ldrsb.w r4, [r14, #325*ldrwidth]
    ldrsb.w r7, [r14, #85*ldrwidth]
    ldrsb.w r9, [r14, #565*ldrwidth]
    _6_ntt_100_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  486, 1126,  326,  966,  166,  806,    6,  646, 1286
// 1206,  406, 1046,  246,  886,   86,  726, 1366,  566

// ================

    ldrsb.w r5, [r14, #406*ldrwidth]
    ldrsb.w r6, [r14, #166*ldrwidth]
    ldrsb.w r8, [r14, #646*ldrwidth]
    _6_ntt_011_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

// 1287,  487, 1127,  327,  967,  167,  807,    7,  647
//  567, 1207,  407, 1047,  247,  887,   87,  727, 1367

// ================

    ldrsb.w r4, [r14, #487*ldrwidth]
    ldrsb.w r7, [r14, #247*ldrwidth]
    ldrsb.w r8, [r14, #7*ldrwidth]
    _6_ntt_101_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  648, 1288,  488, 1128,  328,  968,  168,  808,    8
// 1368,  568, 1208,  408, 1048,  248,  888,   88,  728

    cmp.w r0, r12
    beq.w _Good_loop1_small_end

// ================

    ldrsb.w r5, [r14, #568*ldrwidth]
    ldrsb.w r6, [r14, #328*ldrwidth]
    ldrsb.w r9, [r14, #88*ldrwidth]
    _6_ntt_010_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

    add.w r14, r14, #9*ldrwidth

    b.w _Good_loop1_small

    _Good_loop1_small_end:

    sub.w r14, r14, #72*ldrwidth
    sub.w r0, r0, #720*width
    add.w r0, r0, #width

    add.w r12, r0, #720*width

    _Good_loop2_small:

//    0,  640, 1280,  480, 1120,  320,  960,  160,  800
//  720, 1360,  560, 1200,  400, 1040,  240,  880,   80

// ================

    ldrsb.w r5, [r14, #560*ldrwidth]
    ldrsb.w r6, [r14, #320*ldrwidth]
    ldrsb.w r9, [r14, #80*ldrwidth]
    _6_ntt_010_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  801,    1,  641, 1281,  481, 1121,  321,  961,  161
//   81,  721, 1361,  561, 1201,  401, 1041,  241,  881

// ================

    ldrsb.w r4, [r14, #641*ldrwidth]
    ldrsb.w r7, [r14, #401*ldrwidth]
    ldrsb.w r8, [r14, #161*ldrwidth]
    _6_ntt_101_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  162,  802,    2,  642, 1282,  482, 1122,  322,  962
//  882,   82,  722, 1362,  562, 1202,  402, 1042,  242

// ================

    ldrsb.w r4, [r14, #2*ldrwidth]
    ldrsb.w r6, [r14, #482*ldrwidth]
    ldrsb.w r9, [r14, #242*ldrwidth]
    _6_ntt_110_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  963,  163,  803,    3,  643, 1283,  483, 1123,  323
//  243,  883,   83,  723, 1363,  563, 1203,  403, 1043

// ================

    ldrsb.w r5, [r14, #83*ldrwidth]
    ldrsb.w r7, [r14, #563*ldrwidth]
    ldrsb.w r8, [r14, #323*ldrwidth]
    _6_ntt_001_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  324,  964,  164,  804,    4,  644, 1284,  484, 1124
// 1044,  244,  884,   84,  724, 1364,  564, 1204,  404

// ================

    ldrsb.w r4, [r14, #164*ldrwidth]
    ldrsb.w r6, [r14, #644*ldrwidth]
    ldrsb.w r9, [r14, #404*ldrwidth]
    _6_ntt_110_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

// 1125,  325,  965,  165,  805,    5,  645, 1285,  485
//  405, 1045,  245,  885,   85,  725, 1365,  565, 1205

// ================

    ldrsb.w r5, [r14, #245*ldrwidth]
    ldrsb.w r6, [r14, #5*ldrwidth]
    ldrsb.w r8, [r14, #485*ldrwidth]
    _6_ntt_011_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  486, 1126,  326,  966,  166,  806,    6,  646, 1286
// 1206,  406, 1046,  246,  886,   86,  726, 1366,  566

// ================

    ldrsb.w r4, [r14, #326*ldrwidth]
    ldrsb.w r7, [r14, #86*ldrwidth]
    ldrsb.w r9, [r14, #566*ldrwidth]
    _6_ntt_100_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

// 1287,  487, 1127,  327,  967,  167,  807,    7,  647
//  567, 1207,  407, 1047,  247,  887,   87,  727, 1367

// ================

    ldrsb.w r5, [r14, #407*ldrwidth]
    ldrsb.w r6, [r14, #167*ldrwidth]
    ldrsb.w r8, [r14, #647*ldrwidth]
    _6_ntt_011_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

//  648, 1288,  488, 1128,  328,  968,  168,  808,    8
// 1368,  568, 1208,  408, 1048,  248,  888,   88,  728

    cmp.w r0, r12
    beq.w _Good_loop2_small_end

// ================

    ldrsb.w r4, [r14, #488*ldrwidth]
    ldrsb.w r7, [r14, #248*ldrwidth]
    ldrsb.w r8, [r14, #8*ldrwidth]
    _6_ntt_101_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    _str_jump 9

    add.w r14, r14, #9*ldrwidth

    b.w _Good_loop2_small

    _Good_loop2_small_end:


    pop.w {r4-r12, pc}







