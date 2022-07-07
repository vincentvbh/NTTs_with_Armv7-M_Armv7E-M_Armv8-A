
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <assert.h>

#include "hal.h"
#include "tools.h"
#include "NTT_params.h"
#include "NTT.h"
#include "naive_mult.h"

char outs[128];
char *out_ptr;
unsigned long long oldcount, newcount;

int main(void){

    hal_setup(CLOCK_FAST);

    hal_send_str("\n============ IGNORE OUTPUT BEFORE THIS LINE ============\n");

    int16_t poly1_int16[ARRAY_N];
    int16_t poly2_int16[ARRAY_N];
    int16_t polyout_int16[ARRAY_N];

    int8_t poly2_int8[ARRAY_N];

    int32_t poly1_NTT[ARRAY_N];
    int32_t poly2_NTT[ARRAY_N];
    int32_t res_NTT[ARRAY_N];

    int16_t res_NTT_int16[ARRAY_N];

    int16_t mod_int16;
    int16_t twiddle_int16;
    int16_t tmp_int16;

// ================================

    for(size_t i = 0; i < ARRAY_N; i++){
        tmp_int16 = rand() % NTRU_Q;
        poly1_int16[i] = tmp_int16 - (NTRU_Q >> 1);
        if(i >= NTRU_N){
            poly1_int16[i] = 0;
        }
    }
    for(size_t i = 0; i < ARRAY_N; i++){
        tmp_int16 = rand() % 3;
        poly2_int16[i] = tmp_int16 - 1;
        if(i >= NTRU_N){
            poly2_int16[i] = 0;
        }
    }

    twiddle_int16 = 1;
    mod_int16 = NTRU_Q;
    naive_mulR(
        polyout_int16, poly1_int16, poly2_int16,
        ARRAY_N, &twiddle_int16, &mod_int16,
        sizeof(int16_t),
        addmod_int16,
        mulmod_int16
    );

    mod_int16 = NTRU_Q;
    for(size_t i = (2 * NTRU_N - 2); i >= NTRU_N; i--){
        addmod_int16(polyout_int16 + (i - NTRU_N),
                     polyout_int16 + (i - NTRU_N), polyout_int16 + i, &mod_int16);
        addmod_int16(polyout_int16 + (i - NTRU_N) + 1,
                     polyout_int16 + (i - NTRU_N) + 1, polyout_int16 + i, &mod_int16);
    }

    hal_send_str("naive_mulR finished!\n");

    for(size_t i = 0; i < ARRAY_N; i++){
        poly2_int8[i] = poly2_int16[i];
    }

// ================================

    for(size_t i = NTRU_N; i < POLY_N; i++){
        poly1_int16[i] = 0;
        poly2_int8[i] = 0;
    }

    NTT_forward(poly1_NTT, poly1_int16);
    NTT_forward_small(poly2_NTT, poly2_int8);
    NTT_mul(res_NTT, poly1_NTT, poly2_NTT);
    NTT_inv(res_NTT_int16, res_NTT);

// ================

    hal_send_str("polymul finished!\n");

// ================================

    mod_int16 = NTRU_Q;
    for(size_t i = 0; i < NTRU_N; i++){
        cmod_int16(&tmp_int16, res_NTT_int16 + i, &mod_int16);
        assert(polyout_int16[i] == tmp_int16);
    }

    hal_send_str("polymul passed!\n");

}

// void _3_NTT(int32_t *des,
//     size_t indx_c0, size_t indx_c1, size_t indx_c2,
//     int32_t *twiddle){

//     int32_t c0 = des[indx_c0];
//     int32_t c1 = des[indx_c1];
//     int32_t c2 = des[indx_c2];

//     int32_t twiddle_int32;
//     int32_t mod_int32;
//     int32_t tmp0_int32;
//     int32_t tmp1_int32;
//     int32_t tmp2_int32;

//     mod_int32 = Q1;

