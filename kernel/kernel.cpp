// kernel.cpp

#include <stdint.h>
#include "putc.hpp"

extern "C" void kmain();

void hang() {
    while (1) {
        __asm__ volatile("cli; hlt");
    }
}


void kmain() {
    io::print("Hello from C++ kernel!\n");
    io::print("It's a v1");
    hang();
}
