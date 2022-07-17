/*********************************
*
* Implementation of djbsort for unsigned 32-bit integer arrays
* 
***********************************/

#include "crypto_sort.h"
#include "uint32.h"

/* can save time by vectorizing xor loops */
/* can save time by integrating xor loops with int32_sort */

void crypto_sort_uint32(void *array,long long n)
{
  uint32 *x = array;
  long long j;
  for (j = 0;j < n;++j) x[j] ^= 0x80000000;
  crypto_sort(array,n);
  for (j = 0;j < n;++j) x[j] ^= 0x80000000;
}