#!/bin/bash
#the script to compile all the source into kernel.bin, a raw binary representat-
#ion of the data that should be on the boot device.

CROSS_COMPILER_PATH="$HOME/opt/cross/bin" #edit as you see fit
NASM_COMPILER_PATH="$HOME/opt/cross/bin:$PATH" #edit as you see fit
QEMU_EXECUTABLE_PATH="$HOME/opt/cross/bin:$PATH" #edit as you see fit
#^^^ I didn't edit any of these because if you use arch/manjaro and use pacman
#to install the 'qemu', 'nasm' and 'i686-elf-gcc' packages they are already in
#the right place. If you do not have that option available, follow this:
# (https://wiki.osdev.org/GCC_Cross-Compiler) tutorial for making the
#compiler and as for installing nasm and qemu, it is really easy.

export PATH="$CROSS_COMPILER_PATH:$PATH" #this should be fine as is
export TARGET="i686-elf" #edit as you see fit

nasm -f elf ./asm/*.asm #to compile all the assembly files
#^^^ compile the assembly files

$CROSS_COMPILER_PATH/$TARGET-gcc *.cpp ./asm/*.o -o kernel.bin -nostdlib -ffree\
standing -std=c++11 -mno-red-zone -fno-exceptions -nostdlib -fno-rtti -Wall -We\
xtra -Werror -T linker.ld -I./include/
#^^^ compile the c, cpp and o files from the assembly stage and link them using
# linker.ld into kernel.bin, our raw binary file.


qemu-system-x86_64 -fda kernel.bin
#run the binary with qemu
#if you can implement bochs into this, please do.
