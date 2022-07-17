
#include "poly_type.h"
#include "poly_arith.h"
#include "randomness.h"
#include "mask.h"
#include "poly_encode_decode.h"
#include "sntrup_core.h"

/* ----- Streamlined NTRU Prime Core */

/* h,(f,ginv) = KeyGen() */
void KeyGen(Fq *h, small *f, small *ginv)
{
  small g[POLY_N];
  Fq finv[POLY_N];

  for (;;) {
    Small_random(g);
    if (R3_recip_jumpdivsteps(ginv,g) == 0) break;
  }
  Short_random(f);
  Rq_recip3_jumpdivsteps(finv,f); /* always works */
  Rq_mult_small(h,finv,g);
}

/* c = Encrypt(r,h) */
void Encrypt(Fq *c, small *r, Fq *h)
{
  Fq hr[POLY_N];

  Rq_mult_small(hr,h,r);
  Round(c,hr);
}

/* r = Decrypt(c,(f,ginv)) */
void Decrypt(small *r, Fq *c, small *f, const small *ginv)
{
  Fq cf[POLY_N];
  Fq cf3[POLY_N];
  small e[POLY_N];
  small ev[POLY_N];
  int mask;
  int i;

  Rq_mult_small(cf,c,f);
  Rq_mult3(cf3,cf);
  R3_fromRq(e,cf3);
  R3_mult(ev,e,ginv);

  mask = Weightw_mask(ev); /* 0 if weight w, else -1 */
  for (i = 0;i < w;++i) r[i] = ((ev[i]^1)&~mask)^1;
  for (i = w;i < p;++i) r[i] = ev[i]&~mask;
}

/* ----- Streamlined NTRU Prime Core plus encoding */

/* pk,sk = ZKeyGen() */
void ZKeyGen(unsigned char *pk,unsigned char *sk){

  Fq h[POLY_N];
  small f[POLY_N],v[POLY_N];

  KeyGen(h,f,v);
  Rq_encode(pk,h);
  Small_encode(sk,f); sk += Small_bytes;
  Small_encode(sk,v);

}

/* C = ZEncrypt(r,pk) */
void ZEncrypt(unsigned char *C, Inputs r,const unsigned char *pk){

  Fq h[POLY_N];
  Fq c[POLY_N];
  Rq_decode(h,pk);
  Encrypt(c,r,h);
  Rounded_encode(C,c);

}

/* r = ZDecrypt(C,sk) */
void ZDecrypt(Inputs r,const unsigned char *C,const unsigned char *sk){

  small f[POLY_N],v[POLY_N];
  Fq c[POLY_N];

  Small_decode(f,sk); sk += Small_bytes;
  Small_decode(v,sk);
  Rounded_decode(c,C);
  Decrypt(r,c,f,v);

}


