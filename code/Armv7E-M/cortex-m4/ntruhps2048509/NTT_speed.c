

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <assert.h>

#include "hal.h"
#include "tools.h"
#include "NTT_params.h"
#include "NTT.h"

#define BUFF_MAX (NTT_N << 3)

struct compress_profile profile;

char outs[128];
char *out_ptr;
unsigned long long oldcount, newcount;


int main(void){

    hal_setup(CLOCK_BENCHMARK);

    hal_send_str("\n============ IGNORE OUTPUT BEFORE THIS LINE ============\n");

    int16_t poly1_int16[ARRAY_N];
    int16_t poly2_int16[ARRAY_N];

    int32_t poly1_NTT[ARRAY_N];
    int32_t poly2_NTT[ARRAY_N];
    int32_t res_NTT[ARRAY_N];

    int16_t poly_NTT_out_int16[ARRAY_N];

// ================================

    oldcount = hal_get_time();
    NTT_forward(poly1_NTT, (uint16_t*)poly1_int16);
    NTT_forward_small(poly2_NTT, (uint16_t*)poly2_int16);
    NTT_mul(res_NTT, poly1_NTT, poly2_NTT);
    NTT_inv(res_NTT);
    NTT_final_map((uint16_t*)poly_NTT_out_int16, res_NTT);
    newcount = hal_get_time();
    sprintf(outs, "polymul: %lld cycles\n", newcount - oldcount);
    hal_send_str(outs);

// ================================

    oldcount = hal_get_time();
    NTT_forward(poly1_NTT, (uint16_t*)poly1_int16);
    newcount = hal_get_time();
    sprintf(outs, "NTT: %lld cycles\n", newcount - oldcount);
    hal_send_str(outs);

// ================================

    oldcount = hal_get_time();
    NTT_forward_small(poly2_NTT, (uint16_t*)poly2_int16);
    newcount = hal_get_time();
    sprintf(outs, "NTT light: %lld cycles\n", newcount - oldcount);
    hal_send_str(outs);

// ================================

    oldcount = hal_get_time();
    NTT_mul(res_NTT, poly1_NTT, poly2_NTT);
    newcount = hal_get_time();
    sprintf(outs, "base_mul: %lld cycles\n", newcount - oldcount);
    hal_send_str(outs);

// ================================

    oldcount = hal_get_time();
    NTT_inv(res_NTT);
    newcount = hal_get_time();
    sprintf(outs, "iNTT: %lld cycles\n", newcount - oldcount);
    hal_send_str(outs);

// ================================

    oldcount = hal_get_time();
    NTT_final_map((uint16_t*)poly_NTT_out_int16, res_NTT);
    newcount = hal_get_time();
    sprintf(outs, "final_map: %lld cycles\n", newcount - oldcount);
    hal_send_str(outs);




}


