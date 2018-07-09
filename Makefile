# Define some initial variables.
ifndef arch
$(error arch is not set)
endif

.PHONY: all clean run iso

all: kernel

clean:
    rm -r build

run: iso
    qemu-system-x86_64 -cdrom $(iso)

iso: iso

iso: kernel $(grub_cfg)
    mkdir -p build/isofiles/boot/grub
    cp $(kernel) build/isofiles/boot/kernel.bin
    cp $(grub_cfg) build/isofiles/boot/grub
    grub-mkrescue -o $(iso) build/isofiles 2> /dev/null
    rm -r build/isofiles

kernel: $(assembly_object_files) $(linker_script)
    ld -n -T $(linker_script) -o $(kernel) $(assembly_object_files)

# compile assembly files
build/arch/$(arch)/%.o: src/arch/$(arch)/%.asm
    mkdir -p $(shell dirname $@)
    nasm -felf64 $< -o $@