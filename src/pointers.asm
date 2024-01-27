section .data
    input_msg db "Ingresa una cadena: ", 0
    output_msg db "La cadena dividida es: ", 0

section .bss
    input_buffer resb 100
    output_buffer resb 100

section .text
    global _start

_start:
    ; Imprimir mensaje de entrada
    mov eax, 4
    mov ebx, 1
    mov ecx, input_msg
    mov edx, 17
    int 0x80

    ; Leer cadena de entrada
    mov eax, 3
    mov ebx, 0
    mov ecx, input_buffer
    mov edx, 100
    int 0x80

    ; Dividir la cadena utilizando un puntero
    mov esi, input_buffer
    mov edi, output_buffer

    mov al, byte [esi] ; Obtener el primer carácter de la cadena

    ; Iterar hasta encontrar el carácter nulo
    cmp al, 0
    je end_loop

    ; Imprimir el carácter actual
    mov [edi], al
    inc edi

    ; Mover al siguiente carácter
    inc esi
    jmp start_loop

start_loop:
    mov al, byte [esi] ; Obtener el siguiente carácter de la cadena

    ; Verificar si es un espacio en blanco o un carácter nulo
    cmp al, ' '
    je end_loop
    cmp al, 0
    je end_loop

    ; Imprimir el carácter actual
    mov [edi], al
    inc edi

    ; Mover al siguiente carácter
    inc esi
    jmp start_loop

end_loop:
    ; Imprimir mensaje de salida
    mov eax, 4
    mov ebx, 1
    mov ecx, output_msg
    mov edx, 22
    int 0x80

    ; Imprimir la cadena dividida
    mov eax, 4
    mov ebx, 1
    mov ecx, output_buffer
    mov edx, edi ; Longitud de la cadena dividida
    sub edx, output_buffer ; Calcular la longitud
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
