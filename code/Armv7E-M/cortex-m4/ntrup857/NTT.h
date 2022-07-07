#ifndef NTT_H
#define NTT_H

#include <stdint.h>

#include "NTT_params.h"

extern void __asm_Good_3x2(int32_t *des, const int32_t *table, int32_t Qprime, int32_t Q, int16_t *src);
extern void __asm_Good_3x2_small(int32_t *des, const int32_t *table, int32_t Qprime, int32_t Q, int8_t *src);
extern void __asm_3x2block_ntt(int32_t *des, const int32_t *table, int32_t Qprime, int32_t Q);
extern void __asm_ntt(int32_t *des, const int32_t *table, int32_t Qprime, int32_t Q);
extern void __asm_base_mul(int32_t *des, const int32_t *table, int32_t Qprime, int32_t Q, int32_t *src1, int32_t *src2);
extern void __asm_intt(int32_t *des, const int32_t *table, int32_t Qprime, int32_t Q);
extern void __asm_3x2block_intt(int32_t *des, const int32_t *table, int32_t Qprime, int32_t Q);
extern void __asm_i_Good(int32_t *des, int32_t *src);
extern void __asm_final_map(int16_t *des, const int32_t *_final_const, int32_t Qprime, int32_t Q, int32_t *src);

static const int32_t _9_NTT_table[16] = {
1, omega93Q1, omega96Q1,
omega9Q1, omega94Q1, omega97Q1,
omega92Q1, omega95Q1, omega98Q1,
};

static const int32_t _3x2_NTT_table_Q1[32] = {
omega93Q1,       omega96Q1,
       1,                1,               1,
       1,         omega9Q1,       omega92Q1,
       1,        omega92Q1,       omega94Q1,
 omega4Q1,        omega4Q1,        omega4Q1,
 omega4Q1,  omega4omega9Q1, omega4omega92Q1,
 omega4Q1, omega4omega92Q1, omega4omega94Q1
};

static const int32_t streamlined_CT_table_Q1[NTT_N - 1] = {
2041691, 2041691, -690659, 2041691, 2041691, -690659, 2041691, -690659, 1551513, 50546, 2041691, -690659, 1551513, 50546, -3698886, 3895587, 4085628, -460856, -690659, 1551513, 50546, -3698886, 3895587, 4085628, -460856, 4325103, -2340071, 3642531, 926600, 2707899, 3019338, 1586239, 2900564, 1551513, -3698886, 3895587, 4325103, -2340071, 3642531, 926600, 1809410, 2442209, -2151536, 1735598, -834358, -3158364, -1218153, -3312403, 50546, 4085628, -460856, 2707899, 3019338, 1586239, 2900564, 375524, -508462, 2454143, 3105061, -661938, -785648, -490540, -2914604
};

static const int32_t mul_Rmod_table_Q1[((NTT_N >> 1) * 9)] = {
-2041691, -853674, 2895365, 2998584, -3667867, 669283, -1864248, 3859615, -1995367, 690659, 1000596, -1691255, 3604643, 3027337, 2219413, -3548194, -4154464, -1148735, -1551513, -2966246, -4333634, 4199779, 509077, 4142537, 140703, 402362, -543065, -50546, 851987, -801441, 3395905, -3463150, 67245, -1167333, -150226, 1317559, 3698886, -2185560, -1513326, -4126785, 966446, 3160339, 2145482, 280458, -2425940, -3895587, -2387344, -2568462, 3598085, 3087093, 2166215, -2332887, -1296551, 3629438, -4085628, 162219, 3923409, 3843543, 1719711, 3288139, 3382212, 1412596, 4056585, 460856, 3394179, -3855035, 4108396, 2135381, 2607616, -250717, 475904, -225187, -4325103, -3178713, -1347577, -1545565, -2415774, 3961339, 2541435, -1599808, -941627, 2340071, -3800625, 1460554, -3800225, -3002530, -2048638, 3237283, 1958445, 3655665, -3642531, 514007, 3128524, 1307769, -805486, -502283, -2517573, 2135517, 382056, -926600, 307062, 619538, 4223651, -1722209, -2501442, 1836404, -150647, -1685757, -2707899, -543796, 3251695, -4018329, -2532256, -2300808, -3157715, 3881523, -723808, -3019338, 1735233, 1284105, 3710042, 90975, -3801017, -2612050, 1284953, 1327097, -1586239, 1939186, -352947, 1673018, -4241584, 2568566, -3087327, 621717, 2465610, -2900564, 2251029, 649535, -803135, -445422, 1248557, 1390754, 2225645, -3616399, -1809410, 1500036, 309374, 1363461, -478827, -884634, 3860371, 1253243, 3737779, -2442209, 2836307, -394098, 603670, -549862, -53808, 1964335, 2551922, 4335136, 2151536, -1945038, -206498, 3430281, -37687, -3392594, -781136, -2225035, 3006171, -1735598, -2079807, 3815405, -4346453, 476481, 3869972, 650926, -2753973, 2103047, 834358, -4409195, 3574837, 2321006, 470811, -2791817, -1032447, 3285298, -2252851, 3158364, -2005942, -1152422, -595505, 2829356, -2233851, -4377702, 3673892, 703810, 1218153, 3145113, -4363266, 3699708, 503669, -4203377, 2013229, -1464927, -548302, 3312403, -637231, -2675172, 1422659, 3392615, 4036119, 4165463, -1815570, -2349893, -375524, 800611, -425087, 3482116, 926087, -4408203, -643477, -431730, 1075207, 508462, 1710566, -2219028, 2204818, 1372941, -3577759, 3414512, 3925676, 1511205, -2454143, 3398551, -944408, -2027517, -1625288, 3652805, -143684, -3166398, 3310082, -3105061, 3938928, -833867, 1770337, -1997022, 226685, -2505625, -2300520, -4045248, 661938, 3961718, 4227737, 3915654, 4107585, 828154, -1401060, -709144, 2110204, 785648, 1803304, -2588952, -2729684, 3981875, -1252191, -1194593, 1291308, -96715, 490540, 3938925, 4421928, 1493133, 2890831, -4383964, -3649577, 2832224, 817353, 2914604, -1350482, -1564122, -2349393, -1413392, 3762785, 47928, -2266922, 2218994
};

static const int32_t streamlined_inv_CT_table_Q1[NTT_N - 1] = {
2041691, 2041691, 690659, 2041691, 690659, -50546, -1551513, 2041691, 2041691, 690659, 2041691, 690659, -50546, -1551513, 690659, -50546, -1551513, 460856, -4085628, -3895587, 3698886, -50546, 460856, -4085628, -2900564, -1586239, -3019338, -2707899, -1551513, -3895587, 3698886, -926600, -3642531, 2340071, -4325103, 460856, -2900564, -1586239, 2914604, 490540, 785648, 661938, -4085628, -3019338, -2707899, -3105061, -2454143, 508462, -375524, -3895587, -926600, -3642531, 3312403, 1218153, 3158364, 834358, 3698886, 2340071, -4325103, -1735598, 2151536, -2442209, -1809410
};

static const int32_t _3x2block_intt_table_Q1[27] = {
2041691, 2041691, 690659, 2041691, 690659, -50546, -1551513,
invomega93RmodQ1, invomega96RmodQ1,
 invomega9RmodQ1, invomega92RmodQ1, invomega94RmodQ1, invomega98RmodQ1,
invomega95RmodQ1,  invomega9RmodQ1,
invomega4RmodQ1,
invomega4omega9RmodQ1, invomega4omega92RmodQ1, invomega4omega94RmodQ1, invomega4omega98RmodQ1,
invomega4omega95RmodQ1, invomega4omega9RmodQ1
};

static const int32_t _3x2_NTT_Rmod_table_Q1[32] = {
omega93RmodQ1, omega96RmodQ1,
 omega9RmodQ1, omega92RmodQ1,  omega94RmodQ1, omega98RmodQ1,
omega95RmodQ1,  omega9RmodQ1,
omega4RmodQ1,
omega4omega9RmodQ1, omega4omega92RmodQ1, omega4omega94RmodQ1, omega4omega98RmodQ1,
omega4omega95RmodQ1, omega4omega9RmodQ1
};

static const int32_t final_const[4] = {
invNinv9R2modQ1, NTRU_Q, NTRU_Qbar
};

#define NTT_forward(out, in){ \
    __asm_Good_3x2(out, _3x2_NTT_Rmod_table_Q1, Q1prime, Q1, in); \
    __asm_3x2block_ntt(out, _3x2_NTT_Rmod_table_Q1, Q1prime, Q1); \
    __asm_ntt(out, streamlined_CT_table_Q1, Q1prime, Q1); \
}

#define NTT_forward_small(out, in){ \
    __asm_Good_3x2_small(out, _3x2_NTT_table_Q1, Q1prime, Q1, in); \
    __asm_3x2block_ntt(out, _3x2_NTT_Rmod_table_Q1, Q1prime, Q1); \
    __asm_ntt(out, streamlined_CT_table_Q1, Q1prime, Q1); \
}

#define NTT_mul(out, in1, in2) __asm_base_mul(out, mul_Rmod_table_Q1, Q1prime, Q1, in1, in2)


#define NTT_inv(out, buff, in){ \
    __asm_intt(in, streamlined_inv_CT_table_Q1, Q1prime, Q1); \
    __asm_3x2block_intt(in, _3x2block_intt_table_Q1, Q1prime, Q1); \
    __asm_i_Good(buff, in); \
    __asm_final_map(out, final_const, Q1prime, Q1, buff); \
}

#endif


