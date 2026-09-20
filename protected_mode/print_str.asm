[bits 32]

print_str_32:
.loop:
    lodsb
    test al, al
    jz .done
    call putc
    jmp .loop
.done:
    ret
