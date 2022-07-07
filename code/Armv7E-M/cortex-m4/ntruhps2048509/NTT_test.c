
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <assert.h>

#include "hal.h"
#include "tools.h"
#include "NTT_params.h"
#include "NTT.h"
#include "naive_mult.h"

#define BUFF_MAX (NTT_N << 3)

struct compress_profile profile;

char outs[128];
char *out_ptr;
unsigned long long oldcount, newcount;

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

    int16_t tmp_int16;
    int16_t twiddle_int16;

// ================================

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
    for(size_t i = ((NTRU_N - 1) << 1); i >= NTRU_N; i--){
        addmod_int16(polyout_int16 + (i - NTRU_N), polyout_int16 + (i - NTRU_N), polyout_int16 + i, &mod_int16);
    }

    hal_send_str("naive_mulR finished!\n");

// ================================

    for(size_t i = NTRU_N; i < ARRAY_N; i++){
        tmp_int16 = rand();
        poly1_int16[i] = tmp_int16;
        tmp_int16 = rand();
        poly2_int16[i] = tmp_int16;
    }

// ================================

    NTT_forward(poly1_NTT, (uint16_t*)poly1_int16);
    NTT_forward_small(poly2_NTT, (uint16_t*)poly2_int16);
    NTT_mul(res_NTT, poly1_NTT, poly2_NTT);
    NTT_inv(res_NTT);
    NTT_final_map((uint16_t*)poly_NTT_out_int16, res_NTT);

    hal_send_str("polymul finished!\n");

// ================================

    mod_int16 = NTRU_Q;
    for(size_t i = 0; i < NTRU_N; i++){
        cmod_int16(&tmp_int16, poly_NTT_out_int16 + i, &mod_int16);
        assert(polyout_int16[i] == tmp_int16);
    }

    hal_send_str("polymul passed!\n");

}
