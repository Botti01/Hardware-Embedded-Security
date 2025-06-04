#ifndef LFSR_H
#define LFSR_H

#include <stdint.h>

#define SIZE_64 64
#define SIZE_32 32
#define SIZE_16 16
#define SIZE_8 8
#define SIZE_4 4
#define SIZE SIZE_4

uint64_t lfsr_3bit(unsigned int initial_state, unsigned int *next_state);
uint64_t lfsr_8bit(unsigned int initial_state, unsigned int *next_state);
uint64_t lfsr_16bit(unsigned int initial_state, unsigned int *next_state);

#endif // LFSR_H
