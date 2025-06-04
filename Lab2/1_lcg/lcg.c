#include "lcg.h"
#include <stdio.h>

/**
 * @brief Generates a pseudo-random number using a Linear Congruential Generator
 * (LCG). The LCG is defined by the recurrence relation:
 * X_{n+1} = (a * X_n + c) mod m
 *
 * @param a The multiplier parameter of the LCG.
 * @param c The increment parameter of the LCG.
 * @param m The modulus parameter of the LCG.
 * @param rand_x0 the initial random number of the LCG.
 * @param rand_xn A pointer to store the final rand_number of the LCG after SIZE
 * iterations.
 * @return void
 * */
void lcg(uint64_t a, uint64_t c, uint64_t m, uint64_t rand_x0, uint64_t *rand_xn) {
  // Initialize the LCG register with the initial state
  uint64_t rand_x = rand_x0;
  uint64_t rnd_number = 0; // Variable to accumulate the generated random number

  // Iterate SIZE times to generate the random number
  for (int i = 0; i < SIZE; i++) {
    // Print the current random number of the LCG register for debugging
    printf(" X+%d)\t %lu\n", i, rand_x);
    // Calculate the next state of the LCG using the recurrence relation
    rand_x = (a * rand_x + c) % m;
  }
  *rand_xn = rand_x;

}
