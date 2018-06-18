# GRUB

## Properties

* Boot loader
    * First software program to run when a computer starts
    * Loads and transfers control to an operating system kernel software
    * Kernel initializes the rest of the operating system
* GNU GRUB
    * `GRand Unified Bootloader`
    * It is a very powerful disk-based boot loader
    * Can load many operating systems
    * Flexibility
        * GRUB understands filesystems and kernel executable formats
        * Load an arbitrary operating system the way we choose
        * Don't need to record physical location of kernel on the disk
        * Only need to specify the drive + partition to find kernel

## Features

* Multiboot Specification compliance
    * Basic functions should be straightforward for end users
    * Rich functionality to support kernel designers
    * Backward compatability to load free kernels
        * FreeBSD, NetBSD, OpenBSD, and Linux
        * Proprietary kernels can be loaded via chain booting
* Feature Support
    * Recognize multiple executable formats
        * `.out`, ELF, symbol tables
    * Support non-Multiboot kernels
        * Support various kernels that lack multiboot compliance
    * Load multiples modules
    * Load a configuration file
        * Support a text file with preset boot commands
    * Provide a menu interface
    * Provide a flexible command line interface
    * Support multiple filesystem types
    * Support automatic decompression
        * Decompress files of gzip or xz
        * Some kernels are better off loaded in a compressed state
        * May reduce loading time by alot
    * Access data on any installed device
        * Support reading data from any local persistent storage recognized by BIOS  
        * Independent of root device settings
    * Independent of drive geometry translations
        * Other boot loaders dependent on drive translation
        * A drive with one translation may be translated to something else
    * Detect all installed RAM
        * Use a BIOS query to find all memory regions
        * Kernels need to accomodate for this knowledge
        * Not compatible with all kernels, but GRUB will work for those that do
    * Support Logical Block Address Mode
        * Traditional Disk calls have geometry translation problem
            * Have lower and upper bound limits on available disk to access
        * Newer machines have Logical Block Address
            *  Allows GRUB to access entire disk
    * Support network booting
        * Can load OS over network via TFTP protocol
    * Support remote terminals 
        * Need to support computers with no terminal

## Configuration

