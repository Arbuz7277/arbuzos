[bits 16]
[org 0x7C00]

start:
    cli
    xor ax, ax
    mov ds, ax
    mov ss, ax
    mov sp, 0x7C00

    mov [BOOT_DRIVE], dl

    ; Check LBA support
    call lba_support

    ; Read disk
    mov si, dap
    mov ah, 0x42
    mov dl, [BOOT_DRIVE]
    int 0x13
    jc read_error

    ; Enable A20
    in al, 0x92
    or al, 2
    out 0x92, al

    lgdt [gdt_ptr]

    ; enable PE bit in cr0
    mov eax, cr0
    or eax, 1
    mov cr0, eax

    ; Far jump to protected mode
    jmp dword 0x08:0x10000

read_error:
    mov si, msg_read_error
    call print_str_16
    jmp hang

hang:
    hlt
    jmp hang

%include "real_mode/print_str.asm"
%include "protected_mode/gdt.asm"
%include "disks/dap.asm"
%include "disks/lba_support.asm"

msg_read_error:      db "Disk read error!", 13, 10, 0
msg_lba_not_support: db "LBA not support!", 13, 10, 0
BOOT_DRIVE: db 0

times 510 - ($ - $$) db 0
dw 0xAA55
