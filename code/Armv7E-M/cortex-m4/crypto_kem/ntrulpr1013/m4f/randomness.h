#ifndef RANDOMNESS_H
#define RANDOMNESS_H

#include "randombytes.h"
#include "poly_type.h"

void Short_fromlist(small *out,const uint32 *in);

/* ----- higher-level randomness */
uint32 urandom32(void);
void Short_random(small *out);

#ifndef LPR

void Small_random(small *out);

#endif



#endif


