
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
-695350, -695350, 5428110, -695350, -695350, 5428110, -695350, 5428110, 2879314, 4812619, 5428110, 2879314, 4812619, 2252403, -934199, -2620540, -2967330, 2879314, 2252403, -934199, -2986825, -11370, -5549095, -2335132, 4812619, -2620540, -2967330, -1224724, 4995672, -3245977, 30655
};

static const int32_t mul_Rmod_table_Q1[NTT_N >> 1] = {
-695350, 5428110, 2879314, 4812619, 2252403, -934199, -2620540, -2967330, -2986825, -11370, -5549095, -2335132, -1224724, 4995672, -3245977, 30655
};

static const int32_t streamlined_inv_CT_table_Q1[NTT_N - 1] = {
-695350, -695350, -5428110, -695350, -695350, -5428110, -695350, -4812619, -5428110, -2879314, -4812619, 2967330, 2620540, -30655, -4995672, 3245977, 1224724, -5428110, -4812619, -2879314, 2967330, 934199, 2620540, -2252403, -2879314, 934199, -2252403, 2335132, 11370, 5549095, 2986825
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


























