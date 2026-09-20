[bits 16]

gdt_start:
    dq 0

gdt_code:
    dw 0xFFFF        ; limit 0:15
    dw 0x0000        ; base 0:15
    db 0x00          ; base 16:23
    db 0x9A          ; access
    db 0xCF          ; flags, limit 16:19
    db 0x00          ; base 24:31

gdt_data:
    dw 0xFFFF        ; limit 0:15
    dw 0x0000        ; base 0:15
    db 0x00          ; base 16:23
    db 0x92          ; access
    db 0xCF          ; flags, limit 16:19
    db 0x00          ; base 24:31

gdt_end:

gdt_ptr:
    dw gdt_end - gdt_start - 1
    dd gdt_start
