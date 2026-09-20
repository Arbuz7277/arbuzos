[bits 32]

handle_scancode:
    pushad

    ; Shift up
    cmp al, 0xAA  ; Left shift
    jz .shift_off
    cmp al, 0xB6  ; Right shift
    jz .shift_off

    ; If it up-code: done
    test al, 0x80
    jnz .done

    ; Shift down
    cmp al, 0x2A  ; Left shift
    jz .shift_on
    cmp al, 0x36  ; Right shift
    jz .shift_on

    movzx ebx, al
    mov bl, [keymap_us + ebx]
    test bl, bl
    jz .done

    cmp byte [shift_pressed], 0
    jz .print

    cmp bl, 'a'
    jb .print
    cmp bl, 'z'
    ja .print
    sub bl, 32

.print:
    mov al, bl
    mov ah, 0x0F
    call putc
    jmp .done
.shift_on:
    mov byte [shift_pressed], 1
    jmp .done
.shift_off:
    mov byte [shift_pressed], 0
    jmp .done
.done:
    popad
    ret


%include "protected_mode/screen/keyboard/keymap_us.asm"

shift_pressed: db 0
