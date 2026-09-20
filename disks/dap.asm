[bits 16]

align 4
dap:
    db 0x10        ; Size DAP (16 bytes)
    db 0           ; always zero
    dw 8          ; count sectors for read
    dw 0x0000      ; offset buffer
    dw 0x1000      ; segment buffer (0x1000:0x0000 = 0x10000)
    dq 1           ; start LBA (0 - boot)
