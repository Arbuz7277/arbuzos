[bits 32]

%include "protected_mode/idt/gates/8df.asm"
%include "protected_mode/idt/irq/0timer.asm"
%include "protected_mode/idt/irq/keyboard.asm"

isr_stub:
    mov esi, msg_stub
    call kernel_panic


%macro IDT_ENTRY 1
    dw (%1- $$ + 0x10000 & 0xFFFF)
    dw 0x08
    db 0
    db 0x8E
    dw (((%1 - $$ + 0x10000) >> 16) & 0xFFFF)
%endmacro

idt_start:
    %assign i 0
    %rep 48
        %if i == 8
            IDT_ENTRY double_fault
        %elif i == 32
            IDT_ENTRY irq0
        %elif i == 33
            IDT_ENTRY irq1
        %else
            IDT_ENTRY isr_stub
        %endif
        %assign i i+1
    %endrep

idt_end:

idt_descriptor:
    dw idt_end - idt_start - 1
    dd idt_start
