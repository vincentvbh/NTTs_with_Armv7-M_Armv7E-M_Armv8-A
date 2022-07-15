/* Deterministic randombytes by Daniel J. Bernstein */
/* taken from SUPERCOP (https://bench.cr.yp.to)     */

#include "api.h"
#include "hal.h"

#include <stdio.h>
#include <stdint.h>
#include <string.h>

#define NTESTS 2

typedef uint32_t uint32;

static void printbytes(const unsigned char *x, unsigned long long xlen)
{
  char outs[2*xlen+1];
  unsigned long long i;
  for(i=0;i<xlen;i++)
    sprintf(outs+2*i, "%02x", x[i]);
  outs[2*xlen] = 0;
  hal_send_str(outs);
}

int main(void)
{
  unsigned char key_a[CRYPTO_BYTES], key_b[CRYPTO_BYTES];
  unsigned char pk[CRYPTO_PUBLICKEYBYTES];
  unsigned char sendb[CRYPTO_CIPHERTEXTBYTES];
  unsigned char sk_a[CRYPTO_SECRETKEYBYTES];
  int i,j;

  hal_setup(CLOCK_FAST);

  // write dummy bytes
  for(i = 0; i < 60; i++){
    hal_send_str("==========================");
  }

  for(i=0;i<NTESTS;i++)
  {
    // Key-pair generation
    crypto_kem_keypair(pk, sk_a);

    printbytes(pk,CRYPTO_PUBLICKEYBYTES);
    printbytes(sk_a,CRYPTO_SECRETKEYBYTES);

    // Encapsulation
    crypto_kem_enc(sendb, key_b, pk);

    printbytes(sendb,CRYPTO_CIPHERTEXTBYTES);
    printbytes(key_b,CRYPTO_BYTES);

    // Decapsulation
    crypto_kem_dec(key_a, sendb, sk_a);

    printbytes(key_a,CRYPTO_BYTES);

    for(j=0;j<CRYPTO_BYTES;j++)
    {
      if(key_a[j] != key_b[j])
      {
        hal_send_str("ERROR");
        hal_send_str("#");
        return -1;
      }
    }
  }

  hal_send_str("#");
  return 0;
}

