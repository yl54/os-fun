; global is a nasm specific directive to export symbols in
;   this code to where it points in the object code generated.
; start will be added to the object (___.o) file.
; the linker will read this symbol so it knows where to mark
;   the as an entrypoint in the output executable. 
global start

; the .text section is the default location for executable code.
section .text

; specify that these are 32 bit instructions. in this case, the
;   cpu is in protected mode when GRUB starts the kernel.
bits 32

start:
    ; print 'ok' to the screen
    mov dword [0xb8000], 0x2f4b2f4f
    hlt