ENTRY(pmode)

SECTIONS {
    . = 0x10000;

    .text : { *(.text) }
    .rodata : { *(.rodata) }
    .data : { *(.data) }
    .bss : { *(.bss) }

    .init_array : {
        __init_array_start = .;
        *(.init_array)
        __init_array_end = .;
    }
}
