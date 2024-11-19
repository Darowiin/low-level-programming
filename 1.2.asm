%include "io64.inc"

section .rodata
    x: dd -5.6

section .bss
    result: resd 1       ; Результат округления

section .text
global main

main:
    mov rbp, rsp
    
    sub rsp, 8          ; Сохраняем MXCSR и выравниваем стек
    stmxcsr [rsp]
    mov ax, [rsp]       ; Загружаем MXCSR
    or ax, 0x0400   ; Устанавливаем округление вниз
    mov [rsp], ax
    ldmxcsr [rsp]      ; Загружаем изменённый MXCSR
    
    movsd xmm0, [x]
    
    roundss xmm0, xmm0, 0
    cvtss2si eax, xmm0
    mov [result], eax    ; Сохраняем результат в памяти
    
    ldmxcsr [rsp]        ; Восстанавливаем оригинальный MXCSR
    add rsp, 8          ; Освобождаем стек
    mov eax, [result]    ; Возвращаем результат в eax
    
    PRINT_DEC 4, eax
    ret