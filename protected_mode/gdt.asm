[bits 16]

gdt_start:
    dq 0

gdt_code0:
    dw 0xFFFF        ; limit 0:15
    dw 0x0000        ; base 0:15
    db 0x00          ; base 16:23
    db 10011010b     ; access
    db 11001111b     ; flags, limit 16:19
    db 0x00          ; base 24:31

gdt_data0:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010010b
    db 11001111b
    db 0x00

gdt_code3:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 11111010b
    db 11001111b
    db 0x00

gdt_data3:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 11110010b
    db 11001111b
    db 0x00

gdt_end:

gdt_ptr:
    dw gdt_end - gdt_start - 1
    dd gdt_start
