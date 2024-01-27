section .data
    message db 'Hola, mundo!', 0

section .text
    global _start

_start:
    ; Imprimir el mensaje en la consola
    mov eax, 4
    mov ebx, 1
    mov ecx, message
    mov edx, 13
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
