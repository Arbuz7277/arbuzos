// ports.hpp

#pragma once
#include <cstdint>

namespace io {

class Port {
public:
    static inline void outb(uint16_t port, uint8_t value) {
        __asm__ volatile("outb %0, %1" : : "a"(value), "Nd"(port) : "memory");
    }

    static inline uint8_t inb(uint16_t port) {
        uint8_t ret;
        __asm__ volatile("inb %1, %0" : "=a"(ret) : "Nd"(port) : "memory");
        return ret;
    }

    static inline void eoi() {
        outb(0x20, 0x20);
    }
};

}
