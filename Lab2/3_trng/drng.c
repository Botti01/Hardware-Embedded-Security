#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "drng.h"

void cpuid(cpuid_t *info, unsigned int leaf, unsigned int subleaf) {
    asm volatile("cpuid"
                 : "=a"(info->eax), "=b"(info->ebx), "=c"(info->ecx),
                   "=d"(info->edx)
                 : "a"(leaf), "c"(subleaf));
}

int _is_valid_cpu(void) {
    static int valid_cpu = -1;
    cpuid_t info;

    if (valid_cpu == -1) {
        // Check if the CPU is Intel by querying CPUID leaf 0
        cpuid(&info, 0, 0);
        // Check if the vendor ID is "GenuineIntel"
        // The vendor ID is stored in EBX, EDX, and ECX registers
        // in the order: EBX, EDX, ECX
        // get the sting from the registers

        char vendor[13];
        memcpy(vendor, (char *)&info.ebx, 4);
        memcpy(vendor + 4, (char *)&info.edx, 4);
        memcpy(vendor + 8, (char *)&info.ecx, 4);
        vendor[12] = '\0'; // Null-terminate the string
        printf("Vendor ID: %s\n", vendor);

        if (strcmp(vendor, "GenuineIntel") == 0) {
            // Intel CPU detected
            valid_cpu = 1;
        }
        else if (strcmp(vendor, "AuthenticAMD") == 0) {
            // AMD CPU detected
            valid_cpu = 1;
        }
        else {
            // Unknown CPU vendor
            valid_cpu = 0;
        }        
    }
    return valid_cpu;
}

void get_drng_support(dnrg_t *has_rdrand, dnrg_t *has_rdseed) {
    static dnrg_t drng_features = DRNG_NO_SUPPORT;
    if (has_rdrand) *has_rdrand = DRNG_NO_SUPPORT;
    if (has_rdseed) *has_rdseed = DRNG_NO_SUPPORT;

    if (drng_features == DRNG_NO_SUPPORT && _is_valid_cpu()) {
        cpuid_t info;

        // Check for RDRAND support (ECX bit 30 of leaf 1)
        cpuid(&info, 1, 0);
        if ((info.ecx & (1u << 30)) != 0) {
            drng_features |= DRNG_HAS_RDRAND;
        }

        // Check for RDSEED support (EBX bit 18 of leaf 7)
        cpuid(&info, 7, 0);
        if ((info.ebx & (1u << 18)) != 0) {
            drng_features |= DRNG_HAS_RDSEED;
        }
    }
    
    if (has_rdrand && (drng_features & DRNG_HAS_RDRAND)) {
        *has_rdrand = DRNG_HAS_RDRAND;
    }

    if (has_rdseed && (drng_features & DRNG_HAS_RDSEED)) {
        *has_rdseed = DRNG_HAS_RDSEED;
    }
}
