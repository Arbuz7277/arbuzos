[bits 32]

global irq1
irq1:
    pushad
    
    ; Read scan-code
    in al, 0x60

    ; Save to buffer
    mov ecx, [kb_head]
    mov [kb_buffer + ecx], al
    inc ecx
    and ecx, 0xFF  ; Max 256 bytes
    mov [kb_head], ecx

    mov al, 0x20
    out 0x20, al

    popad
    iret

kb_buffer: times 256 db 0
kb_head: dd 0
kb_tail: dd 0
