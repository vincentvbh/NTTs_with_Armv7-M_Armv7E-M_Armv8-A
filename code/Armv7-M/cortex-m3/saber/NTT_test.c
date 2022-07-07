
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

    int16_t poly1_NTT_Q1[ARRAY_N];
    int16_t poly2_NTT_Q1[ARRAY_N];
    int16_t res_NTT_Q1[ARRAY_N];

    int16_t poly1_NTT_Q2[ARRAY_N];
    int16_t poly2_NTT_Q2[ARRAY_N];
    int16_t res_NTT_Q2[ARRAY_N];

    int16_t res_NTT[ARRAY_N];

    int16_t tmp_int16;
    int16_t twiddle_int16;
    int16_t mod_int16;

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

    NTT_forward1(poly1_NTT_Q1, (uint16_t*)poly1_int16);
    NTT_forward1(poly2_NTT_Q1, (uint16_t*)poly2_int16);
    NTT_mul1(res_NTT_Q1, poly1_NTT_Q1, poly2_NTT_Q1);
    NTT_inv1(res_NTT_Q1);
    NTT_forward2(poly1_NTT_Q2, (uint16_t*)poly1_int16);
    NTT_forward2(poly2_NTT_Q2, (uint16_t*)poly2_int16);
    NTT_mul2(res_NTT_Q2, poly1_NTT_Q2, poly2_NTT_Q2);
    NTT_inv2(res_NTT_Q2);
    solv_CRT((uint16_t*)res_NTT, res_NTT_Q1, res_NTT_Q2);

    mod_int16 = SABER_Q;
    for(size_t i = 0; i < ARRAY_N; i++){
        cmod_int16(&tmp_int16, res_NTT + i, &mod_int16);
        assert(res_int16[i] == tmp_int16);
    }

    sprintf(out, "polymul passed!\n");
    hal_send_str(out);


}

