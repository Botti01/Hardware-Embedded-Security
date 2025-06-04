#include "trng.h"
#include "drng.h"
#include <immintrin.h>
#include <stdint.h>
#include <stdio.h>

int get_true_random_number(unsigned int *result, dnrg_t drng_support) {
    int ret_val = 0;
    int failures = 0;
    int validFlag;
    if (drng_support == DRNG_NO_SUPPORT) {
        printf("No DRNG support\n");
        ret_val = -1;
        return ret_val;
    }

    while (1) {
        if (drng_support == DRNG_HAS_RDRAND) {
            validFlag = _rdrand32_step(result);
        } else {
            validFlag = _rdseed32_step(result);
        }
        if (validFlag == 1) {
            break;
        } else {
            failures++;
        }
        if (failures > GENERATE) {
            ret_val = -1;
            break;
        }
    }
    return ret_val;
}

int get_true_random_number_16(uint16_t *result, dnrg_t drng_support) {
    int ret_val = 0;
    int failures = 0;
    int validFlag;
    if (drng_support == DRNG_NO_SUPPORT) {
        printf("No DRNG support\n");
        ret_val = -1;
        return ret_val;
    }

    while (1) {
        if (drng_support == DRNG_HAS_RDRAND) {
            validFlag = _rdrand16_step(result);
        } else {
            validFlag = _rdseed16_step(result);
        }
        if (validFlag == 1) {
            break;
        } else {
            failures++;
        }
        if (failures > GENERATE) {
            ret_val = -1;
            break;
        }
    }
    return ret_val;
}
