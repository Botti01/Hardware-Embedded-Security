#include "lfsr.h"
#include <stdint.h>
#include <stdio.h>

/* print `val` in binary with `bits` width (MSB first) */
static void print_bin(uint32_t value, unsigned int bits) {
    for (int b = bits - 1; b >= 0; --b) {
        putchar(((value >> b) & 1U) ? '1' : '0');
    }
}

/**
 * @brief Generates a pseudo-random number using a 3-bit Linear Feedback Shift
 * Register (LFSR). Taps at 3 and 2. Polynomial: x^3 + x^2 + 1.
 *
 * Figure 1: 3-bit LFSR with taps at 3 and 2.
 *
 *  rnd bit         lfsr
 *   +---+      +-----------+
 *   | 4 |      | 3 | 2 | 1 |<----
 *   +---+      +---+---+---+    |
 *                |   |          |
 *                +-------XOR----+ feedback bit
 *
 * @param initial_state The initial state of the 3-bit LFSR.
 * @param next_state A pointer to store the final state of the LFSR after SIZE
 * iterations.
 * @return A 64-bit unsigned integer representing the generated pseudo-random
 * number after SIZE iterations.
 */
#define MSK_3BIT 0x07  // Mask for 3-bit LFSR
uint64_t lfsr_3bit(unsigned int initial_state, unsigned int *next_state) {
    // Initialize the LFSR register with the initial state, ensuring it is 3 bits.
    uint8_t reg_lfsr = initial_state & MSK_3BIT; // 3-bit LFSR
    uint8_t feedbit;  // Variable to hold the feedback bit
    uint8_t rnd_bit;  // Variable to hold the random bit in each iteration
    uint64_t rnd_number = 0; // Variable to accumulate the generated random number

    // Iterate SIZE times to generate the random number
    for (int i = 0; i < SIZE; i++) {
        // Print the current state of the LFSR register for debugging
        printf(" Q+%d)\t0b", i);
        print_bin(reg_lfsr, 4);
        printf("\t%02x\n", reg_lfsr);

        // Calculate the feedback bit by XORing the bits at positions 1 and 2
        feedbit = ((reg_lfsr >> 1U) ^ (reg_lfsr >> 2U)) & 1U;
        
        // Shift the LFSR register left by one bit and add the feedback bit
        reg_lfsr = (reg_lfsr << 1U) | feedbit;
        
        // Extract the random bit now in the 4th position and set it to the LSB
        rnd_bit = (reg_lfsr >> 3U) & 1U;
        
        // Insert the random bit in the LSB of the random number
        rnd_number = (rnd_number << 1U) | rnd_bit;
        
        // Mask the LFSR to ensure it remains a 3-bit register
        reg_lfsr = reg_lfsr & MSK_3BIT;
    }

    *next_state = reg_lfsr;
    // Return the generated random number
    return rnd_number;
}
/**
 * @brief Generates a pseudo-random number using a 8-bit Linear Feedback Shift
 * Register (LFSR). Taps at 8, 6, 5, and 4. 
 * Polynomial: x^8 + x^6 + x^5 + x^4 + 1.
 *
 * Figure 2: 8-bit LFSR with taps at 8, 6, 5, and 4.
 *  rnd bit         lfsr    
 *  +---+      +--------------------------------+
 *  | 9 |      | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 |<---+
 *  +---+      +---+---+---+---+---+---+---+---+    |
 *               |       |   |   |                  |
 *               +--XOR--+   +XOR+                  | feedback bit 
 *                   |        |                     | 
 *                   +----+-----XOR-----------------+
 *
 *
 * @param initial_state The initial state of the 8-bit LFSR.
 * @param next_state A pointer to store the final state of the LFSR after SIZE
 * iterations.
 * @return A 64-bit unsigned integer representing the generated pseudo-random
 * number after SIZE iterations.
 */
