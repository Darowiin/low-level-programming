%include "io64.inc"

section .bss
    mass resd 100           ; Массив для хранения чисел (100 элементов)
    n resd 1                ; Переменная для размера массива
    newElement resd 1       ; Переменная для нового элемента в сортировке
    location resd 1         ; Переменная для позиции в сортировке
    i resd 1                ; Счетчик цикла

section .text
global main
main:
    mov rbp, rsp            ; for correct debugging
    ; Запросить размер массива
    GET_UDEC 4, n
    
    ; Вывод значения n для отладки
    PRINT_STRING "Size of the array is: "
    PRINT_DEC 4, n        ; Выводим значение n
    NEWLINE
    PRINT_STRING "Array: "
    
    ; Ввод элементов массива
    mov ecx, 0              ; Устанавливаем начальный индекс i = 0
input_loop:
    cmp ecx, [n]
    jge sort_start
    GET_DEC 4, [mass + ecx*4]
    
    ; Вывод элементов массива для отладки
    PRINT_DEC 4, [mass + ecx*4]
    PRINT_STRING " "
    
    inc ecx
    jmp input_loop
sort_start:
    NEWLINE
    mov dword [i], 1

start_sort:
    mov ecx, [i]
    cmp ecx, [n]
    jge end_sort            ; Переход к выводу, если i >= n

    mov ecx, [mass + ecx*4] ; newElement = mass[i]
    mov [newElement], ecx
    mov ebx, [i]
    dec ebx
    mov [location], ebx     ; location = i - 1

check_condition:
    cmp dword [location], -1
    jl insert_element       ; Переход к вставке, если location < 0

    mov ecx, [location]
    mov eax, [mass + ecx*4]
    cmp eax, [newElement]
    jle insert_element      ; Переход к вставке, если mass[location] <= newElement

    ; Сдвиг элементов массива
    mov eax, [mass + ecx*4]
    mov [mass + ecx*4 + 4], eax ; Сдвигаем элемент на одну позицию вправо
    dec dword [location]    ; location--

    jmp check_condition

insert_element:
    mov ecx, [location]
    inc ecx
    mov eax, [newElement]
    mov [mass + ecx*4], eax ; Вставка нового элемента

    inc dword [i]           ; i++
    jmp start_sort          ; Переход к следующей итерации сортировки

end_sort:
    PRINT_STRING "Sorted array: "
    mov eax, 0              ; Устанавливаем начальный индекс i = 0

output_loop:
    cmp eax, [n]
    jge end_program

    mov ebx, [mass + eax*4]
    PRINT_DEC 4, ebx
    PRINT_STRING " "

    inc eax
    jmp output_loop

end_program:
    xor eax, eax            ; Возвращаем 0 как код завершения
    ret
