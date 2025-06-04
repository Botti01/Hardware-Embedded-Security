#include <stdio.h>
#include <stdint.h>
#include "lfsr.h"


int main(int argc, char *argv[]) {
    unsigned int initial_state = 0x1; // 3-bit lfsr
    unsigned int next_state = 0x0;
    unsigned int rand_number = 0x0;

    printf("3-BIT LFSR\n");
    initial_state = 0x0;
    rand_number = lfsr_3bit(initial_state, &next_state);
    printf("RANDOM: %u , NEXT_STATE: %04x \n", rand_number, next_state);
    initial_state = 0x1;
    rand_number = lfsr_3bit(initial_state, &next_state);
    printf("RANDOM: %u , NEXT_STATE: %04x \n", rand_number, next_state);
    initial_state = 0x2;
    rand_number = lfsr_3bit(initial_state, &next_state);
    printf("RANDOM: %u , NEXT_STATE: %04x \n", rand_number, next_state);
    initial_state = 0x3;
    rand_number = lfsr_3bit(initial_state, &next_state);
    printf("RANDOM: %u , NEXT_STATE: %04x \n", rand_number, next_state);
    printf("\n");

    printf("8-BIT LFSR\n");
    initial_state = 0x0;
    rand_number = lfsr_8bit(initial_state, &next_state);
    printf("RANDOM: %u , NEXT_STATE: %04x \n", rand_number, next_state);
    initial_state = 0xAA;
    rand_number = lfsr_8bit(initial_state, &next_state);
    printf("RANDOM: %u , NEXT_STATE: %04x \n", rand_number, next_state);
    initial_state = 0x33;
    rand_number = lfsr_8bit(initial_state, &next_state);
    printf("RANDOM: %u , NEXT_STATE: %04x \n", rand_number, next_state);
    initial_state = 0xFF;
    rand_number = lfsr_8bit(initial_state, &next_state);
    printf("RANDOM: %u , NEXT_STATE: %04x \n", rand_number, next_state);
    printf("\n");

    printf("16-BIT LFSR\n");
    initial_state = 0x0;
    rand_number = lfsr_16bit(initial_state, &next_state);
    printf("RANDOM: %u , NEXT_STATE: %04x \n", rand_number, next_state);
    initial_state = 0x3333;
    rand_number = lfsr_16bit(initial_state, &next_state);
    printf("RANDOM: %u , NEXT_STATE: %04x \n", rand_number, next_state);
    initial_state = 0x5555;
    rand_number = lfsr_16bit(initial_state, &next_state);
    printf("RANDOM: %u , NEXT_STATE: %04x \n", rand_number, next_state);
    initial_state = 0xA354;
    rand_number = lfsr_16bit(initial_state, &next_state);
    printf("RANDOM: %u , NEXT_STATE: %04x \n", rand_number, next_state);
    printf("\n");
    return 0;
}
