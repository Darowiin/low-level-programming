section .data
max_: dd 20 ; Максимальное количество итераций для вычисления ряда Тейлора

section .rodata
value: dd 4.9 ; cos(4,9)=0,18651236942
a: dd 1.0
min_one: dd -1.0 ; Константа -1.0, используемая для смены знака членов ряда
two: dd 2.0
three: dd 3.0
two_pi: dd 6.28318530 ; 2π для редукции угла
  
section .bss
x: resd 1

section .text
global main

cos:
    movss xmm0, [value] 
    movss xmm4, [two_pi]
    movss xmm8, [a]
.cycle_start: 
    comiss xmm0,xmm4 ; Сравниваем x с 2π
    ja .cycle_sub            ; Если x > 2π, вычитаем 2π из x
    
    mulss xmm0, xmm0 ;x^2
    mulss xmm0, [min_one] ;-x^2
    
    movss xmm3, [a] ;1 - нулевой член
    mov ecx, 1
.cycle_cos:   
    cmp ecx, [max_] ; Проверяем, достигли ли мы максимального числа итераций
    je .cycle_end
    
    mov eax, ecx             ; Получаем текущий номер итерации
    shl eax, 1               ; Умножаем на 2 (для степени x^2, x^4, x^6...)
    mov edx, eax             ; Сохраняем 2n в edx
    sub eax, 1               ; eax = 2n - 1
    mul edx                  ; Умножаем (2n)(2n-1)
    
    cvtsi2ss xmm9, eax       ; Преобразуем число в вещественное
    movss xmm10, xmm0 ; Копируем x^2 в xmm10
    divss xmm10, xmm9 ;-x^2/2n(2n-1)
    mulss xmm8, xmm10 ; Умножаем на текущий коэффициент ряда

    addss xmm3, xmm8 ; Накопление результата в xmm3

    
    add ecx, 1 ; Переходим к следующей итерации
    jmp .cycle_cos
.cycle_sub:
    subss xmm0, xmm4 ; x = x - 2π
    jmp .cycle_start
.cycle_end:
    movss [x], xmm3 ; Сохраняем результат в переменную x
    xor rax, rax
    ret
    
main:
    mov rbp, rsp; for correct debugging
    call cos
    xor eax, eax
    ret