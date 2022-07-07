
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "hal.h"

#include "tools.h"
#include "naive_mult.h"
#include "NTT_params.h"
#include "NTT.h"

#define BUFF_MAX (NTT_N << 3)

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
    NTT_forward(poly1_NTT, poly1_int16);
    NTT_forward_small(poly2_NTT, poly2_int16);
    NTT_mul(res_NTT, poly1_NTT, poly2_NTT);
    NTT_inv((uint16_t*)poly_NTT_out_int16, res_NTT);
    newcount = hal_get_time();
    sprintf(outs, "polymul: %lld cycles\n", newcount - oldcount);
    hal_send_str(outs);

// ================================

    oldcount = hal_get_time();
    NTT_forward(poly1_NTT, poly1_int16);
    newcount = hal_get_time();
    sprintf(outs, "NTT: %lld cycles\n", newcount - oldcount);
    hal_send_str(outs);

// ================================

    oldcount = hal_get_time();
    NTT_forward_small(poly2_NTT, poly2_int16);
    newcount = hal_get_time();
    sprintf(outs, "NTT small: %lld cycles\n", newcount - oldcount);
    hal_send_str(outs);

// ================================

    oldcount = hal_get_time();
    NTT_mul(res_NTT, poly1_NTT, poly2_NTT);
    newcount = hal_get_time();
    sprintf(outs, "base_mul: %lld cycles\n", newcount - oldcount);
    hal_send_str(outs);

// ================================

    oldcount = hal_get_time();
    __asm_3x2block_intt(res_NTT, _3x2_twist_iNTT_Rmod_table, Q1prime, Q1);
    __asm_intt_32(res_NTT, streamlined_inv_CT_table_Q1, Q1prime, Q1);
    newcount = hal_get_time();
    sprintf(outs, "iNTT: %lld cycles\n", newcount - oldcount);
    hal_send_str(outs);

// ================================

    oldcount = hal_get_time();
    __asm_final_map((uint16_t*)poly_NTT_out_int16, invNinv9R2modQ1, Q1prime, Q1, res_NTT);
    newcount = hal_get_time();
    sprintf(outs, "final_map: %lld cycles\n", newcount - oldcount);
    hal_send_str(outs);




}





