//     twiddle_int32 = twiddle[0];
//     mulmod_int32(&tmp1_int32, &c1, &twiddle_int32, &mod_int32);
//     expmod_int32(&twiddle_int32, &twiddle_int32, 2, &mod_int32);
//     mulmod_int32(&tmp2_int32, &c2, &twiddle_int32, &mod_int32);
//     tmp0_int32 = c0 + tmp1_int32 + tmp2_int32;
//     cmod_int32(des + indx_c0, &tmp0_int32, &mod_int32);

//     twiddle_int32 = twiddle[1];
//     mulmod_int32(&tmp1_int32, &c1, &twiddle_int32, &mod_int32);
//     expmod_int32(&twiddle_int32, &twiddle_int32, 2, &mod_int32);
//     mulmod_int32(&tmp2_int32, &c2, &twiddle_int32, &mod_int32);
//     tmp0_int32 = c0 + tmp1_int32 + tmp2_int32;
//     cmod_int32(des + indx_c1, &tmp0_int32, &mod_int32);

//     twiddle_int32 = twiddle[2];
//     mulmod_int32(&tmp1_int32, &c1, &twiddle_int32, &mod_int32);
//     expmod_int32(&twiddle_int32, &twiddle_int32, 2, &mod_int32);
//     mulmod_int32(&tmp2_int32, &c2, &twiddle_int32, &mod_int32);
//     tmp0_int32 = c0 + tmp1_int32 + tmp2_int32;
//     cmod_int32(des + indx_c2, &tmp0_int32, &mod_int32);

// }

// void _9_NTT(int32_t *des, size_t step){

//     int32_t mod_int32;

//     _3_NTT(des, 0 * step, 3 * step, 6 * step, _9_NTT_table + 0);
//     _3_NTT(des, 1 * step, 4 * step, 7 * step, _9_NTT_table + 0);
//     _3_NTT(des, 2 * step, 5 * step, 8 * step, _9_NTT_table + 0);

//     mod_int32 = Q1;
//     mulmod_int32(des + 4 * step, des + 4 * step, _9_NTT_table + 3, &mod_int32);
//     mulmod_int32(des + 5 * step, des + 5 * step, _9_NTT_table + 6, &mod_int32);
//     mulmod_int32(des + 7 * step, des + 7 * step, _9_NTT_table + 6, &mod_int32);
//     mulmod_int32(des + 8 * step, des + 8 * step, _9_NTT_table + 4, &mod_int32);

//     _3_NTT(des, 0 * step, 1 * step, 2 * step, _9_NTT_table + 0);
//     _3_NTT(des, 3 * step, 4 * step, 5 * step, _9_NTT_table + 0);
//     _3_NTT(des, 6 * step, 7 * step, 8 * step, _9_NTT_table + 0);

// }

// void _9_iNTT(int32_t *des, size_t step){

//     int32_t mod_int32;

//     _3_NTT(des, 0 * step, 1 * step, 2 * step, _9_iNTT_table + 0);
//     _3_NTT(des, 3 * step, 4 * step, 5 * step, _9_iNTT_table + 0);
//     _3_NTT(des, 6 * step, 7 * step, 8 * step, _9_iNTT_table + 0);

//     mod_int32 = Q1;
//     mulmod_int32(des + 4 * step, des + 4 * step, _9_iNTT_table + 3, &mod_int32);
//     mulmod_int32(des + 5 * step, des + 5 * step, _9_iNTT_table + 6, &mod_int32);
//     mulmod_int32(des + 7 * step, des + 7 * step, _9_iNTT_table + 6, &mod_int32);
//     mulmod_int32(des + 8 * step, des + 8 * step, _9_iNTT_table + 4, &mod_int32);

//     _3_NTT(des, 0 * step, 3 * step, 6 * step, _9_iNTT_table + 0);
//     _3_NTT(des, 1 * step, 4 * step, 7 * step, _9_iNTT_table + 0);
//     _3_NTT(des, 2 * step, 5 * step, 8 * step, _9_iNTT_table + 0);

// }























