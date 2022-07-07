

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

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
    int8_t poly2_int8[ARRAY_N];
    int16_t res[ARRAY_N];

    int32_t poly1_NTT[ARRAY_N];
    int32_t poly2_NTT[ARRAY_N];

    int16_t polyout[ARRAY_N];

    int16_t mod_int16;
    int16_t twiddle_int16;

    for(size_t i = 0; i < ARRAY_N; i++){
        poly1_int16[i] = (rand() % NTRU_Q) - (NTRU_Q >> 1);
        if(i >= NTRU_N){
            poly1_int16[i] = 0;
        }
    }
    for(size_t i = 0; i < ARRAY_N; i++){
        poly2_int16[i] = (rand() % 3) - 1;
        if(i >= NTRU_N){
            poly2_int16[i] = 0;
        }
        poly2_int8[i] = poly2_int16[i];
    }

// ================================

    mod_int16 = NTRU_Q;
    twiddle_int16 = 1;
    naive_mulR(
        res,
        poly1_int16, poly2_int16,
        ARRAY_N, &twiddle_int16,
        &mod_int16,
        sizeof(int16_t),
        addmod_int16,
        mulmod_int16
    );

    mod_int16 = NTRU_Q;
    for(size_t i = 2 * (NTRU_N - 1); i >= NTRU_N; i--){
        addmod_int16(res + i - NTRU_N, res + i - NTRU_N, res + i, &mod_int16);
        addmod_int16(res + i - NTRU_N + 1, res + i - NTRU_N + 1, res + i, &mod_int16);
    }

    hal_send_str("naive_mulR finished!\n");

// ================================

    NTT_forward(poly1_NTT, poly1_int16);
    NTT_forward_small(poly2_NTT, poly2_int8);
    NTT_mul(poly1_NTT, poly2_NTT);
    NTT_inv(polyout, poly1_NTT);

    hal_send_str("polymul finished!\n");

// ================================

    for(size_t i = 0; i < NTRU_N; i++){
        assert(res[i] == polyout[i]);
    }

    hal_send_str("polymul passed!\n");

// ================================

}

















