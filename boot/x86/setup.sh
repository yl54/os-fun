#!/bin/bash
# Check if ^ is needed or not

# This sets up an x86 image.
# Need some debug statements to make sure things work.

# The arg is the choice to run.
choice=$1;

# Function to print the makefile variables.
function _printVariables() {
    echo "$boot_folder: ${boot_folder}";
    echo "$build_folder: ${build_folder}";
    echo "$linker_script: ${linker_script}";
    echo "$linker: ${linker}";
    echo "$grub_cfg: ${grub_cfg}";
    echo "$grub: ${grub}";
    echo "$kernel_file: ${kernel_file}";;
    echo "$iso_image: ${iso_image}";
    echo "$iso: ${iso}";
    echo "$assembly_source_files: ${assembly_source_files}";
    echo "$build_isofiles: ${build_isofiles}";
    echo "$build_boot: ${build_boot}";
    echo "$build_grub: ${build_grub}";
}

# Function to build the object files
# NOT UNDERSTOOD
function _buildObjectFiles() {
	
	# Make the build directory
    mkdir -p $build_boot;

	# Copy the boot assembly files from boot/ to build/
    cp $assembly_source_files $build_boot;

	# Compile the assembly files in the build directory.
    assembly_object_files=$(patsubst $(boot_folder)/%.asm, $(build_boot)/%.o, $(assembly_source_files));
    nasm -f elf64 $assembly_source_files;
}

# Function to link object files
# UNDERSTOOD
function _linkObjectFiles() {
	# link the linker script into the kernel binary via the object files provided.
	# These object files should be in the build directory.
	ld -n -T $linker_script -o $kernel $assembly_object_files;
}

# Function to create an image
# UNDERSTOOD
function _createImage() {
	# Make the destination directory
	mkdir -p $build_grub;

	# Copy the kernel and grub config into the folder.
    cp $kernel "${build_boot}/kernel.bin";
    cp $grub "${build_boot}/grub";

    # Create the image
    grub-mkrescue -o $iso build/isofiles 2> /dev/null;

    # Cleanup
    rm -r build/isofiles;
}

# Function to run the image. This implementation runs on qemu.
# UNDERSTOOD
function _run() {
	qemu-system-x86_64 -cdrom $iso;
}

func _getAssemblyObjectFiles()
# Function to pick which function to redirect to
function _choice() {
    if [ $choice -eq "print" ]; then
        _printVariables();
	if [ $choice -eq "build" ]; then
		_buildObjectFiles();
	elif [ $choice -eq "link" ]; then
		_linkObjectFiles();
	elif [ $choice -eq "create" ]; then
		_createImage();
	elif [ $choice -eq "run" ]; then
		_run();
	fi
}

# Call redirect function
_choice();