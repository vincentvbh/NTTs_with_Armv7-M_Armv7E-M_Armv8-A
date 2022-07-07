
#include "params.h"
#include "hash.h"
#include "randomness.h"

#ifdef LPR
#include "aes.h"
#include "aes-publicinputs.h"
#endif

#include "poly_type.h"
#include "poly_arith.h"
#include "poly_encode_decode.h"
#include "mask.h"

#ifdef LPR
#include "ntrulpr_core.h"
#include "ntrulpr_expand.h"
#else
#include "sntrup_core.h"
#endif

/* ----- confirmation hash */

#define Confirm_bytes 32

/*************************************************
* Name:        HashConfirm
*
* Description: Computes hash_2 of r||cache, where cache is hash_4 of public-key
*
* Arguments:
* unsigned char *h           : pointer to the output hash
* const unsigned char *r     : pointer to the input byte array
* const unsigned char *cache : pointer to the input hash of public-key
**************************************************/
static void HashConfirm(unsigned char *h,const unsigned char *r,/*const unsigned char *pk,*/const unsigned char *cache)
{
#ifndef LPR
  unsigned char x[Hash_bytes*2];
  int i;

  Hash(x,3,r,Inputs_bytes);
  for (i = 0;i < Hash_bytes;++i) x[Hash_bytes+i] = cache[i];
#else
  unsigned char x[Inputs_bytes+Hash_bytes];
  int i;

  for (i = 0;i < Inputs_bytes;++i) x[i] = r[i];
  for (i = 0;i < Hash_bytes;++i) x[Inputs_bytes+i] = cache[i];
#endif
  Hash(h,2,x,sizeof x);
}

/* ----- session-key hash */

/* k = HashSession(b,y,z) */
/*************************************************
* Name:        HashSession
*
* Description: Generate session key
*
* Arguments:
* unsigned char *k       : pointer to the output session key
* int b                  : domain separetor
* const unsigned char *y : pointer to the input plaintext
* const unsigned char *z : pointer to the input ciphertext
**************************************************/
static void HashSession(unsigned char *k,int b,const unsigned char *y,const unsigned char *z)
{
#ifndef LPR
  unsigned char x[Hash_bytes+Ciphertexts_bytes+Confirm_bytes];
  int i;

  Hash(x,3,y,Inputs_bytes);
  for (i = 0;i < Ciphertexts_bytes+Confirm_bytes;++i) x[Hash_bytes+i] = z[i];
#else
  unsigned char x[Inputs_bytes+Ciphertexts_bytes+Confirm_bytes];
  int i;

  for (i = 0;i < Inputs_bytes;++i) x[i] = y[i];
  for (i = 0;i < Ciphertexts_bytes+Confirm_bytes;++i) x[Inputs_bytes+i] = z[i];
#endif
  Hash(k,b,x,sizeof x);
}

/* ----- Streamlined NTRU Prime and NTRU LPRime */

/*************************************************
* Name:        KEM_KeyGen
*
* Description: Key generation function for both Streamlined NTRU Prime
*              and NTRU LPRime
*
* Arguments:
* unsigned char *pk : pointer to the output public-key
* unsigned char *sk : pointer to the output secret-key
**************************************************/
static void KEM_KeyGen(unsigned char *pk,unsigned char *sk)
{
  int i;

  ZKeyGen(pk,sk); sk += SecretKeys_bytes;
  for (i = 0;i < PublicKeys_bytes;++i) *sk++ = pk[i];
  randombytes(sk,Inputs_bytes); sk += Inputs_bytes;
  Hash(sk,4,pk,PublicKeys_bytes);
}

/*************************************************
* Name:        Hide
*
* Description: Helper function for Encapsulation and decapsulation functions.
*              It computes ciphertext and HashConfirm for a given plaintext
*              and public-key
*
* Arguments:
* unsigned char *c           : pointer to the output ciphertext
* unsigned char *r_enc       : pointer to the output encoded plaintext
* const Inputs r             : pointer to the input plaintext
* const unsigned char *pk    : pointer to the input public-key
* const unsigned char *cache : pointer to the input hash of public-key
**************************************************/
static void Hide(unsigned char *c,unsigned char *r_enc, Inputs r,const unsigned char *pk,const unsigned char *cache)
{
  Inputs_encode(r_enc,r);
  ZEncrypt(c,r,pk); c += Ciphertexts_bytes;
  HashConfirm(c,r_enc,/*pk,*/cache);
}

/*************************************************
* Name:        Encap
*
* Description: Encapsulation function for both Streamlined NTRU Prime
*              and NTRU LPRime
*
* Arguments:
* unsigned char *c        : pointer to the output ciphertext
* unsigned char *k        : pointer to the output session key
* const unsigned char *pk : pointer to the input public-key
**************************************************/
static void Encap(unsigned char *c,unsigned char *k,const unsigned char *pk)
{
  Inputs r;
  unsigned char r_enc[Inputs_bytes];
  unsigned char cache[Hash_bytes];

  Hash(cache,4,pk,PublicKeys_bytes);
  Inputs_random(r);
  Hide(c,r_enc,r,pk,cache);
  HashSession(k,1,r_enc,c);
}

/* 0 if matching ciphertext+confirm, else -1 */
/*************************************************
* Name:        Ciphertexts_diff_mask
*
* Description: Returns 0 if ciphertexts and Confirm bytes, -1 otherwise
*
* Arguments:
* const unsigned char *c  : pointer to the input first ciphertext
* const unsigned char *c2 : pointer to the input second ciphertext
**************************************************/
static int Ciphertexts_diff_mask(const unsigned char *c,const unsigned char *c2)
{
  uint16 differentbits = 0;
  int len = Ciphertexts_bytes+Confirm_bytes;

  while (len-- > 0) differentbits |= (*c++)^(*c2++);
  return (1&((differentbits-1)>>8))-1;
}

/*************************************************
* Name:        Decap
*
* Description: Decapsulation function for both Streamlined NTRU Prime
*              and NTRU LPRime
*
* Arguments:
* unsigned char *k        : pointer to the output session key
* const unsigned char *c  : pointer to the input ciphertext
* const unsigned char *sk : pointer to the input secret-key
**************************************************/
static void Decap(unsigned char *k,const unsigned char *c,const unsigned char *sk)
{
  const unsigned char *pk = sk + SecretKeys_bytes;
  const unsigned char *rho = pk + PublicKeys_bytes;
  const unsigned char *cache = rho + Inputs_bytes;
  Inputs r;
  unsigned char r_enc[Inputs_bytes];
  unsigned char cnew[Ciphertexts_bytes+Confirm_bytes];
  int mask;
  int i;

  ZDecrypt(r,c,sk);
  Hide(cnew,r_enc,r,pk,cache);
  mask = Ciphertexts_diff_mask(c,cnew);
  for (i = 0;i < Inputs_bytes;++i) r_enc[i] ^= mask&(r_enc[i]^rho[i]);
  HashSession(k,1+mask,r_enc,c);
}

/* ----- crypto_kem API */

#include "api.h"

int crypto_kem_keypair(unsigned char *pk,unsigned char *sk)
{
  KEM_KeyGen(pk,sk);
  return 0;
}

int crypto_kem_enc(unsigned char *c,unsigned char *k,const unsigned char *pk)
{
  Encap(c,k,pk);
  return 0;
}

int crypto_kem_dec(unsigned char *k,const unsigned char *c,const unsigned char *sk)
{
  Decap(k,c,sk);
  return 0;
}
