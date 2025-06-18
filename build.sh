#!/bin/bash
nasm -f bin bootloader.asm -o bootloader.bin
qemu-system-i386 -drive format=raw,file=bootloader.bin