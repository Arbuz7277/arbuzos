[bits 32]

global isr_stub
isr_stub:
    pushad

    push esp        ; Registers* regs
    push msg_stub   ; const char* text
    call kernel_panic
