section .multiboot_header
header_start:
    dd 0xe85250d6                 ; magic number
    dd 0                          ; architecture 0 (protected mode i386)
    dd header_end - header_start  ; header length

    ; checksum
    dd 0x10000000 - (0xe85250d6 + 0 + (header_end - header_start))

    ; optional multiboot tags if necessary

    ; required end tag
    dw 0    ; type
    dw 0    ; flags
    dd 8    ; size
header_end:

