#ifndef NTT_H
#define NTT_H

#include <stdint.h>

#include "NTT_params.h"

static const int32_t _9_NTT_table[16] = {
1, omega93Q1, omega96Q1,
omega9Q1, omega94Q1, omega97Q1,
omega92Q1, omega95Q1, omega98Q1,
};

static const int32_t _9_NTT_Rmod_table[16] = {
1, omega93RmodQ1, omega96RmodQ1,
omega9RmodQ1, omega94RmodQ1, omega97RmodQ1,
omega92RmodQ1, omega95RmodQ1, omega98RmodQ1,
};

static const int32_t _3x2_twist_NTT_Rmod_table[16] = {
omega4RmodQ1,
omega93RmodQ1, omega96RmodQ1,
omega9RmodQ1, omega92RmodQ1, omega94RmodQ1, omega98RmodQ1,
omega95RmodQ1, omega9RmodQ1,
omega4omega9RmodQ1, omega4omega92RmodQ1, omega4omega94RmodQ1, omega4omega98RmodQ1,
omega4omega95RmodQ1, omega4omega9RmodQ1
};

static const int32_t _3x2_twist_iNTT_Rmod_table[16] = {
invomega4RmodQ1,
invomega93RmodQ1, invomega96RmodQ1,
invomega9RmodQ1, invomega92RmodQ1, invomega94RmodQ1, invomega98RmodQ1,
invomega95RmodQ1, invomega9RmodQ1,
invomega4omega9RmodQ1, invomega4omega92RmodQ1, invomega4omega94RmodQ1, invomega4omega98RmodQ1,
invomega4omega95RmodQ1, invomega4omega9RmodQ1
};

static const int32_t streamlined_CT_table_Q1[NTT_N - 1] = {
-695350, -695350, 5428110, -695350, -695350, 5428110, -695350, 5428110, 2879314, 4812619, 5428110, 2879314, 4812619, 2252403, -934199, -2620540, -2967330, 2879314, 2252403, -934199, -2986825, -11370, -5549095, -2335132, 4812619, -2620540, -2967330, -1224724, 4995672, -3245977, 30655
};

static const int32_t mul_Rmod_table_Q1[NTT_N >> 1] = {
-695350, 5428110, 2879314, 4812619, 2252403, -934199, -2620540, -2967330, -2986825, -11370, -5549095, -2335132, -1224724, 4995672, -3245977, 30655
};

static const int32_t streamlined_inv_CT_table_Q1[NTT_N - 1] = {
-695350, -695350, -5428110, -695350, -695350, -5428110, -695350, -4812619, -5428110, -2879314, -4812619, 2967330, 2620540, -30655, -4995672, 3245977, 1224724, -5428110, -4812619, -2879314, 2967330, 934199, 2620540, -2252403, -2879314, 934199, -2252403, 2335132, 11370, 5549095, 2986825
};


extern void __asm_Good_3x2(int32_t *des, const int32_t *table, int32_t Qprime, int32_t Q, const int16_t *src);
extern void __asm_Good_3x2_small(int32_t *des, const int32_t *table, int32_t Qprime, int32_t Q, const int16_t *src);
extern void __asm_3x2block_ntt(int32_t *des, const int32_t *table, int32_t Qprime, int32_t Q);
extern void __asm_ntt_32(int32_t *src, const int32_t *table, int32_t Qprime, int32_t Q);

extern void __asm_base_mul(int32_t *des, const int32_t *table, int32_t Qprime, int32_t Q, int32_t *src1, int32_t *src2);

extern void __asm_3x2block_intt(int32_t *src, const int32_t *table, int32_t Qprime, int32_t Q);
extern void __asm_intt_32(int32_t *src, const int32_t *table, int32_t Qprime, int32_t Q);
extern void __asm_final_map(uint16_t *des, int32_t final_const, int32_t Qprime, int32_t Q, int32_t *src);


#define NTT_forward(out, in) { \
    __asm_Good_3x2(out, _9_NTT_Rmod_table, Q1prime, Q1, in); \
    __asm_3x2block_ntt(out, _3x2_twist_NTT_Rmod_table, Q1prime, Q1); \
    __asm_ntt_32(out, streamlined_CT_table_Q1, Q1prime, Q1); \
}

#define NTT_forward_small(out, in) { \
    __asm_Good_3x2_small(out, _9_NTT_table, Q1prime, Q1, in); \
    __asm_3x2block_ntt(out, _3x2_twist_NTT_Rmod_table, Q1prime, Q1); \
    __asm_ntt_32(out, streamlined_CT_table_Q1, Q1prime, Q1); \
}

#define NTT_mul(out, in1, in2) __asm_base_mul(out, mul_Rmod_table_Q1, Q1prime, Q1, in1, in2);

#define NTT_inv(out, in) { \
    __asm_3x2block_intt(in, _3x2_twist_iNTT_Rmod_table, Q1prime, Q1); \
    __asm_intt_32(in, streamlined_inv_CT_table_Q1, Q1prime, Q1); \
    __asm_final_map(out, invNinv9R2modQ1, Q1prime, Q1, in); \
}

#endif






