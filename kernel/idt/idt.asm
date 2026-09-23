extern kernel_panic

%include "kernel/idt/gates/double_fault.asm"
%include "kernel/idt/gates/isr_stub.asm"
%include "kernel/idt/irq/timer.asm"
%include "kernel/idt/irq/keyboard.asm"

%include "kernel/idt/pic_remap.asm"
%include "kernel/idt/idt_msg.asm"

