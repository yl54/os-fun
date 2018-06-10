# Bios Notes

## Properties

* Exists in every PC
* Provides a set of routines for hardware to interact with the operating system
* Has instructions for initial boot process
* Common theme is that there's lots of pregramming
    * JMP to specific addresses
    * Scan a range of addresses for _____

## Basic Steps

1) Power applied to computer

* Power is applied to the system
* Power supply generates a power good signal and sends to motherboard timer
* Motherboard timers stops sending reset signal to CPU
* CPU begins processing instructions

2) Actual boot
    
* CPU reads contents of preprogrammed into CPU
    * Usually is the memory address FFFF:0000h
    * Last 16 bytes of memory in first MB of memory
* Contains a JMP command to go find place for BIOS instructions

3) POST
    
* Power On Self Test
* Routines initialize and test the hardware
* BIOS tests the motherboard hardware
* BIOS looks for video read only memory (ROM)
    * BIOS does checksum verification with contents
    * Success --> initialize it
* BIOS looks for other ROM that may exist within some range
    * Examples
        * Network adapter cards
        * SCSI adapter cards
    * Performs checksum tests for those as well
* BIOS checks address 0000:0472h
    * Contains a flag indicating warm or cold boot
* Warm boot
    * BIOS skips remaining POST routines
* Cold boot
    * Runs remaining POST routines
* POST tests precluded with hex decimal code to port ____
    * Port number depends on PC model

4) Looking for operating system

* Look somewhere on disk for an operating system
    * DOS Volume Boot Sector 
    * Master partition boot sector
* Load onto memory location ______
* Continue to look for boot devices
* BIOS loads Volume Boot Sector (VBS)
    * The first sector of a partition
* Look for bootable partitions
* Load an active VBS and test it
* Start loading the operating system

## Plug and Play

* A few elements must be written to certain standards
    * Motherboard BIOS
    * Operating System
    * Boards and peripherals
* Basic procedure
    * System checks what resources are needed for each expansion device
    * System coordinates assignments to IRQ's, DMA's and I/O Ports to avoid conflicts
    * System tells the software what choices it has made
* How it works
    * BIOS must be able to communicate with expansion boards
    * Board must be able to deacitvate from normal signals toa avoid signals with other devices
    * Each board has registers that can be accessed through normal I/O port addresses
        * Allow BIOS and OS to configure the board
        * Ports: Address, Write Data and Read Data
