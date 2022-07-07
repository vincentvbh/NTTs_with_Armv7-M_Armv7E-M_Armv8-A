#ifndef NTT_H
#define NTT_H

#include <stdint.h>

#include "NTT_params.h"

extern void __asm_Good_3x2(int32_t *des, const int32_t*, int32_t, int32_t, const int16_t *src);
extern void __asm_Good_3x2_small(int32_t *des, const int32_t*, int32_t, int32_t, const int16_t *src);
extern void __asm_ntt_32(int32_t *des, const int32_t*, int32_t, int32_t);
extern void __asm_base_mul(int32_t*, const int32_t*, int32_t, int32_t, int32_t*, int32_t*);
extern void __asm_i_3x2(int32_t *des, const int32_t*, int32_t, int32_t);
extern void __asm_intt(int32_t *des, const int32_t*, int32_t, int32_t);
extern void __asm_final_map(uint16_t *des, const int32_t*, int32_t, int32_t, int32_t *src);

static const int32_t streamlined_CT_table_Q1[NTT_N - 1] = {
-1736566, -1736566, -1736566, -4592671, -1736566, -4592671, -1183523, -955740, -4592671, -1183523, -955740, -3265592, -651242, -3342045, 1143822, -1736566, -1736566, -4592671, -1736566, -4592671, -1183523, -955740, -4592671, -1183523, -955740, -3265592, -651242, -3342045, 1143822, -1183523, -3265592, -651242, -4623697, -2618113, 919438, -5104170, -955740, -3342045, 1143822, -2165770, -4934154, -3538719, 1366526, -3265592, -4623697, -2618113, -4216973, 5504217, 4471856, 2924052, -651242, 919438, -5104170, -4388108, 1047781, -3754063, -437273, -3342045, -2165770, -4934154, 889203, 4908578, -5448948, -1386312, 1143822, -3538719, 1366526, 4017397, -3570786, -5650407, 4368942, -4623697, -4216973, 5504217, -2909086, -5617415, 3328439, -5712161, -2618113, 4471856, 2924052, 2372748, 2461475, -1427329, -2647867, 919438, -4388108, 1047781, -461616, -5470564, -4230938, 834761, -5104170, -3754063, -437273, -1023002, 1151154, 173452, 180829, -2165770, 889203, 4908578, 5019724, -1104900, -4748319, 1258227, -4934154, -5448948, -1386312, 2968606, 4109178, 1187957, 5372775, -3538719, 4017397, -3570786, -2294405, -2156126, -3459455, 1291258, 1366526, -5650407, 4368942, -104746, -1181803, 2612317, -2640054
};

static const int32_t mul_Rmod_table_Q1[NTT_N] = {
-1736566, -4592671, -1183523, -955740, -3265592, -651242, -3342045, 1143822, -4623697, -2618113, 919438, -5104170, -2165770, -4934154, -3538719, 1366526, -4216973, 5504217, 4471856, 2924052, -4388108, 1047781, -3754063, -437273, 889203, 4908578, -5448948, -1386312, 4017397, -3570786, -5650407, 4368942, -2909086, -5617415, 3328439, -5712161, 2372748, 2461475, -1427329, -2647867, -461616, -5470564, -4230938, 834761, -1023002, 1151154, 173452, 180829, 5019724, -1104900, -4748319, 1258227, 2968606, 4109178, 1187957, 5372775, -2294405, -2156126, -3459455, 1291258, -104746, -1181803, 2612317, -2640054
};

static const int32_t streamlined_inv_CT_table_Q1[NTT_N - 1] = {
-1736566, -1736566, -1736566, 4592671, -1736566, 955740, 4592671, 1183523, 4592671, 955740, 1183523, -1143822, 651242, 3342045, 3265592, -1736566, -1736566, 4592671, -1736566, 955740, 4592671, 1183523, -1366526, -4368942, 5650407, 2640054, 1181803, -2612317, 104746, -1143822, -1366526, 3538719, -4368942, 3570786, 5650407, -4017397, 5104170, 437273, 3754063, -180829, -1151154, -173452, 1023002, 955740, -1143822, 3342045, -1366526, 4934154, 3538719, 2165770, 4934154, 1386312, 5448948, -5372775, -4109178, -1187957, -2968606, 651242, 5104170, -919438, 437273, -1047781, 3754063, 4388108, 2618113, -2924052, -4471856, 2647867, -2461475, 1427329, -2372748, 4592671, 955740, 1183523, -1143822, 651242, 3342045, 3265592, 3538719, 3570786, -4017397, -1291258, 2156126, 3459455, 2294405, 3342045, 4934154, 2165770, 1386312, -4908578, 5448948, -889203, -919438, -1047781, 4388108, -834761, 5470564, 4230938, 461616, 1183523, 651242, 3265592, 5104170, 2618113, -919438, 4623697, 2165770, -4908578, -889203, -1258227, 1104900, 4748319, -5019724, 3265592, 2618113, 4623697, -2924052, -5504217, -4471856, 4216973, 4623697, -5504217, 4216973, 5712161, 5617415, -3328439, 2909086
};

static const int32_t _3_NTT_table_Q1[4] = {
omega3Q1, invomega3Q1
};

static const int32_t _3_NTT_Rmod_table_Q1[4] = {
omega3RmodQ1, invomega3RmodQ1
};

static const int32_t _3_iNTT_Rmod_table_Q1[4] = {
invomega3RmodQ1, omega3RmodQ1
};

static const int32_t final_const[4] = {
invNinv3R2modQ1
};

#define NTT_forward(out, in){ \
    __asm_Good_3x2(out, _3_NTT_Rmod_table_Q1, Q1prime, Q1, in); \
    __asm_ntt_32(out, streamlined_CT_table_Q1, Q1prime, Q1); \
}

#define NTT_forward_small(out, in){ \
    __asm_Good_3x2_small(out, _3_NTT_table_Q1, Q1prime, Q1, in); \
    __asm_ntt_32(out, streamlined_CT_table_Q1, Q1prime, Q1); \
}

#define NTT_mul(out, in1, in2) __asm_base_mul(out, mul_Rmod_table_Q1, Q1prime, Q1, in1, in2)

#define NTT_inv(out, in){ \
    __asm_i_3x2(in, _3_iNTT_Rmod_table_Q1, Q1prime, Q1); \
    __asm_intt(in, streamlined_inv_CT_table_Q1, Q1prime, Q1); \
    __asm_final_map(out, final_const, Q1prime, Q1, in); \
}

#endif



