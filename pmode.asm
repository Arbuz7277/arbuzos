[bits 32]

global pmode

pmode:
    mov ax, 0x10  ; Data in GDT: 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000

    ; PIC remap
    call pic_remap

    ; Print
    mov esi, msg_welcome
    mov ah, 0x0F
    call print_str_32

    ; Init IDT
    lidt [idt_descriptor]
    sti

    ; Load kernel
    and esp, 0xFFFFFFF0

    extern kmain
    call kmain


%include "protected_mode/idt/idt.asm"
%include "protected_mode/idt/pic_remap.asm"
%include "protected_mode/print_str.asm"
%include "protected_mode/screen/putc.asm"
%include "protected_mode/screen/keyboard/handle_scancode.asm"
%include "kernel/kernel.asm"
%include "kernel/kernel_panic.asm"

%include "protected_mode/idt/idt_msg.asm"

msg_welcome:      db "Protected mode activated!", 10, 0
msg_kernel_panic: db "KERNEL PANIC!", 10, 0
