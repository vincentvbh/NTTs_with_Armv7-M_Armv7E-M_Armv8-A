

#include <stddef.h>

#include "NTT_params.h"
#include "NTT.h"

#include "Rq_mult.h"

/*************************************************
* Name:        Rq_mult_small
*
* Description: Computes polynomial multiplication in Z_q/(X^p-X-1)
*              with selected implementation.
*
* Arguments:
* Fq *h          : pointer to the output polynomial in R_q
* const Fq *f    : pointer to the input polynomial in R_q
* const small *g : pointer to the input polynomial in R_q
**************************************************/
void Rq_mult_small(Fq *h, Fq *f, small *g)
{

  int32_t poly1_NTT[ARRAY_N];
  int32_t poly2_NTT[ARRAY_N];

  for(size_t i = NTRU_N; i < POLY_N; i++){
    f[i] = 0;
    g[i] = 0;
  }

  NTT_forward(poly1_NTT, f);
  NTT_forward_small(poly2_NTT, g);
  NTT_mul(poly1_NTT, poly1_NTT, poly2_NTT);
  NTT_inv(h, poly1_NTT);

}

/*************************************************
* Name:        Rq_mult_twice
*
* Description: Computes two polynomial multiplications in Z_q/(X^p-X-1)
*              with selected implementation.
*
* Arguments:
* Fq *bG          : pointer to the output polynomial in R_q
* Fq *bA          : pointer to the output polynomial in R_q
* const Fq *G    : pointer to the input polynomial in R_q
* const Fq *A    : pointer to the input polynomial in R_q
* const small *b : pointer to the input polynomial in R_q
**************************************************/
void Rq_mult_twice(Fq *bG, Fq *bA, Fq *G, Fq *A, small *b){

  int32_t poly1_NTT[ARRAY_N];
  int32_t poly2_NTT[ARRAY_N];

  for(size_t i = NTRU_N; i < POLY_N; i++){
    G[i] = 0;
    A[i] = 0;
    b[i] = 0;
  }

  NTT_forward_small(poly2_NTT, b);
  NTT_forward(poly1_NTT, G);
  NTT_mul(poly1_NTT, poly1_NTT, poly2_NTT);
  NTT_inv(bG, poly1_NTT);
  NTT_forward(poly1_NTT, A);
  NTT_mul(poly1_NTT, poly1_NTT, poly2_NTT);
  NTT_inv(bA, poly1_NTT);

}
