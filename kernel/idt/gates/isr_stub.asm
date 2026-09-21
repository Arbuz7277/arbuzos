[bits 32]

global isr_stub
isr_stub:
    mov esi, msg_stub
    call kernel_panic
