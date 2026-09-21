[bits 32]

global pmode
extern kmain

pmode:
    mov ax, 0x10  ; Data in GDT: 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000

    ; Stack alignment
    and esp, 0xFFFFFFF0

    ; Load kernel
    call kmain
