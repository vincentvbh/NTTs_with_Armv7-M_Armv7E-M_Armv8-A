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
-646701, -646701, 717391, -646701, -646701, 717391, -646701, 717391, 412895, -1271838, 717391, 412895, -1271838, -495760, 105904, -390952, 988269, 412895, -495760, 105904, 738084, 70287, 635657, 1265421, -1271838, -390952, 988269, -26813, -746429, -481666, -53105
};

static const int32_t mul_Rmod_table_Q1[NTT_N >> 1] = {
-646701, 717391, 412895, -1271838, -495760, 105904, -390952, 988269, 738084, 70287, 635657, 1265421, -26813, -746429, -481666, -53105
};

static const int32_t streamlined_inv_CT_table_Q1[NTT_N - 1] = {
-646701, -646701, -717391, -646701, -646701, -717391, -646701, 1271838, -717391, -412895, 1271838, -988269, 390952, 53105, 746429, 481666, 26813, -717391, 1271838, -412895, -988269, -105904, 390952, 495760, -412895, -105904, 495760, -1265421, -70287, -635657, -738084
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






