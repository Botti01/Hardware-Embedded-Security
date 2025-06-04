#include <stdio.h>
#include "drng.h"
#include "trng.h"

#define NUM_RANDOM_NUMBERS 100
int main() {
    dnrg_t is_rdrand_supported = DRNG_NO_SUPPORT;
    dnrg_t is_rdseed_supported = DRNG_NO_SUPPORT;

    // Check if the CPU has RDRAND and RDSEED
    get_drng_support(&is_rdrand_supported, &is_rdseed_supported);
    dnrg_t drng_support;
    if (is_rdrand_supported == DRNG_HAS_RDRAND) {
        drng_support = DRNG_HAS_RDRAND;
        printf("RDRAND supported\n");
    } else {
        if (is_rdseed_supported == DRNG_HAS_RDSEED) {
            printf("RDSEED supported\n");
            drng_support = DRNG_HAS_RDSEED;
        } else {
            drng_support = DRNG_NO_SUPPORT;
            printf("No DRNG support\n");
        }
    }

    unsigned int result;
    for (int i = 0; i < NUM_RANDOM_NUMBERS; i++) {
        if (get_true_random_number(&result, drng_support) == -1) {
            printf("Failed to get the random number\n");
        } else {
            printf("Random number: %u\n", result);
        }
    }
    return 0;
}
