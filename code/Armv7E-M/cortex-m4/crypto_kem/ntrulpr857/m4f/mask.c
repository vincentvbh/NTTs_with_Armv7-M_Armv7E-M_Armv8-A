
#include "mask.h"

#ifdef LPR

/*************************************************
* Name:        int16_negative_mask
*
* Description: Return -1 if is input is a negative integer, 0 otherwise.
*
* Argument:
* int16 x : input coefficient
**************************************************/
int int16_negative_mask(int16 x)
{
  uint16 u = x;
  u >>= 15;
  return -(int) u;
  /* alternative with gcc -fwrapv: */
  /* x>>15 compiles to CPU's arithmetic right shift */
}

#else

/* ----- masks */

/* return -1 if x!=0; else return 0 */
int int16_nonzero_mask(int16 x)
{
  uint16 u = x; /* 0, else 1...65535 */
  uint32 v = u; /* 0, else 1...65535 */
  v = -v; /* 0, else 2^32-65535...2^32-1 */
  v >>= 31; /* 0, else 1 */
  return -v; /* 0, else -1 */
}

/* ----- small polynomials */

/* 0 if Weightw_is(r), else -1 */
int Weightw_mask(small *r)
{
  int weight = 0;
  int i;

  for (i = 0;i < p;++i) weight += r[i]&1;
  return int16_nonzero_mask(weight-w);
}

#endif









