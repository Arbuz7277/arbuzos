[bits 32]

global double_fault
double_fault:
    add esp, 4
    push msg_double_fault
    call kernel_panic
