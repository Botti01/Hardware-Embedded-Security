#include "lcg.h"
#include <stdio.h>

int main(int argc, char *argv[]) {
    uint64_t a = 75;
    uint64_t c = 74;
    uint64_t m = 0;
    uint64_t rand_x0 = 0x1;
    uint64_t rand_xn = 0x0;

    printf("LINEAR CONGRUENTIAL GENERATOR\n");
    m = 2;
    printf("a = %lu, c = %lu, m = %lu, X0 = %lu\n", a, c, m, rand_x0);
    lcg(a, c, m, rand_x0, &rand_xn);
    printf("RANDOM: %lu\n", rand_xn);
    m = 3;
    printf("a = %lu, c = %lu, m = %lu, X0 = %lu\n", a, c, m, rand_x0);
    lcg(a, c, m, rand_x0, &rand_xn);
    printf("RANDOM: %lu\n", rand_xn);
    m = 5;
    printf("a = %lu, c = %lu, m = %lu, X0 = %lu\n", a, c, m, rand_x0);
    lcg(a, c, m, rand_x0, &rand_xn);
    printf("RANDOM: %lu\n", rand_xn);
    m = 7;
    printf("a = %lu, c = %lu, m = %lu, X0 = %lu\n", a, c, m, rand_x0);
    lcg(a, c, m, rand_x0, &rand_xn);
    printf("RANDOM: %lu\n", rand_xn);
    m = 11;
    printf("a = %lu, c = %lu, m = %lu, X0 = %lu\n", a, c, m, rand_x0);
    lcg(a, c, m, rand_x0, &rand_xn);
    printf("RANDOM: %lu\n", rand_xn);
    m = 12;
    printf("a = %lu, c = %lu, m = %lu, X0 = %lu\n", a, c, m, rand_x0);
    lcg(a, c, m, rand_x0, &rand_xn);
    printf("RANDOM: %lu\n", rand_xn);
    m = 13;
    printf("a = %lu, c = %lu, m = %lu, X0 = %lu\n", a, c, m, rand_x0);
    lcg(a, c, m, rand_x0, &rand_xn);
    printf("RANDOM: %lu\n", rand_xn);
    m = 17;
    printf("a = %lu, c = %lu, m = %lu, X0 = %lu\n", a, c, m, rand_x0);
    lcg(a, c, m, rand_x0, &rand_xn);
    printf("RANDOM: %lu\n", rand_xn);
    printf("\n");
    return 0;
}
