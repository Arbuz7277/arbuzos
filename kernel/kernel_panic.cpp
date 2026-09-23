// kernel/kernel_panic.cpp

#include "print.hpp"
#include "registers.hpp"

__attribute__((noreturn, noinline))
extern "C" void kernel_panic(const char* text, Registers* regs) {
    __asm__ volatile("cli");

    io::print("\n*** KERNEL PANIC ***\n");
    io::print("Cause: "); io::print(text); io::print("\n");
    io::print("Registers:\n");

    io::print("  EIP: "); io::print(regs->eip); io::print(", CS: "); io::print(regs->cs);
    io::print(", EFLAGS: "); io::print(regs->eflags); io::print("\n");
    
    io::print("  EAX: "); io::print(regs->eax); io::print(", EBX: "); io::print(regs->eax);
    io::print(", ECX: "); io::print(regs->ecx); io::print(", EDX: "); io::print(regs->edx);
    io::print("\n");
 
    io::print("  ESP: "); io::print(regs->esp); io::print(", EBP: "); io::print(regs->ebp); 
    io::print(", ESI: "); io::print(regs->esi); io::print(",  EDI: "); io::print(regs->edi); 
    io::print("\n");

    for (;;) __asm__ volatile("hlt");
}
