
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "hal.h"
#include "tools.h"
#include "NTT_params.h"
#include "NTT.h"

#define BUFF_MAX (NTT_N << 3)

char out[128];
char *out_ptr;
uint64_t oldcount, newcount;

struct compress_profile profile;

int main(void){

    hal_setup(CLOCK_BENCHMARK);


    hal_send_str("\n============ IGNORE OUTPUT BEFORE THIS LINE ============\n");

    profile.compressed_layers = 3;
    for(size_t i = 0; i < profile.compressed_layers; i++){
        profile.merged_layers[i] = 3;
    }

    int16_t poly1_int16[ARRAY_N];
    int8_t poly2_int8[ARRAY_N];

    int32_t poly1_NTT[ARRAY_N];
    int32_t poly2_NTT[ARRAY_N];
    int32_t res_NTT[ARRAY_N];

    int16_t polyout[ARRAY_N];

// ================

    oldcount = hal_get_time();
    NTT_forward(poly1_NTT, poly1_int16);
    NTT_forward_small(poly2_NTT, poly2_int8);
    NTT_mul(res_NTT, poly1_NTT, poly2_NTT);
    NTT_inv(polyout, res_NTT);
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
    NTT_mul(res_NTT, poly1_NTT, poly2_NTT);
    newcount = hal_get_time();
    sprintf(out, "base_mul: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    __asm_intt(res_NTT, streamlined_inv_CT_table_Q1, Q1prime, Q1);
    NTT_inv(polyout, res_NTT);
    newcount = hal_get_time();
    sprintf(out, "iNTT: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    __asm_final_map(polyout, final_const, Q1prime, Q1, res_NTT);
    newcount = hal_get_time();
    sprintf(out, "final_map: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================



}


