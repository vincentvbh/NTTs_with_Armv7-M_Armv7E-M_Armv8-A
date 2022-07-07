/*********************************
*
* Implementation of djbsort for signed 32-bit integer arrays
* 
***********************************/

#include <stdint.h>
#include "crypto_sort.h"

#define int32_MINMAX(a,b) \
do { \
  int32_t temp1; \
  asm( \
    "cmp %0,%1\n\t" \
    "mov %2,%0\n\t" \
    "itt gt\n\t" \
    "movgt %0,%1\n\t" \
    "movgt %1,%2\n\t" \
    : "+r"(a), "+r"(b), "=r"(temp1) \
    : \
    : "cc" \
  ); \
} while(0)

extern void __asm_minmax(int32_t*, int32_t*, int32_t);
extern void __asm_minmax_quadjump(int32_t*, int32_t, int32_t);
/* assume 2 <= n <= 0x40000000 */
static void crypto_sort_smallindices(int32_t *x,int32_t n)
{
  int32_t top,p,q,r,i,j;

  top = 1;
  while (top < n - top) top += top;

  for (p = top;p >= 4;p >>= 1) {
    i = 0;
    while (i + 2 * p <= n) {
      __asm_minmax(x + i, x + i + p, p);
      i += 2 * p;
    }

    for (j = i; j < n - p; j++){
      int32_MINMAX(x[j], x[j + p]);
    }


    i = 0;
    j = 0;
    for (q = top;q > p;q >>= 1) {
      if (j != i) for (;;) {
        if (j == n - q) goto done;
        int32_t a = x[j + p];
        for (r = q;r > p;r >>= 1)
          int32_MINMAX(a,x[j + r]);
        x[j + p] = a;
        ++j;
        if (j == i + p) {
          i += 2 * p;
          break;
        }
      }
      while (i + p <= n - q) {
        for (j = i;j < i + p; j += 4) {
          __asm_minmax_quadjump(x + j, p, q);
        }
        i += 2 * p;
      }
      /* now i + p > n - q */
      j = i;
      while (j < n - q) {
        int32_t a = x[j + p];
        for (r = q;r > p;r >>= 1)
          int32_MINMAX(a,x[j+r]);
        x[j + p] = a;
        ++j;
      }

      done: ;
    }
  }
  /* this should be just p = 2 */
  for (;p == 2;p = 1) {
    i = 0;
    while (i + 2 * p <= n) {
      int32_MINMAX(x[i + 0], x[i + 2]);
      int32_MINMAX(x[i + 1], x[i + 3]);
      i += 2 * p;
    }
    for (j = i; j < n - p; j++)
      int32_MINMAX(x[j], x[j + p]);

    i = 0;
    j = 0;
    for (q = top; q > p; q >>= 1) {
      if (j != i) for (;;) {
        if (j == n - q) goto done0;
        int32_t a = x[j + p];
        for (r = q;r > p;r >>= 1)
          int32_MINMAX(a,x[j + r]);
        x[j + p] = a;
        ++j;
        if (j == i + p) {
          i += 2 * p;
          break;
        }
      }
      while (i + p <= n - q) {
        int32_t a0 = x[i + 2];
        int32_t a1 = x[i + 3];
        for (r = q; r > p; r >>= 1) {
          int32_MINMAX(a0, x[i + r + 0]);
          int32_MINMAX(a1, x[i + r + 1]);
        }
        x[i + 2] = a0;
        x[i + 3] = a1;
        i += 2 * p;
      }
      /* now i + p > n - q */
      j = i;
      while (j < n - q) {
        int32_t a = x[j + p];
        for (r = q;r > p;r >>= 1)
          int32_MINMAX(a,x[j+r]);
        x[j + p] = a;
        ++j;
      }

      done0: ;
    }
  }
  /* this should be just p = 1 */
  for (;p == 1;p = 0) {
    i = 0;
    while (i + 2 * p <= n) {
      for (j = i;j < i + p;++j)
        int32_MINMAX(x[j],x[j+p]);
      i += 2 * p;
    }
    for (j = i;j < n - p;++j)
      int32_MINMAX(x[j],x[j+p]);

    i = 0;
    j = 0;
    for (q = top;q > p;q >>= 1) {
      if (j != i) for (;;) {
        if (j == n - q) goto done1;
        int32_t a = x[j + p];
        for (r = q;r > p;r >>= 1)
          int32_MINMAX(a,x[j + r]);
        x[j + p] = a;
        ++j;
        if (j == i + p) {
          i += 2 * p;
          break;
        }
      }
      while (i + p <= n - q) {
        int32_t a = x[i + 1];
        for (r = q; r > p; r >>= 1)
          int32_MINMAX(a, x[i + r]);
        x[i + 1] = a;
        i += 2 * p;
      }
      /* now i + p > n - q */
      j = i;
      while (j < n - q) {
        int32_t a = x[j + p];
        for (r = q;r > p;r >>= 1)
          int32_MINMAX(a,x[j+r]);
        x[j + p] = a;
        ++j;
      }

      done1: ;
    }
  }
}

void crypto_sort(void *array,long long n)
{
  long long top,p,q,r,i,j;
  int32_t *x = array;

  if (n < 2) return;
  if (n < 0x40000000) {
    crypto_sort_smallindices(x,n);
    return;
  }
  top = 1;
  while (top < n - top) top += top;

  for (p = top;p >= 1;p >>= 1) {
    i = 0;
    while (i + 2 * p <= n) {
      for (j = i;j < i + p;++j)
        int32_MINMAX(x[j],x[j+p]);
      i += 2 * p;
    }
    for (j = i;j < n - p;++j)
      int32_MINMAX(x[j],x[j+p]);

    i = 0;
    j = 0;
    for (q = top;q > p;q >>= 1) {
      if (j != i) for (;;) {
        if (j == n - q) goto done;
        int32_t a = x[j + p];
        for (r = q;r > p;r >>= 1)
          int32_MINMAX(a,x[j + r]);
        x[j + p] = a;
        ++j;
        if (j == i + p) {
          i += 2 * p;
          break;
        }
      }
      while (i + p <= n - q) {
        for (j = i;j < i + p;++j) {
          int32_t a = x[j + p];
          for (r = q;r > p;r >>= 1)
            int32_MINMAX(a,x[j+r]);
          x[j + p] = a;
        }
        i += 2 * p;
      }
      /* now i + p > n - q */
      j = i;
      while (j < n - q) {
        int32_t a = x[j + p];
        for (r = q;r > p;r >>= 1)
          int32_MINMAX(a,x[j+r]);
        x[j + p] = a;
        ++j;
      }

      done: ;
    }
  }
}