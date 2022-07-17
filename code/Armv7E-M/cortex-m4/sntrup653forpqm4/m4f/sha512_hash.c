/*
20080913
D. J. Bernstein
Public domain.
*/

#include <stdint.h>

#include "sha512_hash.h"

#ifdef PROFILE_HASHING
#include "hal.h"
extern unsigned long long hash_cycles;
#endif

#define inner crypto_hashblocks_sha512_m4mult_inner
#define blocks sha512_hashblocks

extern int inner(unsigned char *,const unsigned char *,unsigned int,const uint64_t *);

static const uint64_t constants[80] = {
  0x428a2f98d728ae22ULL
, 0x7137449123ef65cdULL
, 0xb5c0fbcfec4d3b2fULL
, 0xe9b5dba58189dbbcULL
, 0x3956c25bf348b538ULL
, 0x59f111f1b605d019ULL
, 0x923f82a4af194f9bULL
, 0xab1c5ed5da6d8118ULL
, 0xd807aa98a3030242ULL
, 0x12835b0145706fbeULL
, 0x243185be4ee4b28cULL
, 0x550c7dc3d5ffb4e2ULL
, 0x72be5d74f27b896fULL
, 0x80deb1fe3b1696b1ULL
, 0x9bdc06a725c71235ULL
, 0xc19bf174cf692694ULL
, 0xe49b69c19ef14ad2ULL
, 0xefbe4786384f25e3ULL
, 0x0fc19dc68b8cd5b5ULL
, 0x240ca1cc77ac9c65ULL
, 0x2de92c6f592b0275ULL
, 0x4a7484aa6ea6e483ULL
, 0x5cb0a9dcbd41fbd4ULL
, 0x76f988da831153b5ULL
, 0x983e5152ee66dfabULL
, 0xa831c66d2db43210ULL
, 0xb00327c898fb213fULL
, 0xbf597fc7beef0ee4ULL
, 0xc6e00bf33da88fc2ULL
, 0xd5a79147930aa725ULL
, 0x06ca6351e003826fULL
, 0x142929670a0e6e70ULL
, 0x27b70a8546d22ffcULL
, 0x2e1b21385c26c926ULL
, 0x4d2c6dfc5ac42aedULL
, 0x53380d139d95b3dfULL
, 0x650a73548baf63deULL
, 0x766a0abb3c77b2a8ULL
, 0x81c2c92e47edaee6ULL
, 0x92722c851482353bULL
, 0xa2bfe8a14cf10364ULL
, 0xa81a664bbc423001ULL
, 0xc24b8b70d0f89791ULL
, 0xc76c51a30654be30ULL
, 0xd192e819d6ef5218ULL
, 0xd69906245565a910ULL
, 0xf40e35855771202aULL
, 0x106aa07032bbd1b8ULL
, 0x19a4c116b8d2d0c8ULL
, 0x1e376c085141ab53ULL
, 0x2748774cdf8eeb99ULL
, 0x34b0bcb5e19b48a8ULL
, 0x391c0cb3c5c95a63ULL
, 0x4ed8aa4ae3418acbULL
, 0x5b9cca4f7763e373ULL
, 0x682e6ff3d6b2b8a3ULL
, 0x748f82ee5defb2fcULL
, 0x78a5636f43172f60ULL
, 0x84c87814a1f0ab72ULL
, 0x8cc702081a6439ecULL
, 0x90befffa23631e28ULL
, 0xa4506cebde82bde9ULL
, 0xbef9a3f7b2c67915ULL
, 0xc67178f2e372532bULL
, 0xca273eceea26619cULL
, 0xd186b8c721c0c207ULL
, 0xeada7dd6cde0eb1eULL
, 0xf57d4f7fee6ed178ULL
, 0x06f067aa72176fbaULL
, 0x0a637dc5a2c898a6ULL
, 0x113f9804bef90daeULL
, 0x1b710b35131c471bULL
, 0x28db77f523047d84ULL
, 0x32caab7b40c72493ULL
, 0x3c9ebe0a15c9bebcULL
, 0x431d67c49c100d4cULL
, 0x4cc5d4becb3e42b6ULL
, 0x597f299cfc657e2aULL
, 0x5fcb6fab3ad6faecULL
, 0x6c44198c4a475817ULL
};

#define CUTOFF 32768 /* must be multiple of 128 */

static int sha512_hashblocks(unsigned char *statebytes, const unsigned char *in, uint64_t inlen)
{
  while (inlen >= CUTOFF) {
    inner(statebytes,in,CUTOFF,constants); /* returns 0 */
    in += CUTOFF;
    inlen -= CUTOFF;
  }
  if (inlen < 128) return inlen;
  return inner(statebytes,in,inlen,constants);
}

static const unsigned char iv[64] = {
  0x6a,0x09,0xe6,0x67,0xf3,0xbc,0xc9,0x08,
  0xbb,0x67,0xae,0x85,0x84,0xca,0xa7,0x3b,
  0x3c,0x6e,0xf3,0x72,0xfe,0x94,0xf8,0x2b,
  0xa5,0x4f,0xf5,0x3a,0x5f,0x1d,0x36,0xf1,
  0x51,0x0e,0x52,0x7f,0xad,0xe6,0x82,0xd1,
  0x9b,0x05,0x68,0x8c,0x2b,0x3e,0x6c,0x1f,
  0x1f,0x83,0xd9,0xab,0xfb,0x41,0xbd,0x6b,
  0x5b,0xe0,0xcd,0x19,0x13,0x7e,0x21,0x79
} ;

int sha512_hash(unsigned char *out,const unsigned char *in, uint64_t inlen)
{
#ifdef PROFILE_HASHING
  unsigned long long t0 = hal_get_time();
#endif
  unsigned char h[64];
  unsigned char padded[256];
  unsigned int i;
  uint64_t bytes = inlen;

  for (i = 0;i < 64;++i) h[i] = iv[i];
  blocks(h,in,inlen);
  in += inlen;
  inlen &= 127;
  in -= inlen;

  for (i = 0;i < inlen;++i) padded[i] = in[i];
  padded[inlen] = 0x80;

  if (inlen < 112) {
    for (i = inlen + 1;i < 119;++i) padded[i] = 0;
    padded[119] = bytes >> 61;
    padded[120] = bytes >> 53;
    padded[121] = bytes >> 45;
    padded[122] = bytes >> 37;
    padded[123] = bytes >> 29;
    padded[124] = bytes >> 21;
    padded[125] = bytes >> 13;
    padded[126] = bytes >> 5;
    padded[127] = bytes << 3;
    blocks(h,padded,128);
  } else {
    for (i = inlen + 1;i < 247;++i) padded[i] = 0;
    padded[247] = bytes >> 61;
    padded[248] = bytes >> 53;
    padded[249] = bytes >> 45;
    padded[250] = bytes >> 37;
    padded[251] = bytes >> 29;
    padded[252] = bytes >> 21;
    padded[253] = bytes >> 13;
    padded[254] = bytes >> 5;
    padded[255] = bytes << 3;
    blocks(h,padded,256);
  }

  for (i = 0;i < 64;++i) out[i] = h[i];

#ifdef PROFILE_HASHING
  unsigned long long t1 = hal_get_time();
  hash_cycles += (t1 - t0);
#endif

  return 0;
}
