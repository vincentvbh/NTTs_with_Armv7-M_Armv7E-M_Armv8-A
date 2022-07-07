
#include "params.h"
#include "poly_type.h"
#include "randombytes.h"

#ifndef LPR
#include "cmsis.h"
#endif

/* ----- sorting to generate short polynomial */
extern void Short_fromlist_asm(small *out,const uint32 *in);
void Short_fromlist(small *out,const uint32 *in)
{
  Short_fromlist_asm(out, in);
}

/* ----- higher-level randomness */

uint32 urandom32(void)
{
  unsigned char c[4];
  uint32 out[4];

  randombytes(c,4);
  out[0] = (uint32)c[0];
  out[1] = ((uint32)c[1])<<8;
  out[2] = ((uint32)c[2])<<16;
  out[3] = ((uint32)c[3])<<24;
  return out[0]+out[1]+out[2]+out[3];
}

void Short_random(small *out)
{
  uint32 L[POLY_N];
  int i;

  for (i = 0;i < p;++i) L[i] = urandom32();
  Short_fromlist(out,L);
}

#ifndef LPR

void Small_random(small *out)
{
  int i;

  int *o1 = (int *)(void *)out;
  int x0, x1, x2, x3;
  int L[4];

  for (i = (p-1)/4; i>0; i--) {
    randombytes((unsigned char *)(void*)L, 16);
    x0 = L[0]; x1 = L[1]; x2 = L[2]; x3 = L[3];
    x0 = __BFC(x0, 30, 2); x0 = __SMMLA(x0, 12, -1);
    x1 = __BFC(x1, 30, 2); x1 = __SMMLA(x1, 12, -1);
    x2 = __BFC(x2, 30, 2); x2 = __SMMLA(x2, 12, -1);
    x3 = __BFC(x3, 30, 2); x3 = __SMMLA(x3, 12, -1);
    x0 = __BFI(x0, x1, 8, 8);
    x0 = __BFI(x0, x2, 16, 8);
    x0 = __BFI(x0, x3, 24, 8);
    *(o1++) = x0;
  }
  x0 = __BFC(urandom32(), 30, 2); x0 = __SMMLA(x0, 12, -1);
  out = (small *)(void *)o1;
  *out = x0;
}

#endif

