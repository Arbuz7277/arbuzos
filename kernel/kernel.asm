[bits 32]

kernel:
    call read_kb
    jmp kernel

read_kb:
    mov eax, [kb_head]
    cmp eax, [kb_tail]
    jz .no_data

    ; Get scan-code
    mov ecx, [kb_tail]
    movzx eax, byte [kb_buffer + ecx]
    inc ecx
    and ecx, 0xFF
    mov [kb_tail], ecx

    call handle_scancode
.no_data:
    hlt
    jmp read_kb
