#ifndef NTRULPR_CORE_H
#define NTRULPR_CORE_H

#include "poly_type.h"

/* (G,A),a = KeyGen(G); leaves G unchanged */
void KeyGen(Fq *A, small *a, Fq *G);

/* B,T = Encrypt(r,(G,A),b) */
void Encrypt(Fq *B, int8 *T, const int8 *r, Fq *G, Fq *A, small *b);

/* r = Decrypt((B,T),a) */
void Decrypt(int8 *r, Fq *B, const int8 *T, small *a);


#endif



