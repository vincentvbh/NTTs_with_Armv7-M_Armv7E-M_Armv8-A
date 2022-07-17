#ifndef POLY_ENCODE_DECODE_H
#define POLY_ENCODE_DECODE_H

#include "params.h"
#include "Encode.h"
#include "Decode.h"
#include "poly_type.h"

/* ----- encoding small polynomials (including short polynomials) */

#define Small_bytes ((p+3)/4)

/* these are the only functions that rely on p mod 4 = 1 */
void Small_encode(unsigned char *s, const small *f);
void Small_decode(small *f, const unsigned char *s);

/* ----- encoding rounded polynomials */

static inline void Rounded_encode(unsigned char *s, const Fq *r){
  Encode_Rounded_asm(s, (int16 *)r);
}

static inline void Rounded_decode(Fq *r, const unsigned char *s){
  Decode_Rounded_asm((int16 *)r, s);
}

/* ----- encoding top polynomials */

#ifdef LPR

#define Top_bytes (I/2)

void Top_encode(unsigned char *s, const int8 *T);
void Top_decode(int8 *T, const unsigned char *s);

#else

static inline void Rq_encode(unsigned char *s, const Fq *r){
  Encode_Rq_asm(s, (int16 *)r);
}

static inline void Rq_decode(Fq *r, const unsigned char *s){
  Decode_Rq_asm((int16 *)r, s);
}

#endif



#endif


