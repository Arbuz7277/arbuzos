[bits 32]

irq0:
    pushad

    mov al, 0x20
    out 0x20, al

    popad
    iret
