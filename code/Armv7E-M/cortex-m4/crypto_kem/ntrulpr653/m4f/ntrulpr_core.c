
#include "poly_type.h"
#include "poly_arith.h"
#include "randomness.h"
#include "arith.h"
#include "mask.h"
#include "ntrulpr_core.h"

/* ----- NTRU LPRime Core */

/* (G,A),a = KeyGen(G); leaves G unchanged */
void KeyGen(Fq *A, small *a, Fq *G)
{
  Fq aG[POLY_N];

  Short_random(a);
  Rq_mult_small(aG,G,a);
  Round(A,aG);
}

/* B,T = Encrypt(r,(G,A),b) */
void Encrypt(Fq *B, int8 *T, const int8 *r, Fq *G, Fq *A, small *b)
{
  Fq bG[POLY_N];
  Fq bA[POLY_N];
  int i;

  Rq_mult_twice(bG, bA, G, A, b);

  Round(B,bG);
  for (i = 0;i < I;++i) T[i] = Top(Fq_freeze(bA[i]+r[i]*q12));
}

/* r = Decrypt((B,T),a) */
void Decrypt(int8 *r, Fq *B, const int8 *T, small *a)
{
  Fq aB[POLY_N];
  int i;

  Rq_mult_small(aB,B,a);
  for (i = 0;i < I;++i)
    r[i] = -int16_negative_mask(Fq_freeze(Right(T[i])-aB[i]+4*w+1));
}

