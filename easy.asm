%include "io64.inc"

section .data
    a1 dq 1.706          ; Значение a1 (double)
    a2 dd 1            ; Значение a2 (int)
    a3 dd 0.785398     ; Значение a3 (float)
    a4 dq 10.0         ; Значение a4 (double)

section .text
    extern access2
    global main

main:
    push rbp
    mov rbp, rsp
    
    ; Загружаем значения в регистры
    movsd xmm0, qword[a1]  ; Загружаем a1 (double) в xmm0
    mov edx, [a2]          ; Загружаем a2 (int) в edx
    movss xmm2, dword[a3]  ; Загружаем a3 (float) в xmm1
    movsd xmm3, qword[a4]  ; Загружаем a4 (double) в xmm2
    
    ; Вызываем access2
    sub rsp, 32
    call access2
    add rsp, 32
    leave
    xor rax, rax
    ret
