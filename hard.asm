section .rodata

section .text
    extern access2
global main

main:
    mov rbp, rsp; for correct debugging
    
    sub rsp, 32

    call access2
    
    add rsp, 32
    
    xor rax, rax
    ret