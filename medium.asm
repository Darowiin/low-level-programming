section .rodata
    a3: dq -2.0             ; a3 = -2.0 (double)
    a1: dd 10.0               ; a1 = 10.0f (float)

section .data
    obj_field0 dd 5          ; field0 = 5
    obj_field1 dd 2          ; field1 = 2
    obj_field2 dd 0x3FC00000 ; field2 = 1.5f (float)

section .text
    extern access2
global main
; xmm1 = xmm0
; xmm0 = 0
; xmm3 = 0
; ecx = 0
; xmm1 = [rdx+4]
; xmm1 *= [rdx+8]
; xmm3 = [rdx]
; xmm1 += xmm0
; xmm0 = 3.0
; xmm0 *= [rdx+0Ch]
; xmm0 += xmm3
; xmm0 -= 1.0
; if xmm1 <= xmm0: jump second
;
; second: 
; xmm0 = -1.0
; if xmm2 < xmm0: cl = 1
main:
    mov rbp, rsp

    ; Загружаем a1 (float) в xmm0
    movss xmm0, [a1]              ; xmm0 = a1 (10.0f)

    ; Загружаем a3 (double) в xmm2
    movsd xmm2, [a3]            ; xmm2 = a3 (-2.0)

    ; Загружаем адрес структуры в rdx (это начало структуры)
    lea rdx, [obj_field0]         ; rdx = адрес структуры obj (начало объекта, т.е. obj_field0)

    
    sub rsp, 40
    call access2
    add rsp, 40
    
    xor rax, rax
    ret
