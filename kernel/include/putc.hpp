// drivers/print.cpp

#include <stdint.h>

namespace io {

static volatile uint16_t* const VGA = (uint16_t*)0xB8000;
static volatile uint32_t row = 0;
static volatile uint32_t col = 0;

void putc(uint8_t ch, uint8_t color);
void scroll();
void print(const char* text, uint8_t color = 0x0F);

}

