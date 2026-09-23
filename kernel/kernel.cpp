// kernel.cpp

#include <stdint.h>
#include "print.hpp"
#include "idt.hpp"

extern "C" {
    void kmain();
    void pic_remap();
}

void hang() {
    while (1) {
        __asm__ volatile("hlt");
    }
}


void kmain() {
    io::IDT::init();
    pic_remap();

    __asm__ volatile("sti");

    io::print("Hello from C++ kernel!\n");
    io::print("It's a v1");

    hang();
}
