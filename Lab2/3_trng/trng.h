#ifndef TRNG_H
#define TRNG_H
#define GENERATE 10
#include <stdint.h>
#include "drng.h"

/**
 * @brief Get the true random number from the hardware random number generator
 * if available. The function will try to get the random number from the RDRAND 
 * instruction first, if it fails, it will try to get the random number from the 
 * RDSEED instruction. If the CPU does not support the RDRAND or RDSEED instruction,
 * the function will return -1.
 *
 * @param result
 * @return int number of failures to get the random number or -1 if the CPU does not support the RDRAND or RDSEED instruction. if the number of failures is greater than GENERATE, the function will return -1.
 */
int get_true_random_number(unsigned int *result, dnrg_t drng_support);

/**
 * @brief Get a 16 bits true random number from the hardware random number generator
 * if available. The function will try to get the random number from the RDRAND 
 * instruction first, if it fails, it will try to get the random number from the 
 * RDSEED instruction. If the CPU does not support the RDRAND or RDSEED instruction,
 * the function will return -1.
 *
 * @param result
 * @return int number of failures to get the random number or -1 if the CPU does not support the RDRAND or RDSEED instruction. if the number of failures is greater than GENERATE, the function will return -1.
 */
int get_true_random_number_16(uint16_t *result, dnrg_t drng_support);

#endif // TRNG_H
