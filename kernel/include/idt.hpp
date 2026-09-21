// idt.hpp

#pragma once

#include <stdint.h>

struct IDTEntry {
    uint16_t base_low;
    uint16_t selector;   // selector GDT (0x08 - code)
    uint8_t  always0;
    uint8_t  flags;      // Flags (0x8E for 32-bits gates interrupt)
    uint16_t base_high;
} __attribute__((packed));

// For lidt
struct IDTPointer {
    uint16_t limit;
    uint32_t base;
} __attribute__((packed));


namespace io {

class IDT {
private:
    static IDTEntry entries[48];
    static IDTPointer pointer;

public:
    static void init();
};

}

