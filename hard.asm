section .data
    ; Данные для a1
    a1_values: dq 2               ; a1[0] (например, целое число)
               dq array_values    ; a1[1] (указатель на массив)

    ; Массив значений для a1[1] (массив типа double)
    array_values: dq 2.0, 2.5, 3.0, 1.5

    ; Данные для a2 (объект типа C, например)
    a2_values: dq 1.0            ; a2[0] (double)
               dq 2.0            ; a2[1] (double)
               dq 1.0            ; a2[2] (double)

    ; Значение для a3 (int)
    a3_value:  dd -1              ; a3 = -1
    
section .text
    extern access2        
    global main   
; _int64 __fastcall access2(__int64 *a1, const __m128i *a2)
; __int64 v3; // r8
; __int64 v4; // rax
; char v5; // al
; __m128i v7; // [rsp+20h] [rbp-38h] BYREF
; __int64 v8; // [rsp+30h] [rbp-28h]
; __int64 v9[2]; // [rsp+40h] [rbp-18h] BYREF
;
; v3 = a1[1];
; v9[0] = *a1;
; v9[1] = v3;
; if ( v9[0] <= 1ui64 )
;   check(0);
; if ( !a2->m128i_i64[0] )
;   check(0);
; v4 = a2[1].m128i_i64[0];
; v7 = _mm_loadu_si128(a2);
; v8 = v4;
; v5 = hard::var2::C::check(v9, &v7);
; return check(v5);
;
; -> v9[0] = [rsp+40h] > 1 -> a1[0] > 1
; a1[1] (-inf;inf)
; a2[0], a2[1] (-inf;0) (0;inf)
; a3 < -1
main:
    push rbp
    mov rbp, rsp

    ; Передача параметров в access2
    lea rcx, [a1_values]  ; a1 -> rcx
    lea rdx, [a2_values]  ; a2 -> rdx

    ; Вызов функции access2
    call access2

    ; Завершение выполнения
    xor rax, rax
    leave
    ret