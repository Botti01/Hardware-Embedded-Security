#ifndef LCG_H
#define LCG_H

#include <stdint.h>

#define SIZE 5
void lcg(uint64_t a, uint64_t c, uint64_t m, uint64_t rand_x0, uint64_t *rand_xn);

#endif // LCG_H
