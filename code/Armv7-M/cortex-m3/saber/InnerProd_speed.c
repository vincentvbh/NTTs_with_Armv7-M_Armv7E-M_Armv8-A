
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

extern void __asm_poly_add(void*, void*, void*);

int main(void){

    hal_setup(CLOCK_BENCHMARK);


    hal_send_str("\n============ IGNORE OUTPUT BEFORE THIS LINE ============\n");

    int16_t b[SABER_L][SABER_N];
    int16_t s[SABER_L][SABER_N];

    int16_t b_NTT_Q1[SABER_N];
    int16_t s_NTT_Q1[SABER_L][SABER_N];
    int16_t acc_NTT_Q1[SABER_N];

    int16_t b_NTT_Q2[SABER_N];
    int16_t s_NTT_Q2[SABER_L][SABER_N];
    int16_t acc_NTT_Q2[SABER_N];

    int16_t buff[SABER_N];

    int16_t buff0_int16[SABER_N];
    int16_t buff1_int16[SABER_N];
    int16_t buff2_int16[SABER_N];

// ================

    oldcount = hal_get_time();
    for(size_t i = 0; i < SABER_L; i++){
        NTT_forward1(b_NTT_Q1, (uint16_t*)b[i]);
        NTT_forward2(b_NTT_Q2, (uint16_t*)b[i]);
        if(i == 0){
            NTT_mul1(acc_NTT_Q1, b_NTT_Q1, s_NTT_Q1[i]);
            NTT_mul2(acc_NTT_Q2, b_NTT_Q2, s_NTT_Q2[i]);
        }else{
            NTT_mul_acc1(acc_NTT_Q1, b_NTT_Q1, s_NTT_Q1[i]);
            NTT_mul_acc2(acc_NTT_Q2, b_NTT_Q2, s_NTT_Q2[i]);
        }
    }
    NTT_inv1(acc_NTT_Q1);
    NTT_inv2(acc_NTT_Q2);
    solv_CRT((uint16_t*)buff, acc_NTT_Q1, acc_NTT_Q2);
    newcount = hal_get_time();
    sprintf(out, "InnerProd (Enc, A): %lld cycles\n", newcount - oldcount);
    hal_send_str(out);


// ================

    oldcount = hal_get_time();
    for(size_t i = 0; i < SABER_L; i++){
        NTT_forward1(s_NTT_Q1[i], (uint16_t*)s[i]);
        NTT_forward2(s_NTT_Q2[i], (uint16_t*)s[i]);
    }
    for(size_t i = 0; i < SABER_L; i++){
        NTT_forward1(b_NTT_Q1, (uint16_t*)b[i]);
        NTT_forward2(b_NTT_Q2, (uint16_t*)b[i]);
        if(i == 0){
            NTT_mul1(acc_NTT_Q1, b_NTT_Q1, s_NTT_Q1[i]);
            NTT_mul2(acc_NTT_Q2, b_NTT_Q2, s_NTT_Q2[i]);
        }else{
            NTT_mul_acc1(acc_NTT_Q1, b_NTT_Q1, s_NTT_Q1[i]);
            NTT_mul_acc2(acc_NTT_Q2, b_NTT_Q2, s_NTT_Q2[i]);
        }
    }
    NTT_inv1(acc_NTT_Q1);
    NTT_inv2(acc_NTT_Q2);
    solv_CRT((uint16_t*)buff, acc_NTT_Q1, acc_NTT_Q2);
    newcount = hal_get_time();
    sprintf(out, "InnerProd (Dec, A): %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    for(size_t i = 0; i < SABER_L; i++){
        NTT_forward1(s_NTT_Q1[i], (uint16_t*)s[i]);
        NTT_forward2(s_NTT_Q2[i], (uint16_t*)s[i]);
    }
    for(size_t i = 0; i < SABER_L; i++){
        NTT_forward1(buff1_int16, (uint16_t*)b[i]);
        NTT_forward2(buff2_int16, (uint16_t*)b[i]);
        NTT_mul1(buff1_int16, buff1_int16, s_NTT_Q1[i]);
        NTT_inv1(buff1_int16);
        NTT_mul2(buff2_int16, buff2_int16, s_NTT_Q2[i]);
        NTT_inv2(buff2_int16);
        if(i == 0){
            solv_CRT((uint16_t*)buff, buff1_int16, buff2_int16);
        }else{
            solv_CRT((uint16_t*)buff0_int16, buff1_int16, buff2_int16);
            __asm_poly_add(buff, buff, buff0_int16);
        }
    }
    newcount = hal_get_time();
    sprintf(out, "InnerProd (Dec, B): %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    for(size_t i = 0; i < SABER_L; i++){
        NTT_forward1(b_NTT_Q1, (uint16_t*)b[i]);
        NTT_forward2(b_NTT_Q2, (uint16_t*)b[i]);
        NTT_forward1(s_NTT_Q1[0], (uint16_t*)s[i]);
        NTT_forward2(s_NTT_Q2[0], (uint16_t*)s[i]);
        if(i == 0){
            NTT_mul1(acc_NTT_Q1, b_NTT_Q1, s_NTT_Q1[0]);
            NTT_mul2(acc_NTT_Q2, b_NTT_Q2, s_NTT_Q2[0]);
        }else{
            NTT_mul_acc1(acc_NTT_Q1, b_NTT_Q1, s_NTT_Q1[0]);
            NTT_mul_acc2(acc_NTT_Q2, b_NTT_Q2, s_NTT_Q2[0]);
        }
    }
    NTT_inv1(acc_NTT_Q1);
    NTT_inv2(acc_NTT_Q2);
    solv_CRT((uint16_t*)buff, acc_NTT_Q1, acc_NTT_Q2);
    newcount = hal_get_time();
    sprintf(out, "InnerProd (Dec, C): %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    for(size_t i = 0; i < SABER_L; i++){
        NTT_forward1(buff0_int16, (uint16_t*)b[i]);
        NTT_forward1(buff2_int16, (uint16_t*)s[i]);
        NTT_mul1(buff1_int16, buff0_int16, buff2_int16);
        NTT_inv1(buff1_int16);
        NTT_forward2(buff0_int16, (uint16_t*)b[i]);
        NTT_forward2(buff2_int16, (uint16_t*)s[i]);
        NTT_mul2(buff2_int16, buff0_int16, buff2_int16);
        NTT_inv2(buff2_int16);
        if(i == 0){
            solv_CRT((uint16_t*)buff, buff1_int16, buff2_int16);
        }else{
            solv_CRT((uint16_t*)buff0_int16, buff1_int16, buff2_int16);
            __asm_poly_add(buff, buff, buff0_int16);
        }
    }
    newcount = hal_get_time();
    sprintf(out, "InnerProd (Dec, D): %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================



}

