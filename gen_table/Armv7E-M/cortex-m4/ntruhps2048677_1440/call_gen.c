
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
-646701, -646701, 717391, -646701, -646701, 717391, -646701, 717391, 412895, -1271838, 717391, 412895, -1271838, -495760, 105904, -390952, 988269, 412895, -495760, 105904, 738084, 70287, 635657, 1265421, -1271838, -390952, 988269, -26813, -746429, -481666, -53105
};

static const int32_t mul_Rmod_table_Q1[NTT_N >> 1] = {
-646701, 717391, 412895, -1271838, -495760, 105904, -390952, 988269, 738084, 70287, 635657, 1265421, -26813, -746429, -481666, -53105
};

static const int32_t streamlined_inv_CT_table_Q1[NTT_N - 1] = {
-646701, -646701, -717391, -646701, -646701, -717391, -646701, 1271838, -717391, -412895, 1271838, -988269, 390952, 53105, 746429, 481666, 26813, -717391, 1271838, -412895, -988269, -105904, 390952, 495760, -412895, -105904, 495760, -1265421, -70287, -635657, -738084
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


























