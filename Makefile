# Define some initial variables.
ifndef arch
$(error arch is not set)
endif

boot_folder := boot/$(arch)/
build_folder := build/

# These files must exist for bootloading
linker_script := linker.ld
linker := $(boot_folder)$(linker_script)
grub_cfg := grub.cfg
grub := $(boot_folder)$(grub.cfg)


# Binary containing kernel bootup steps

kernel_file := kernel-$(arch).bin
kernel := $(build_folder)$(kernel_file)

# OS image
iso_image := os-$(arch).iso
iso := $(build_folder)$(iso_image)

# Gather list of boot files.
assembly_source_files := $(wildcard $(boot_folder)*.asm)
assembly_object_files := $(patsubst $(boot_folder)%.asm, $(boot_folder)%.o, $(assembly_source_files))

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