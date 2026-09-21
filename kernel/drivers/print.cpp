// drivers/print.cpp

#include <stdint.h>
#include "print.hpp"

void io::putc(uint8_t ch, uint8_t color) {
    if (col >= 80) {
        row += col / 80;
        col = col % 80;
    }

    if (row >= 25) scroll();

    if (ch == '\n') {
        col = 0;
        row += 1;
        return;
    }
    if (ch == '\b') {
        if (col > 0) {
            col -= 1;
            VGA[row * 80 + col] = (uint16_t)ch | (color << 8);
        }
        return;
    }
        
    VGA[row * 80 + col] = (uint16_t)ch | (color << 8);
    col += 1;
}

void io::scroll() {
    for (int r = 1; r < 25; r++) {
        for (int c = 0; c < 80; c++) {
            VGA[(r - 1) * 80 + c] = VGA[r * 80 + c];
        }
    }

    for (int c = 0; c < 80; c++) {
        VGA[24 * 80 + c] = (uint16_t)' ' | (0x0F << 8);
    }

    row = 24;
    col = 0;
}

void io::print(const char* text, uint8_t color) {
    int i = -1;
    while (text[++i]) {
        io::putc(text[i], color);
    }
}

