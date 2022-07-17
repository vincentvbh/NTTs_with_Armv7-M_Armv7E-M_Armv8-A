
#include "params.h"
#include "poly_type.h"

/* ----- Streamlined NTRU Prime Core */

/* h,(f,ginv) = KeyGen() */
void KeyGen(Fq *h, small *f, small *ginv);

/* c = Encrypt(r,h) */
void Encrypt(Fq *c, small *r, Fq *h);

/* r = Decrypt(c,(f,ginv)) */
void Decrypt(small *r, Fq *c, small *f, const small *ginv);

/* ----- Streamlined NTRU Prime Core plus encoding */

typedef small Inputs[POLY_N]; /* passed by reference */
#define Inputs_random Short_random
#define Inputs_encode Small_encode
#define Inputs_bytes Small_bytes

#define Ciphertexts_bytes Rounded_bytes
#define SecretKeys_bytes (2*Small_bytes)
#define PublicKeys_bytes Rq_bytes

/* pk,sk = ZKeyGen() */
void ZKeyGen(unsigned char *pk, unsigned char *sk);

/* C = ZEncrypt(r,pk) */
void ZEncrypt(unsigned char *C, Inputs r, const unsigned char *pk);

/* r = ZDecrypt(C,sk) */
void ZDecrypt(Inputs r, const unsigned char *C, const unsigned char *sk);


