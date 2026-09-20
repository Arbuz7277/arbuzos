[bits 32]

putc:
    pushad
    cmp al, 10  ; '\n'
    jz .nextline
    cmp al, 8
    jz .backspace
    mov edi, [pos]
    mov [edi], ax
    add edi, 2
    mov [pos], edi
.done:
    popad
    ret
.nextline:
    mov eax, [pos]
    sub eax, 0xB8000
    xor edx, edx
    mov ecx, 160
    div ecx

    inc eax

    mul ecx

    add eax, 0xB8000
    mov [pos], eax
    jmp .done
.backspace:
    mov eax, [pos]
    sub eax, 2
    mov word [eax], 0x0F20
    mov [pos], eax
    jmp .done

pos: dd 0x000B8000
