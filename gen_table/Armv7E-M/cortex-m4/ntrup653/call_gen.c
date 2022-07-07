
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <assert.h>

#include "NTT_params.h"

#include "tools.h"
#include "gen_table.h"

#define BUFF_MAX (NTT_N << 4)

struct compress_profile profile;

static const int32_t streamlined_CT_table_Q1[NTT_N - 1] = {
1299000, 1299000, 1669299, 1299000, 1299000, 1669299, 1299000, 1669299, 665907, 745612, 1669299, 665907, 745612, -858332, -764138, 349325, -1839665, 665907, -858332, -764138, 1147734, 2481368, -2766145, 2157454, 745612, 349325, -1839665, -1260982, 2557435, -644663, -248189
};

static const int32_t mul_Rmod_table_Q1[NTT_N >> 1] = {
1299000, 1669299, 665907, 745612, -858332, -764138, 349325, -1839665, 1147734, 2481368, -2766145, 2157454, -1260982, 2557435, -644663, -248189
};

static const int32_t streamlined_inv_CT_table_Q1[NTT_N - 1] = {
1299000, 1299000, -1669299, 1299000, 1299000, -1669299, 1299000, -745612, -1669299, -665907, -745612, 1839665, -349325, 248189, -2557435, 644663, 1260982, -1669299, -745612, -665907, 1839665, 764138, -349325, 858332, -665907, 764138, 858332, -2157454, -2481368, 2766145, -1147734
};

int main(void){

// ================================

    int32_t mod_int32;
    int32_t omega_int32;
    int32_t scale_int32;

    int32_t buff[BUFF_MAX];

// ================================

    profile.compressed_layers = 3;
    profile.merged_layers[0] = 1;
    profile.merged_layers[1] = 1;
    profile.merged_layers[2] = 3;

    scale_int32 = RmodQ1;
    omega_int32 = omegaQ1;
    mod_int32 = Q1;
    gen_streamlined_CT_table_generic(
        buff,
        &scale_int32, &omega_int32,
        &mod_int32,
        sizeof(int32_t),
        mulmod_int32,
        &profile, 0
    );

    for(size_t i = 0; i < (NTT_N - 1); i++){
        assert(buff[i] == streamlined_CT_table_Q1[i]);
    }

// ================

    scale_int32 = RmodQ1;
    omega_int32 = omegaQ1;
    mod_int32 = Q1;
    gen_mul_table_generic(
        buff,
        &scale_int32, &omega_int32,
        &mod_int32,
        sizeof(int32_t),
        mulmod_int32
    );

    for(size_t i = 0; i < (NTT_N >> 1); i++){
        assert(buff[i] == mul_Rmod_table_Q1[i]);
    }

// ================

    scale_int32 = RmodQ1;
    omega_int32 = invomegaQ1;
    mod_int32 = Q1;
    gen_streamlined_inv_CT_table_generic(
        buff,
        &scale_int32, &omega_int32,
        &mod_int32,
        sizeof(int32_t),
        mulmod_int32,
        expmod_int32,
        &profile, 0
    );

    for(size_t i = 0; i < (NTT_N - 1); i++){
        assert(buff[i] == streamlined_inv_CT_table_Q1[i]);
    }

// ================================

    printf("Well done!\n");


}


























