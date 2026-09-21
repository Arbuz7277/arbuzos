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

    ; PIC remap
    call pic_remap

    ; Init IDT
    lidt [idt_descriptor]

    ; Stack alignment
    and esp, 0xFFFFFFF0

    ; Load kernel
    call kmain


%include "protected_mode/idt/idt.asm"
%include "protected_mode/idt/pic_remap.asm"
%include "protected_mode/print_str.asm"
%include "protected_mode/screen/putc.asm"
%include "protected_mode/screen/keyboard/handle_scancode.asm"
%include "kernel/kernel.asm"
%include "kernel/kernel_panic.asm"

%include "protected_mode/idt/idt_msg.asm"

msg_kernel_panic: db "KERNEL PANIC!", 10, 0
