
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <assert.h>

#include "hal.h"
#include "tools.h"
#include "NTT_params.h"
#include "NTT.h"
#include "naive_mult.h"

#define POLY_N 864

char outs[128];
char *out_ptr;
unsigned long long oldcount, newcount;

void _16_to_8(int8_t *des, int16_t *src, size_t len);
void _8_to_16(int16_t *des, int8_t *src, size_t len);

int main(void){

    hal_setup(CLOCK_FAST);

    hal_send_str("\n============ IGNORE OUTPUT BEFORE THIS LINE ============\n");


    int16_t poly1_int16[ARRAY_N];
    int16_t poly2_int16[ARRAY_N];
    int16_t polyout_int16[ARRAY_N];

    int32_t poly1_NTT[ARRAY_N];
    int32_t poly2_NTT[ARRAY_N];
    int32_t res_NTT[ARRAY_N];

    int16_t poly_NTT_out_int16[ARRAY_N];

    int8_t *poly2_int8;

    int16_t tmp_int16;
    int16_t twiddle_int16;
    int16_t mod_int16;

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
    for(size_t i = (NTRU_N - 1) * 2; i >= NTRU_N; i--){
        polyout_int16[i - NTRU_N] = polyout_int16[i - NTRU_N] + polyout_int16[i];
        polyout_int16[i - NTRU_N + 1] = polyout_int16[i - NTRU_N + 1] + polyout_int16[i];
        cmod_int16(polyout_int16 + i - NTRU_N, polyout_int16 + i - NTRU_N, &mod_int16);
        cmod_int16(polyout_int16 + i - NTRU_N + 1, polyout_int16 + i - NTRU_N + 1, &mod_int16);
    }
    cmod_int16(polyout_int16 + (NTRU_N - 1), polyout_int16 + (NTRU_N - 1), &mod_int16);

    hal_send_str("naive_mulR finished!\n");

    poly2_int8 = (int8_t*)poly2_int16;
    _16_to_8(poly2_int8, poly2_int16, POLY_N);

// ================================

    for(size_t i = NTRU_N; i < POLY_N; i++){
        poly1_int16[i] = 0;
        poly2_int8[i] = 0;
    }

    NTT_forward(poly1_NTT, poly1_int16);
    NTT_forward_small(poly2_NTT, poly2_int8);
    NTT_mul(res_NTT, poly1_NTT, poly2_NTT);
    NTT_inv(poly_NTT_out_int16, poly1_NTT, res_NTT);

    hal_send_str("polymul finished!\n");

// ================================

    mod_int16 = NTRU_Q;
    for(size_t i = 0; i < NTRU_N; i++){
        cmod_int16(&tmp_int16, poly_NTT_out_int16 + i, &mod_int16);
        assert(polyout_int16[i] == tmp_int16);
    }

    hal_send_str("polymul passed!\n");

}

void _16_to_8(int8_t *des, int16_t *src, size_t len){
    for(size_t i = 0; i < len; i++){
        des[i] = src[i];
    }
}

void _8_to_16(int16_t *des, int8_t *src, size_t len){
    for(size_t i = len - 1; ; i--){
        des[i] = src[i];
        if(i == 0){
            break;
        }
    }
}






















