/**
 * file: drng.h
 * Author: Tzamn Melendez Carmona
 * Description: Header file for Digital Random Number Generator (DRNG) support based on Intel's 
 * Documentation. For more information, refer to the Intel 64 and IA-32 Architectures Software
 * Developer's Manual.
 *
 * Date: 22th April 2025
 * Version: 1.0
 *
 */
#ifndef _DRNG_H
#define _DRNG_H

/**
 * @brief Structure to hold CPUID result registers.
 */
typedef struct cpuid_struct {
    unsigned int eax;
    unsigned int ebx;
    unsigned int ecx;
    unsigned int edx;
} cpuid_t;

/**
 * @brief Enum representing DRNG (Digital Random Number Generator) support.
 */
typedef enum {
    DRNG_NO_SUPPORT = 0,
    DRNG_HAS_RDRAND = 1,
    DRNG_HAS_RDSEED = 2
} dnrg_t;

/**
 * @brief Get CPU information using CPUID instruction.
 *
 * @param info Pointer to cpuid_t struct to fill with register values.
 * @param leaf The CPUID leaf to query.
 * @param subleaf The CPUID subleaf to query.
 */
void cpuid(cpuid_t *info, unsigned int leaf, unsigned int subleaf);

/**
 * @brief Check if the CPU is AMD or Intel.
 *
 * @return 1 if the CPU is an Intel CPU, 0 otherwise.
 */
int _is_valid_cpu(void);

/**
 * @brief Get DRNG support status (RDRAND and RDSEED).
 *
 * @param has_rdrand Pointer to int set to 1 if RDRAND is supported, 0 otherwise.
 * @param has_rdseed Pointer to int set to 1 if RDSEED is supported, 0 otherwise.
 */
void get_drng_support(dnrg_t *has_rdrand, dnrg_t *has_rdseed);

#endif // _DRNG_H

