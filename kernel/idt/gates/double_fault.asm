[bits 32]

global double_fault
double_fault:
    add esp, 4
    mov esi, msg_double_fault
    call kernel_panic
