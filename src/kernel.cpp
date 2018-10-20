// We dont have access to the OS std I/O, so we need to leverage on the black/white
// video card setting on memory 0xb8000.
// The text screen video memory for colour monitors resides at 0xB8000, and for monochrome monitors it is at address 0xB0000

void printf(char *str)
{
    unsigned short *VideoMemory = (unsigned short *)0xb8000;

    for (int i = 0; str[i] != '\0'; ++i)
        VideoMemory[i] = (VideoMemory[i] & 0xFF00) | str[i];
}

// Define extern "C" to prevent G++ from changing this name when writing to the .o file
extern "C" void kernelMain(void *multiboot_structure, unsigned int magicnumber)
{
    printf("Hello, Kotani OS");
    while (1)
        ;
}
