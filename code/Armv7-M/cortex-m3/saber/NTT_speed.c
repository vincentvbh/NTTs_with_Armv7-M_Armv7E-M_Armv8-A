
#include <stdio.h>
#include <stdlib.h>

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

    hal_setup(CLOCK_BENCHMARK);

    hal_send_str("\n============ IGNORE OUTPUT BEFORE THIS LINE ============\n");

    int16_t poly1_int16[ARRAY_N];
    int16_t poly2_int16[ARRAY_N];

    int16_t poly1_NTT_Q1[ARRAY_N];
    int16_t poly2_NTT_Q1[ARRAY_N];
    int16_t acc_NTT_Q1[ARRAY_N];

    int16_t poly1_NTT_Q2[ARRAY_N];
    int16_t poly2_NTT_Q2[ARRAY_N];
    int16_t acc_NTT_Q2[ARRAY_N];

    int16_t res_NTT[ARRAY_N];

// ================

    oldcount = hal_get_time();
    NTT_forward1(poly1_NTT_Q1, (uint16_t*)poly1_int16);
    NTT_forward1(poly2_NTT_Q1, (uint16_t*)poly2_int16);
    NTT_mul1(acc_NTT_Q1, poly1_NTT_Q1, poly2_NTT_Q1);
    NTT_inv1(acc_NTT_Q1);
    NTT_forward2(poly1_NTT_Q2, (uint16_t*)poly1_int16);
    NTT_forward2(poly2_NTT_Q2, (uint16_t*)poly2_int16);
    NTT_mul2(acc_NTT_Q2, poly1_NTT_Q2, poly2_NTT_Q2);
    NTT_inv2(acc_NTT_Q2);
    solv_CRT((uint16_t*)res_NTT, acc_NTT_Q1, acc_NTT_Q2);
    newcount = hal_get_time();
    sprintf(out, "polymul: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    NTT_forward1(poly1_NTT_Q1, (uint16_t*)poly1_int16);
    newcount = hal_get_time();
    sprintf(out, "16-bit NTT: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    NTT_mul1(acc_NTT_Q1, poly1_NTT_Q1, poly2_NTT_Q1);
    newcount = hal_get_time();
    sprintf(out, "mul: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    NTT_inv1(acc_NTT_Q1);
    newcount = hal_get_time();
    sprintf(out, "16-bit iNTT: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    solv_CRT((uint16_t*)res_NTT, acc_NTT_Q1, acc_NTT_Q2);
    newcount = hal_get_time();
    sprintf(out, "CRT: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================


}

