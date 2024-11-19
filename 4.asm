%include "io64.inc"

section .rodata
e: dd 2.71828
a: dd 3.4
x: dd 1.0
y: dd 0.99777
roun: dd 10000.0

section .bss
e2x: resd 1
num: resd 1
denom: resd 1
;y=th a/x
;ПОЛИЗ a x / th
; th(x)=sh(x)/ch(x)=e^(2x)-1/e^(2x)+1

section .text
global main
main:
    fld dword[a]
    fld dword[x]
    fdiv 
    fadd st0 ; 2*a/x
    
    fld dword[e] ; st0=e st1=2a/x
    fyl2x    ;вычисляем показатель 2a/x*log2(e)
    fld1     ;загружаем 1.0 в стек
    fld st1  ;дублируем показатель в стек
    fprem    ;получаем дробную часть
    f2xm1    ;возводим в дробную часть показателя
    fadd    ;прибавляем 1 из стека
    fscale   ;возводим в целую часть и умножаем
    fstp dword[e2x] ; выталкиваем лишнее из стека
    fstp st0
    
    fld dword[e2x]
    fld1
    fadd
    fstp dword[denom]
    
    fld dword[e2x]
    fld1
    fsub
    fstp dword[num]
    
    fld dword[num]
    fld dword[denom]
    fdiv 
    
    fld dword [roun] 
    fmul             
    frndint          
    fld dword [roun] 
    fdiv             
    
    fld dword[y]
    fld dword [roun] 
    fmul             
    frndint          
    fld dword [roun]
    fdiv
     
    fcomip
    je .label
    PRINT_STRING "NO"
    xor rax, rax
    ret
    
.label:
    PRINT_STRING "YES"
    xor rax, rax
    ret
    
  