


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

    hal_setup(CLOCK_BENCHMARK);


    hal_send_str("\n============ IGNORE OUTPUT BEFORE THIS LINE ============\n");

    int16_t poly1_int16[ARRAY_N];
    int8_t poly2_int8[ARRAY_N];

    int32_t poly1_NTT[ARRAY_N];
    int32_t poly2_NTT[ARRAY_N];

    int16_t polyout[ARRAY_N];

// ================

    oldcount = hal_get_time();
    NTT_forward(poly1_NTT, poly1_int16);
    NTT_forward_small(poly2_NTT, poly2_int8);
    NTT_mul(poly1_NTT, poly2_NTT);
    NTT_inv(polyout, poly1_NTT);
    newcount = hal_get_time();
    sprintf(out, "polymul: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    NTT_forward(poly1_NTT, poly1_int16);
    newcount = hal_get_time();
    sprintf(out, "NTT: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    NTT_forward_small(poly2_NTT, poly2_int8);
    newcount = hal_get_time();
    sprintf(out, "NTT small: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    NTT_mul(poly1_NTT, poly2_NTT);
    newcount = hal_get_time();
    sprintf(out, "base_mul: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    __asm_intt(poly1_NTT, streamlined_Rmod_inv_GS_root_table, Q1prime, Q1);
    newcount = hal_get_time();
    sprintf(out, "iNTT: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    __asm_final_map(poly1_NTT, Q1half, Q1prime, Q1, polyout);
    newcount = hal_get_time();
    sprintf(out, "final_map: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

}



















