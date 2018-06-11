/* This is where the entrypoint is defined for the ELF. */
Entry(start)

SECTIONS {
    . = 1M

    .boot :
    {
        /* Ensure the multiboot header is at the beginning. */
        *(.multiboot_header)
    }

    .text :
    {
        *(.text)
    }
}
