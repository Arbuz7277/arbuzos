[bits 32]

kernel_panic:
    cli
    push esi

    mov esi, msg_kernel_panic
    mov ah, 0x0F
    ;call print_str_32

    pop esi
    mov ah, 0x0F
    ;call print_str_32

    mov ah, 10001100b
    mov al, 'K'
    mov [0xB8000], ax
    mov al, 'P'
    mov [0xB8002], ax

    ;cli
.hang:
    hlt
    jmp .hang
