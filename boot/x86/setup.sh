#!/bin/bash
# Check if ^ is needed or not

# This sets up an x86 image.

choice=$1

# Function to build the object files
function _buildObjectFiles() {
	src/arch/$(arch)/%.asm;
    mkdir -p $(shell dirname $@)

    # Compile the object files into elf64 format.
    nasm -elf64 $< -o $@
}

# Function to link object files
function _linkObjectFiles() {
	ld -n -T $linker_script -o $kernel $assembly_object_files
}

# Function to create an image
function _createImage() {
	# Make the destination directory
	mkdir -p $build_grub

	# Copy the kernel and grub config into the folder.
    cp $kernel build/isofiles/boot/kernel.bin
    cp $grub_cfg build/isofiles/boot/grub

    # Create the image
    grub-mkrescue -o $iso build/isofiles 2> /dev/null

    # Cleanup
    rm -r build/isofiles;
}

# Function to run the image
function _run() {
	qemu-system-x86_64 -cdrom $iso
}

# Function to pick which function to redirect to
function _choice() {
	if [ $choice -eq "build" ]; then
		_buildObjectFiles()
	elif [ $choice -eq "link" ]; then
		_linkObjectFiles()
	elif [ $choice -eq "create" ]; then
		_createImage()
	elif [ $choice -eq "run" ]; then
		_run()
	fi
}

# Call redirect function
_choice()