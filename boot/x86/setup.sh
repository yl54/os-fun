# Setup initial variables from args provided.
# Assume that the architecture is the first arg

arch="${1}"
boot_folder="boot/${arch}/"
build_folder="build/"

# These files must exist for bootloading
linker_script="linker.ld"
linker="${boot_folder}${linker_script)}"
grub_cfg="grub.cfg"
grub="${boot_folder}${grub.cfg}"

# Binary containing kernel bootup steps
kernel_file="kernel-${arch}.bin"
kernel="${build_folder}${kernel_file}"

# OS image
iso_image="os-${arch}.iso"
iso="${build_folder}${iso_image}"

# Gather list of boot files.
# I don't believe this is correct.
assembly_source_files=$(wildcard $(boot_folder)*.asm)
assembly_object_files=$(patsubst $(boot_folder)%.asm, $(boot_folder)%.o, $(assembly_source_files))

# Function to copy files to isofiles

# Function to build the object files

# Function to clean the build 

# Function to link object files

# Function to pick which function to redirect to



# 