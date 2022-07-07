#ifndef POLY_ARITH_H
#define POLY_ARITH_H

#include "params.h"
#include "arith.h"

#include "poly_type.h"
#include "NTT_params.h"


#define q12 ((q-1)/2)

void Round(Fq *out,const Fq *a);
void Rq_mult_small(Fq *h, Fq *f, small *g);

#ifdef LPR

#define tau 16

int8 Top(Fq C);
Fq Right(int8 T);
void Rq_mult_twice(Fq *bG, Fq *bA, Fq *G, Fq *A, small *b);

#else

extern int R3_recip_jumpdivsteps(int8* H, int8* G);
extern int Rq_recip3_jumpdivsteps(int16* H, int8* G);
void R3_fromRq(small *out,const Fq *r);
void R3_mult(small *h,const small *f,const small *g);
void Rq_mult3(Fq *h,const Fq *f);

#endif

#endif


