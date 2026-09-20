[bits 16]

lba_support:
    mov ah, 0x41
    mov bx, 0x55AA
    mov dl, [BOOT_DRIVE]
    int 0x13
    jc lba_not_support
    cmp bx, 0xAA55
    jne lba_not_support
    ret

lba_not_support:
    mov si, msg_lba_not_support
    call print_str_16
    jmp hang
