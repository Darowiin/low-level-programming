%include "io64.inc"

section .rodata
    space db ' ', 0
    fmt_dec db "%d", 0
    fmt_input_prompt db "Enter array size: ", 0
    fmt_elements_prompt db "Enter array elements: ", 0
    fmt_output_prompt db "Sorted array: ", 0

CEXTERN printf
CEXTERN scanf
CEXTERN malloc
CEXTERN free
CEXTERN puts

section .text
global main
main:
    push rbp
    mov rbp, rsp
    sub rsp, 32              ; Выделяем место для локальных переменных
    
    lea rcx, [fmt_input_prompt]
    call printf              ; printf("Enter array size: ")
    
    lea rcx, [fmt_dec]
    lea rdx, [rbp-4]        ; Адрес переменной n
    call scanf              ; scanf("%d", &n)

    mov eax, dword [rbp-4]  ; Проверяем n > 0
    test eax, eax
    jle cleanup          ; Выход если n <= 0, для отладки
    
    mov eax, dword [rbp-4]  ; Загружаем значение n
    mov edx, eax
    mov r13d, eax
    lea ecx, [fmt_dec]       ; Строка формата для вывода числа
    call printf
    lea ecx, [space]
    call puts
    
    ; --- Выделение памяти ---
    mov eax, r13d     ; Загружаем количество элементов массива (n)
    imul rax, rax, 4           ; Результат записывается в 64-битный rax
    mov rdi, rax               ; Аргумент для malloc
    call malloc
    mov [rbp-8], rax           ; Сохраняем указатель массива
    test rax, rax
    jz cleanup                 ; Если malloc вернул NULL, завершение

    ; --- Ввод элементов массива ---
    lea rcx, [fmt_elements_prompt]
    call printf                ; printf("Enter array elements: ")

    xor r8d, r8d               ; i = 0

input_loop:
    mov eax, r13d
    cmp r8d, eax     ; i < n ?
    jge sort_start
    
    mov rax, [rbp-8]           ; Адрес массива
    lea rcx, [fmt_dec]         ; Формат "%d"
    lea rdx, [rax + r8*4]      ; Адрес mass[i]
    call scanf                 ; scanf("%d", &mass[i])
    
    lea rcx, [fmt_dec]   ; строка формата
    mov edx, dword[rax + r8*4]
    call printf
    lea rcx, [space]
    call puts
    
    inc r8d
    jmp input_loop

    ; --- Сортировка вставками ---
sort_start:
    mov dword [rbp-12], 1      ; i = 1

start_sort:
    mov eax, dword [rbp-12]
    cmp eax, r13d
    jge output_sorted_array

    mov r8d, eax               ; r8d = i
    mov rax, [rbp-8]           ; Адрес массива
    mov eax, [rax + r8*4]      ; newElement = mass[i]
    mov dword [rbp-16], eax    ; Сохраняем newElement
    dec r8d                    ; location = i - 1

check_condition:
    cmp r8d, -1
    jl insert_element

    mov rax, [rbp-8]           ; Адрес массива
    mov eax, [rax + r8*4]      ; mass[location]
    cmp eax, [rbp-16]          ; Сравниваем mass[location] и newElement
    jle insert_element

    ; Сдвиг элементов массива
    mov rax, [rbp-8]           ; Адрес массива
    mov eax, [rax + r8*4]
    mov [rax + r8*4 + 4], eax
    dec r8d
    jmp check_condition

insert_element:
    mov rax, [rbp-8]           ; Адрес массива
    lea rcx, [rax + r8*4 + 4]  ; mass[location + 1]
    mov eax, [rbp-16]          ; newElement
    mov [rcx], eax

    add dword [rbp-12], 1      ; i++
    jmp start_sort

    ; --- Вывод массива ---
output_sorted_array:
    lea rcx, [fmt_output_prompt]
    call printf                ; printf("Sorted array:\n")

    xor r8d, r8d

output_loop:
    cmp r8d, r13d
    jge cleanup

    mov rax, [rbp-8]           ; Адрес массива
    mov eax, [rax + r8*4]      ; mass[i]
    lea rcx, [fmt_dec]         ; Строка формата
    call printf                ; printf("%d", mass[i])
    inc r8d
    jmp output_loop

    ; --- Очистка памяти ---
cleanup:
    mov rax, [rbp-8]
    test rax, rax
    jz end_program
    mov rcx, rax
    call free                  ; free(mass)

end_program:
    mov rsp, rbp
    pop rbp
    ret