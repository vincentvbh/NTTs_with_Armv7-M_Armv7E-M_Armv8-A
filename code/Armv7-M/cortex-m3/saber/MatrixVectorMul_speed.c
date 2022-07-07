
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

    int16_t A[SABER_L][SABER_L][SABER_N];
    int16_t s[SABER_L][SABER_N];

    int16_t A_NTT_Q1[SABER_N];
    int16_t s_NTT_Q1[SABER_L][SABER_N];
    int16_t acc_NTT_Q1[SABER_L][SABER_N];

    int16_t A_NTT_Q2[SABER_N];
    int16_t s_NTT_Q2[SABER_L][SABER_N];
    int16_t acc_NTT_Q2[SABER_L][SABER_N];

    int16_t buff[SABER_L][SABER_N];

    int16_t buff0_int16[SABER_N];
    int16_t buff1_int16[SABER_N];
    int16_t buff2_int16[SABER_N];

// ================

    oldcount = hal_get_time();
    for(size_t i = 0; i < SABER_L; i++){
        NTT_forward1(s_NTT_Q1[i], (uint16_t*)s[i]);
        NTT_forward2(s_NTT_Q2[i], (uint16_t*)s[i]);
    }
    for(size_t i = 0; i < SABER_L; i++){
        for(size_t j = 0; j < SABER_L; j++){
            NTT_forward1(A_NTT_Q1, (uint16_t*)A[i][j]);
            NTT_forward2(A_NTT_Q2, (uint16_t*)A[i][j]);
            if(j == 0){
                NTT_mul1(acc_NTT_Q1[i], A_NTT_Q1, s_NTT_Q1[j]);
                NTT_mul2(acc_NTT_Q2[i], A_NTT_Q2, s_NTT_Q2[j]);
            }else{
                NTT_mul_acc1(acc_NTT_Q1[i], A_NTT_Q1, s_NTT_Q1[j]);
                NTT_mul_acc2(acc_NTT_Q2[i], A_NTT_Q2, s_NTT_Q2[j]);
            }
        }
        NTT_inv1(acc_NTT_Q1[i]);
        NTT_inv2(acc_NTT_Q2[i]);
        solv_CRT((uint16_t*)buff[i], acc_NTT_Q1[i], acc_NTT_Q2[i]);
    }
    newcount = hal_get_time();
    sprintf(out, "MatrixVectorMul (Enc, A): %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    for(size_t i = 0; i < SABER_L; i++){
        NTT_forward1(s_NTT_Q1[i], (uint16_t*)s[i]);
        NTT_forward2(s_NTT_Q2[i], (uint16_t*)s[i]);
    }
    for(size_t i = 0; i < SABER_L; i++){
        for(size_t j = 0; j < SABER_L; j++){
            NTT_forward1(A_NTT_Q1, (uint16_t*)A[i][j]);
            NTT_forward2(A_NTT_Q2, (uint16_t*)A[i][j]);
            NTT_mul1(buff1_int16, A_NTT_Q1, s_NTT_Q1[j]);
            NTT_mul2(buff2_int16, A_NTT_Q2, s_NTT_Q2[j]);
            NTT_inv1(buff1_int16);
            NTT_inv2(buff2_int16);
            if(j == 0){
                solv_CRT((uint16_t*)buff[i], buff1_int16, buff2_int16);
            }else{
                solv_CRT((uint16_t*)buff0_int16, buff1_int16, buff2_int16);
                __asm_poly_add(buff[i], buff[i], buff0_int16);
            }
        }
    }
    newcount = hal_get_time();
    sprintf(out, "MatrixVectorMul (Enc, B): %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    for(size_t i = 0; i < SABER_L; i++){
        for(size_t j = 0; j < SABER_L; j++){
            NTT_forward1(A_NTT_Q1, (uint16_t*)A[i][j]);
            NTT_forward2(A_NTT_Q2, (uint16_t*)A[i][j]);
            NTT_forward1(s_NTT_Q1[0], (uint16_t*)s[j]);
            NTT_forward2(s_NTT_Q2[0], (uint16_t*)s[j]);
            if(j == 0){
                NTT_mul1(acc_NTT_Q1[i], A_NTT_Q1, s_NTT_Q1[0]);
                NTT_mul2(acc_NTT_Q2[i], A_NTT_Q2, s_NTT_Q2[0]);
            }else{
                NTT_mul_acc1(acc_NTT_Q1[i], A_NTT_Q1, s_NTT_Q1[0]);
                NTT_mul_acc2(acc_NTT_Q2[i], A_NTT_Q2, s_NTT_Q2[0]);
            }
        }
        NTT_inv1(acc_NTT_Q1[i]);
        NTT_inv2(acc_NTT_Q2[i]);
        solv_CRT((uint16_t*)buff[i], acc_NTT_Q1[i], acc_NTT_Q2[i]);
    }
    newcount = hal_get_time();
    sprintf(out, "MatrixVectorMul (Enc, C): %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    for(size_t i = 0; i < SABER_L; i++){
        for(size_t j = 0; j < SABER_L; j++){
            NTT_forward1(buff0_int16, (uint16_t*)A[i][j]);
            NTT_forward1(buff2_int16, (uint16_t*)s[j]);
            NTT_mul1(buff1_int16, buff0_int16, buff2_int16);
            NTT_inv1(buff1_int16);
            NTT_forward2(buff0_int16, (uint16_t*)A[i][j]);
            NTT_forward2(buff2_int16, (uint16_t*)s[j]);
            NTT_mul2(buff2_int16, buff0_int16, buff2_int16);
            NTT_inv2(buff2_int16);
            if(j == 0){
                solv_CRT((uint16_t*)buff[i], buff1_int16, buff2_int16);
            }else{
                solv_CRT((uint16_t*)buff0_int16, buff1_int16, buff2_int16);
                __asm_poly_add(buff[i], buff[i], buff0_int16);
            }
        }
    }
    newcount = hal_get_time();
    sprintf(out, "MatrixVectorMul (Enc, D): %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================



}

