
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

    int32_t poly1_NTT_Q1Q2[ARRAY_N];
    int32_t poly2_NTT_Q1Q2[ARRAY_N];
    int32_t res_NTT_Q1Q2[ARRAY_N];

    int16_t buff0_int16[ARRAY_N];
    int16_t buff1_int16[ARRAY_N];
    int16_t buff2_int16[ARRAY_N];

    int32_t *buff01_int32 = (int32_t*)buff0_int16;

    int16_t res_NTT[ARRAY_N];

// ================

    oldcount = hal_get_time();
    NTT_forward_32(poly1_NTT_Q1Q2, (uint16_t*)poly1_int16);
    NTT_forward_32(poly2_NTT_Q1Q2, (uint16_t*)poly2_int16);
    NTT_mul_32(res_NTT_Q1Q2, poly1_NTT_Q1Q2, poly2_NTT_Q1Q2);
    NTT_inv_32((uint16_t*)res_NTT, res_NTT_Q1Q2);
    newcount = hal_get_time();
    sprintf(out, "polymul: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    NTT_forward_32(buff01_int32, (uint16_t*)poly1_int16);
    NTT_forward2(buff2_int16, (uint16_t*)poly2_int16);
    NTT_mul_32x16_2(buff2_int16, buff01_int32, buff2_int16);
    MOD_1(buff0_int16, buff01_int32);
    NTT_forward1(buff1_int16, (uint16_t*)poly2_int16);
    NTT_mul_16_1(buff1_int16, buff0_int16, buff1_int16);
    solv_CRT(buff01_int32, buff1_int16, buff2_int16);
    NTT_inv_32((uint16_t*)res_NTT, buff01_int32);
    newcount = hal_get_time();
    sprintf(out, "polymul with 32-bit and 2x16-bit: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    NTT_forward_32(poly1_NTT_Q1Q2, (uint16_t*)poly1_int16);
    newcount = hal_get_time();
    sprintf(out, "32-bit NTT: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    NTT_forward1(buff1_int16, (uint16_t*)poly2_int16);
    newcount = hal_get_time();
    sprintf(out, "16-bit NTT: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    NTT_forward2(buff2_int16, (uint16_t*)poly2_int16);
    newcount = hal_get_time();
    sprintf(out, "16-bit light NTT: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    MOD_1(buff0_int16, buff01_int32);
    newcount = hal_get_time();
    sprintf(out, "32-bit to 16-bit: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    NTT_mul_32(res_NTT_Q1Q2, poly1_NTT_Q1Q2, poly2_NTT_Q1Q2);
    newcount = hal_get_time();
    sprintf(out, "32-bit base_mul: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    NTT_mul_16_1(buff1_int16, buff0_int16, buff1_int16);
    newcount = hal_get_time();
    sprintf(out, "16-bit base_mul: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    NTT_mul_32x16_2(buff2_int16, buff01_int32, buff2_int16);
    newcount = hal_get_time();
    sprintf(out, "32x16-bit base_mul: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    solv_CRT(buff01_int32, buff1_int16, buff2_int16);
    newcount = hal_get_time();
    sprintf(out, "CRT: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    NTT_inv_32((uint16_t*)res_NTT, buff01_int32);
    newcount = hal_get_time();
    sprintf(out, "32-bit iNTT: %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================




}
