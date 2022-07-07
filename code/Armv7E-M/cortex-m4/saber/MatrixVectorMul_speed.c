
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

extern void __asm_poly_add_16(int16_t *des, int16_t *src1, int16_t *src2);
extern void __asm_poly_add_32(int32_t *des, int32_t *src1, int32_t *src2);

int main(void){

    hal_setup(CLOCK_BENCHMARK);


    hal_send_str("\n============ IGNORE OUTPUT BEFORE THIS LINE ============\n");

    int16_t A[SABER_L][SABER_L][SABER_N];
    int16_t s[SABER_L][SABER_N];

    int32_t A_NTT_Q1Q2[SABER_N];
    int32_t s_NTT_Q1Q2[SABER_L][SABER_N];
    int32_t acc_NTT_Q1Q2[SABER_L][SABER_N];

    int16_t buff[SABER_L][SABER_N];

    int16_t buff0_int16[SABER_N];
    int16_t buff1_int16[SABER_N];
    int16_t buff2_int16[SABER_N];

    int32_t *buff01_int32 = (int32_t*)buff0_int16;


// ================

    oldcount = hal_get_time();
    for(size_t i = 0; i < SABER_L; i++){
        NTT_forward_32(s_NTT_Q1Q2[i], (uint16_t*)s[i]);
    }
    for(size_t i = 0; i < SABER_L; i++){
        for(size_t j = 0; j < SABER_L; j++){
            NTT_forward_32(A_NTT_Q1Q2, (uint16_t*)A[i][j]);
            if(j == 0){
                NTT_mul_32(acc_NTT_Q1Q2[i], A_NTT_Q1Q2, s_NTT_Q1Q2[j]);
            }else{
                NTT_mul_acc_32(acc_NTT_Q1Q2[i], A_NTT_Q1Q2, s_NTT_Q1Q2[j]);
            }
        }
        NTT_inv_32((uint16_t*)buff[i], acc_NTT_Q1Q2[i]);
    }
    newcount = hal_get_time();
    sprintf(out, "MatrixVectorMul (Enc, A): %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    for(size_t i = 0; i < SABER_L; i++){
        NTT_forward_32(s_NTT_Q1Q2[i], (uint16_t*)s[i]);
    }
    for(size_t i = 0; i < SABER_L; i++){
        for(size_t j = 0; j < SABER_L; j++){
            NTT_forward_32(A_NTT_Q1Q2, (uint16_t*)A[i][j]);
            NTT_mul_32(acc_NTT_Q1Q2[0], A_NTT_Q1Q2, s_NTT_Q1Q2[j]);
            if(j == 0){
                NTT_inv_32((uint16_t*)buff[i], acc_NTT_Q1Q2[0]);
            }else{
                NTT_inv_32((uint16_t*)buff0_int16, acc_NTT_Q1Q2[0]);
                __asm_poly_add_16(buff[i], buff[i], buff0_int16);
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
            NTT_forward_32(A_NTT_Q1Q2, (uint16_t*)A[i][j]);
            NTT_forward_32(s_NTT_Q1Q2[0], (uint16_t*)s[j]);
            if(j == 0){
                NTT_mul_32(acc_NTT_Q1Q2[i], A_NTT_Q1Q2, s_NTT_Q1Q2[0]);
            }else{
                NTT_mul_acc_32(acc_NTT_Q1Q2[i], A_NTT_Q1Q2, s_NTT_Q1Q2[0]);
            }
        }
        NTT_inv_32((uint16_t*)buff[i], acc_NTT_Q1Q2[i]);
    }
    newcount = hal_get_time();

    sprintf(out, "MatrixVectorMul (Enc, C): %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================

    oldcount = hal_get_time();
    for(size_t i = 0; i < SABER_L; i++){
        for(size_t j = 0; j < SABER_L; j++){
            NTT_forward_32(buff01_int32, (uint16_t*)A[i][j]);
            NTT_forward2(buff2_int16, (uint16_t*)s[j]);
            NTT_mul_32x16_2(buff2_int16, buff01_int32, buff2_int16);
            MOD_1(buff0_int16, buff01_int32);
            NTT_forward1(buff1_int16, (uint16_t*)s[j]);
            NTT_mul_16_1(buff1_int16, buff0_int16, buff1_int16);
            solv_CRT(buff01_int32, buff1_int16, buff2_int16);
            if(j == 0){
                NTT_inv_32((uint16_t*)buff[i], buff01_int32);
            }else{
                NTT_inv_32((uint16_t*)buff2_int16, buff01_int32);
                __asm_poly_add_16(buff[i], buff[i], buff2_int16);
            }
        }
    }
    newcount = hal_get_time();
    sprintf(out, "MatrixVectorMul (Enc, D): %lld cycles\n", newcount - oldcount);
    hal_send_str(out);

// ================



}

