[bits 32]

print_hex:
    add edi, 0xB8000
    mov edx, eax
    mov ecx, 8
.loop:
    rol edx, 4
    mov al, dl
    and al, 0x0F
    cmp al, 10
    jb .digit
    add al, 'A' - 10
    jmp .store
.digit:
    add al, '0'
.store:
    mov ah, 0x0F
    mov [edi], ax
    add edi, 2
    loop .loop
    sub edi, 0xB8000
    ret
