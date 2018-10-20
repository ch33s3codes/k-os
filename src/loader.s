.set MAGIC, 0x1badb002              # Since bootloader doesn't recognize this as a kernel (due to lack of a metric number)  
.set FLAGS, (1<<0 | 1<<1)           # Set some flags as well
.set CHECKSUM, -(MAGIC + FLAGS)     # Set the checksum (to Negative of Metric Number - The Flags)

.section .multiboot                 # Add the metric number to the .o file
    .long MAGIC
    .long FLAGS
    .long CHECKSUM


.section .text
.extern kernelMain
.global loader

loader:
    mov $kernel_stack, %esp
    push %eax
    push %ebx
    call kernelMain

_stop:
    # Sanity Check => Ensure infinite loop is indeed infinite :-)
    cli
    hlt
    jmp _stop

.section .bss
.space 2*1024*1024; # 2 MiB
kernel_stack: