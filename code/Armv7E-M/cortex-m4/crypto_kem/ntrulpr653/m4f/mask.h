
#include "params.h"
#include "poly_type.h"

#ifdef LPR

int int16_negative_mask(int16 x);

#else

/* ----- masks */
/* return -1 if x!=0; else return 0 */
int int16_nonzero_mask(int16 x);
/* ----- small polynomials */
/* 0 if Weightw_is(r), else -1 */
int Weightw_mask(small *r);

#endif

