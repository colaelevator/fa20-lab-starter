#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"

uint16_t get_bit(uint16_t x, int n)
{
    return (x >> n) & 1;
}

void set_bit(uint16_t* x, int n, uint16_t v)
{
    if (v)
    {
        *x |= (1 << n);
    }
    else
    {
        *x &= ~(1 << n);
    }
}

void lfsr_calculate(uint16_t *reg) {
    /* YOUR CODE HERE */
    uint16_t new = ((get_bit(*reg, 0) ^ get_bit(*reg, 2)) ^ get_bit(*reg, 3)) ^ get_bit(*reg, 5);
    *reg = *reg >> 1;
    set_bit(reg, 15, new);
}

