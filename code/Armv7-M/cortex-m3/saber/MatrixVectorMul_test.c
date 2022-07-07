
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

    hal_setup(CLOCK_FAST);


    hal_send_str("\n============ IGNORE OUTPUT BEFORE THIS LINE ============\n");

    int16_t A[SABER_L][SABER_L][SABER_N];
    int16_t s[SABER_L][SABER_N];
    int16_t acc[SABER_L][SABER_N];

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


    int16_t tmp_int16;
    int16_t twiddle_int16;
    int16_t mod_int16;

// ================

    for(size_t i = 0; i < SABER_L; i++){
        for(size_t j = 0; j < SABER_L; j++){
            for(size_t k = 0; k < SABER_N; k++){
                tmp_int16 = rand() % SABER_Q;
                A[i][j][k] = tmp_int16 - (SABER_Q >> 1);
            }
        }
    }

    for(size_t i = 0; i < SABER_L; i++){
        for(size_t j = 0; j < SABER_N; j++){
            tmp_int16 = rand() % SABER_MU;
            s[i][j] = tmp_int16 - (SABER_MU >> 1);
        }
    }

    mod_int16 = SABER_Q;
    twiddle_int16 = -1;
    for(size_t i = 0; i < SABER_L; i++){
        for(size_t j = 0; j < SABER_L; j++){
            if(j == 0){
                naive_mulR(acc[i], A[i][j], s[j],
                    ARRAY_N, &twiddle_int16, &mod_int16,
                    sizeof(int16_t), addmod_int16, mulmod_int16);
            }else{
                naive_mulR(buff[i], A[i][j], s[j],
                    ARRAY_N, &twiddle_int16, &mod_int16,
                    sizeof(int16_t), addmod_int16, mulmod_int16);
                for(size_t k = 0; k < SABER_N; k++){
                    addmod_int16(&acc[i][k], &acc[i][k], &buff[i][k], &mod_int16);
                }
            }
        }
    }

    sprintf(out, "start\n");
    hal_send_str(out);

// ================

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

    mod_int16 = SABER_Q;
    for(size_t i = 0; i < SABER_L; i++){
        for(size_t j = 0; j < SABER_N; j++){
            cmod_int16(&tmp_int16, &buff[i][j], &mod_int16);
            assert(acc[i][j] == tmp_int16);
        }
    }

    sprintf(out, "MatrixVectorMul (Enc, A) passed!\n");
    hal_send_str(out);

// ================

    for(size_t i = 0; i < SABER_L; i++){
        NTT_forward1(s_NTT_Q1[i], (uint16_t*)s[i]);
        NTT_forward2(s_NTT_Q2[i], (uint16_t*)s[i]);
    }
    for(size_t i = 0; i < SABER_L; i++){
        for(size_t j = 0; j < SABER_L; j++){
            NTT_forward1(buff1_int16, (uint16_t*)A[i][j]);
            NTT_forward2(buff2_int16, (uint16_t*)A[i][j]);
            NTT_mul1(buff1_int16, buff1_int16, s_NTT_Q1[j]);
            NTT_mul2(buff2_int16, buff2_int16, s_NTT_Q2[j]);
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

    mod_int16 = SABER_Q;
    for(size_t i = 0; i < SABER_L; i++){
        for(size_t j = 0; j < SABER_N; j++){
            cmod_int16(&tmp_int16, &buff[i][j], &mod_int16);
            assert(acc[i][j] == tmp_int16);
        }
    }

    sprintf(out, "MatrixVectorMul (Enc, B) passed!\n");
    hal_send_str(out);

// ================

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

    mod_int16 = SABER_Q;
    for(size_t i = 0; i < SABER_L; i++){
        for(size_t j = 0; j < SABER_N; j++){
            cmod_int16(&tmp_int16, &buff[i][j], &mod_int16);
            assert(acc[i][j] == tmp_int16);
        }
    }

    sprintf(out, "MatrixVectorMul (Enc, C) passed!\n");
    hal_send_str(out);

// ================

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

    mod_int16 = SABER_Q;
    for(size_t i = 0; i < SABER_L; i++){
        for(size_t j = 0; j < SABER_N; j++){
            cmod_int16(&tmp_int16, &buff[i][j], &mod_int16);
            assert(acc[i][j] == tmp_int16);
        }
    }

    sprintf(out, "MatrixVectorMul (Enc, D) passed!\n");
    hal_send_str(out);

// ================



}