#define MSK_8BIT 0xFF  // Mask for 8-bit LFSR
uint64_t lfsr_8bit(unsigned int initial_state, unsigned int *next_state) {
    // Initialize the LFSR register with the initial state, ensuring it is 8 bits.
    uint16_t reg_lfsr = initial_state & MSK_8BIT; // 8-bit LFSR
    uint8_t feedbit;  // Variable to hold the feedback bit
    uint8_t rnd_bit;  // Variable to hold the random bit in each iteration
    uint64_t rnd_number = 0; // Variable to accumulate the generated random number

    // Iterate SIZE times to generate the random number
    for (int i = 0; i < SIZE; i++) {
        // Print the current state of the LFSR register for debugging
        printf(" Q+%d)\t0b", i);
        print_bin(reg_lfsr, 8);
        printf("\t%04x\n", reg_lfsr);

        // Calculate the feedback bit by XORing the bits at positions 8, 6, 5, and 4
        feedbit = ((reg_lfsr >> 7U) ^ (reg_lfsr >> 5U) ^ (reg_lfsr >> 4U) ^ (reg_lfsr >> 3U)) & 1U;

        // Shift the LFSR register left by one bit and add the feedback bit
        reg_lfsr = (reg_lfsr << 1U) | feedbit;
        
        // Extract the random bit now in the 9th position and set it to the LSB
        rnd_bit = (reg_lfsr >> 8U) & 1U;
        
        // Insert the random bit in the LSB of the random number
        rnd_number = (rnd_number << 1U) | rnd_bit;
        
        // Mask the LFSR to ensure it remains a 8-bit register
        reg_lfsr = reg_lfsr & MSK_8BIT;
    }

    // Store the final state of the LFSR in the next_state variable
    *next_state = reg_lfsr;
    
    // Return the generated random number
    return rnd_number;
}


/**
 * @brief Generates a pseudo-random number using a 8-bit Linear Feedback Shift
 * Register (LFSR). Taps at 16, 14, 13, and 11. 
 * Polynomial:
 * x^16 + x^14 + x^13 + x^11 + 1.
 *
 * Figure 3: 16-bit LFSR with taps at 16, 14, 13, and 11.
 *  lfsr                                                      rnd bit
 *  +-------------------------------------------------------+ +---+
 *  | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 | | 17|
 *  +-------------------------------------------------------+ +---+
 *   ^                                |       |   |       |
 *   |                                +--XOR--+   +--XOR--+
 *   |                                    |           |
 *   +------------------------------------+-----------+
 *   feedback bit
 *
 * @param initial_state The initial state of the 16-bit LFSR.
 * @param next_state A pointer to store the final state of the LFSR after SIZE
 * iterations.
 * @return A 64-bit unsigned integer representing the generated pseudo-random
 * number after SIZE iterations.
 */
#define MSK_16BIT 0xFFFF  // Mask for 16-bit LFSR
uint64_t lfsr_16bit(unsigned int initial_state, unsigned int *next_state) {
    
    // Initialize the LFSR register with the initial state, ensuring it is 8 bits.
    uint16_t reg_lfsr = initial_state & MSK_16BIT; // 16-bit LFSR
    uint8_t feedbit;  // Variable to hold the feedback bit
    uint8_t rnd_bit;  // Variable to hold the random bit in each iteration
    uint64_t rnd_number = 0; // Variable to accumulate the generated random number

    // Iterate SIZE times to generate the random number
    for (int i = 0; i < SIZE; i++) {
        // Print the current state of the LFSR register for debugging
        printf(" Q+%d)\t0b", i);
        print_bin(reg_lfsr, 16);
        printf("\t%05x\n", reg_lfsr);

        // Calculate the feedback bit by XORing the bits at positions 11, 13, 14, and 16 and keeping it in the MSB, according to the Figure 3
        feedbit = ((reg_lfsr >> 5U) ^ (reg_lfsr >> 3U) ^ (reg_lfsr >> 2U) ^ (reg_lfsr & 1U)) & 1U;
        // Alternative Case, it is possible to set the bit in the LSB shifting according to the Figure 3
        // feedbit = ((lfsr << 10U) ^ (lfsr << 12U) ^ (lfsr << 13U) ^ (lfsr << 15U)) & (0x8000);

        // Before shifting the reg_lfsr extract from the MSB the random bit
        rnd_bit = reg_lfsr & 1U;
        
        // Shift the LFSR register right by one bit and add the feedback bit
        reg_lfsr = (reg_lfsr >> 1U) | (feedbit << 15U);

        // Alternative Case, it is possible to set the bit in the LSB shifting according to the Figure 3
        // reg_lfsr = (reg_lfsr >> 1U) | feedbit;

        // Insert the random bit in the LSB of the random number
        rnd_number = (rnd_number << 1U) | rnd_bit;
    }

    // Store the final state of the LFSR in the next_state variable
    *next_state = reg_lfsr;
    
    // Return the generated random number
    return rnd_number;
}

