%include "io64.inc"

section .rodata
    x: dd -5.6

section .bss
    result: resd 1       ; Результат округления
    
section .text
global main

main:
    mov rbp, rsp

    sub rsp, 8           ; Выделяем место для слова управления FPU
    fstcw [rsp]          ; Сохраняем текущее слово управления FPU
    mov ax, [rsp]        ; Загружаем сохранённое слово управления
    or ax, 0x0400        ; Устанавливаем RC = 01 (округление вниз)
    mov [rsp], ax      ; Сохраняем новое слово управления
    fldcw [rsp]        ; Загружаем изменённое слово управления
    
    fld dword[x]
    
    fist dword [result] ; Округляем вниз и сохраняем результат в памяти
    
    fldcw [rsp]          ; Восстанавливаем оригинальное слово управления
    add rsp, 8           ; Освобождаем стек
    mov eax, [result]    ; Возвращаем результат в eax
    
    PRINT_DEC 4, eax
    ret
