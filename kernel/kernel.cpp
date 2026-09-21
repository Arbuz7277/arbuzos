// kernel.cpp

#include <stdint.h>
#include "putc.hpp"
#include "idt.hpp"

extern "C" void kmain();

void hang() {
    while (1) {
        __asm__ volatile("hlt");
    }
}


void kmain() {
    io::IDT::init();

    __asm__ volatile("sti");

    io::print("Hello from C++ kernel!\n");
    io::print("It's a v1");
    hang();
}
