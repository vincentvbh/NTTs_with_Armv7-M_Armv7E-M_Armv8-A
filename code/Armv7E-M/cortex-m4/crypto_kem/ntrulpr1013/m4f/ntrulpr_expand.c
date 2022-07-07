
#include "params.h"
#include "poly_type.h"
#include "poly_arith.h"
#include "randomness.h"

#include "hash.h"
#include "aes.h"
#include "aes-publicinputs.h"

#include "ntrulpr_core.h"
#include "ntrulpr_expand.h"
#include "poly_encode_decode.h"

/* ----- encoding I-bit inputs */

void Inputs_encode(unsigned char *s,const Inputs r)
{
  int i;
  for (i = 0;i < Inputs_bytes;++i) s[i] = 0;
  for (i = 0;i < I;++i) s[i>>3] |= r[i]<<(i&7);
}

/* ----- Expand */

void Expand(uint32 *L,const unsigned char *k)
{
  aes256ctx ctx;
  aes256_ctr_keyexp(&ctx, k);
  aes256_ctr((unsigned char *) L, 4*p, aes_nonce, &ctx);
}

void Expand_publicinputs(uint32 *L,const unsigned char *k)
{
  aes256ctx_publicinputs ctx;
  aes256_ctr_keyexp_publicinputs(&ctx, k);
  aes256_ctr_publicinputs((unsigned char *) L, 4*p, aes_nonce, &ctx);
}

/* ----- Seeds */

#define Seeds_bytes 32

void Seeds_random(unsigned char *s)
{
  randombytes(s,Seeds_bytes);
}

/* ----- Generator, HashShort */

/* G = Generator(k) */
void Generator_publicinputs(Fq *G,const unsigned char *k)
{
  uint32 L[POLY_N];
  int i;

  Expand_publicinputs(L,k);
  for (i = 0;i < p;++i) G[i] = uint32_mod_uint14(L[i],q)-q12;
}

/* out = HashShort(r) */
void HashShort(small *out,const Inputs r)
{
  unsigned char s[Inputs_bytes];
  unsigned char h[Hash_bytes];
  uint32 L[POLY_N];

  Inputs_encode(s,r);
  Hash(h,5,s,sizeof s);
  Expand(L,h);
  Short_fromlist(out,L);
}

/* ----- NTRU LPRime Expand */

/* (S,A),a = XKeyGen() */
void XKeyGen(unsigned char *S,Fq *A,small *a)
{
  Fq G[POLY_N];

  Seeds_random(S);
  Generator_publicinputs(G,S);
  KeyGen(A,a,G);
}

/* B,T = XEncrypt(r,(S,A)) */
void XEncrypt(Fq *B,int8 *T,const int8 *r,const unsigned char *S, Fq *A)
{
  Fq G[POLY_N];
  small b[POLY_N];

  Generator_publicinputs(G,S);
  HashShort(b,r);
  Encrypt(B,T,r,G,A,b);
}

#define XDecrypt Decrypt

/* ----- NTRU LPRime Expand plus encoding */

void Inputs_random(Inputs r){

  unsigned char s[Inputs_bytes];
  int i;

  randombytes(s,sizeof s);
  for (i = 0;i < I;++i) r[i] = 1&(s[i>>3]>>(i&7));

}

/* pk,sk = ZKeyGen() */
void ZKeyGen(unsigned char *pk,unsigned char *sk){

  Fq A[POLY_N];
  small a[POLY_N];

  XKeyGen(pk,A,a); pk += Seeds_bytes;
  Rounded_encode(pk,A);
  Small_encode(sk,a);

}

/* c = ZEncrypt(r,pk) */
void ZEncrypt(unsigned char *c,const Inputs r,const unsigned char *pk){

  Fq A[POLY_N];
  Fq B[POLY_N];
  int8 T[I];

  Rounded_decode(A,pk+Seeds_bytes);
  XEncrypt(B,T,r,pk,A);
  Rounded_encode(c,B); c += Rounded_bytes;
  Top_encode(c,T);

}

/* r = ZDecrypt(C,sk) */
void ZDecrypt(Inputs r,const unsigned char *c,const unsigned char *sk){

  small a[POLY_N];
  Fq B[POLY_N];
  int8 T[I];

  Small_decode(a,sk);
  Rounded_decode(B,c);
  Top_decode(T,c+Rounded_bytes);
  XDecrypt(r,B,T,a);

}

