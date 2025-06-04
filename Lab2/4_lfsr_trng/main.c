#include "../2_lfsr/lfsr.h"
#include "../3_trng/drng.h"
#include "../3_trng/trng.h"

#include <stdio.h>


int main() {
    dnrg_t has_rdrand = 0;
    dnrg_t has_rdseed = 0;
    // Check if the CPU has RDRAND and RDSEED
    get_drng_support(&has_rdrand, &has_rdseed);
    dnrg_t drng_support;
    if (has_rdrand == DRNG_HAS_RDRAND) {
        drng_support = DRNG_HAS_RDRAND;
        printf("RDRAND supported\n");
    } else {
        if (has_rdseed == DRNG_HAS_RDSEED) {
            printf("RDSEED supported\n");
            drng_support = DRNG_HAS_RDSEED;
        } else {
            drng_support = DRNG_NO_SUPPORT;
            printf("No DRNG support\n");
        }
    }

    uint16_t trnd_number;
        if (get_true_random_number_16(&trnd_number, drng_support) == -1) {
            printf("Failed to get the random number\n");
        } else {
            printf("Random number: %u\n", trnd_number);
        }

    unsigned int random_number;
    unsigned int next_state;
    random_number = lfsr_16bit(trnd_number, &next_state);
    printf("Random number: %u \t Next State %u\n", random_number, next_state);

    return 0;
}
