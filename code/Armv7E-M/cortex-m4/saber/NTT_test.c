
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "SABER_params.h"

#include "hal.h"
#include "tools.h"
#include "NTT_params.h"
#include "NTT.h"
#include "naive_mult.h"

char out[128];
char *out_ptr;
uint64_t oldcount, newcount;

int main(void){

    hal_setup(CLOCK_FAST);


    hal_send_str("\n============ IGNORE OUTPUT BEFORE THIS LINE ============\n");

    int16_t poly1_int16[ARRAY_N];
    int16_t poly2_int16[ARRAY_N];
    int16_t res_int16[ARRAY_N];

    int32_t poly1_NTT_Q1Q2[ARRAY_N];
    int32_t poly2_NTT_Q1Q2[ARRAY_N];
    int32_t res_NTT_Q1Q2[ARRAY_N];

    int16_t buff0_int16[ARRAY_N];
    int16_t buff1_int16[ARRAY_N];
    int16_t buff2_int16[ARRAY_N];

    int32_t *buff01_int32 = (int32_t*)buff0_int16;

    int16_t res_NTT[ARRAY_N];

    int16_t tmp_int16;
    int16_t twiddle_int16;
    int16_t mod_int16;

// ================

    for(size_t i = 0; i < ARRAY_N; i++){
        tmp_int16 = rand() % SABER_Q;
        poly1_int16[i] = tmp_int16 - (SABER_Q >> 1);
    }

    for(size_t i = 0; i < ARRAY_N; i++){
        tmp_int16 = rand() % SABER_MU;
        poly2_int16[i] = tmp_int16 - (SABER_MU >> 1);
    }

    mod_int16 = SABER_Q;
    twiddle_int16 = -1;
    naive_mulR(
        res_int16, poly1_int16, poly2_int16,
        ARRAY_N, &twiddle_int16, &mod_int16,
        sizeof(int16_t), addmod_int16, mulmod_int16
    );

// ================

    NTT_forward_32(poly1_NTT_Q1Q2, (uint16_t*)poly1_int16);
    NTT_forward_32(poly2_NTT_Q1Q2, (uint16_t*)poly2_int16);
    NTT_mul_32(res_NTT_Q1Q2, poly1_NTT_Q1Q2, poly2_NTT_Q1Q2);
    NTT_inv_32((uint16_t*)res_NTT, res_NTT_Q1Q2);


    mod_int16 = SABER_Q;
    for(size_t i = 0; i < ARRAY_N; i++){
        cmod_int16(&tmp_int16, res_NTT + i, &mod_int16);
        assert(res_int16[i] == tmp_int16);
    }

    hal_send_str("polymul passed!\n");

// ================

    // Be aware that we will overflowing in NTT_mul_16_{1, 2} if both
    // sources are computed with NTT_forward{1, 2}
    // this is different from the ARMv7-M code because in ARMv7E-M we
    // use the DSP extension in NTT_mul_16_{1, 2}
    NTT_forward_32(buff01_int32, (uint16_t*)poly1_int16);
    NTT_forward2(buff2_int16, (uint16_t*)poly2_int16);
    NTT_mul_32x16_2(buff2_int16, buff01_int32, buff2_int16);
    MOD_1(buff0_int16, buff01_int32);
    NTT_forward1(buff1_int16, (uint16_t*)poly2_int16);
    NTT_mul_16_1(buff1_int16, buff0_int16, buff1_int16);
    solv_CRT(buff01_int32, buff1_int16, buff2_int16);
    NTT_inv_32((uint16_t*)res_NTT, buff01_int32);

    mod_int16 = SABER_Q;
    for(size_t i = 0; i < ARRAY_N; i++){
        cmod_int16(&tmp_int16, res_NTT + i, &mod_int16);
        assert(res_int16[i] == tmp_int16);
    }

    hal_send_str("polymul passed!\n");

// ================





}
