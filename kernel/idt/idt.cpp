// idt.cpp

extern "C" {
    void isr_stub();

    void double_fault();
    void irq0();
    void irq1();

    void pic_remap();
}

#include <stdint.h>
#include "idt.hpp"

namespace io {

IDTEntry IDT::entries[48];
IDTPointer IDT::pointer;

void IDT::init() {
    // Fill everything with a stub
    for (int i = 0; i < 48; i++) {
        uint32_t handler = (uint32_t)&isr_stub;

        entries[i].base_low = handler & 0xFFFF;
        entries[i].base_high = (handler >> 16) & 0xFFFF;
        entries[i].selector = 0x08;
        entries[i].always0 = 0;
        entries[i].flags = 0x8E;  // Present, Ring 0, 32-bits
    }

    // Redefining vectors
    // Vector 8: Double fault
    uint32_t df_handler = (uint32_t)&double_fault;
    entries[8].base_low = df_handler & 0xFFFF;
    entries[8].base_high = (df_handler >> 16) & 0xFFFF;

    // Vector 32: IRQ0, timer
    uint32_t irq0_handler = (uint32_t)&irq0;
    entries[32].base_low = irq0_handler & 0xFFFF;
    entries[32].base_high = (irq0_handler >> 16) & 0xFFFF;

    // Vector 33: IRQ1, keyboard
    uint32_t irq1_handler = (uint32_t)&irq1;
    entries[33].base_low = irq1_handler & 0xFFFF;
    entries[33].base_high = (irq1_handler >> 16) & 0xFFFF;
    
    // Pointer for lidt
    pointer.limit = (sizeof(IDTEntry) * 48) - 1;
    pointer.base = (uint32_t)&entries;

    // Load IDT
    __asm__ volatile("lidt %0" : : "m"(pointer));

    // PIC remap
    pic_remap();
}

}
