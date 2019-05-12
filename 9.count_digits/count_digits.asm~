section .data
    %define	SYS_EXIT	1
    %define	SYS_WRITE	4
    %define	SYS_READ	3
    %define	STDOUT		1
    %define STDIN       0

    welcomeMessage db "Contador de digitos V.1.0",0xa,0xa
    intLenWelcome equ $- welcomeMessage

    charLine db 0ax

section	.bss
    num resb 1

section	.text
   global _start

_start:
    mov eax,SYS_WRITE
    mov ebx,STDOUT
    mov ecx,welcomeMessage
    mov edx,intLenWelcome
    int 0x80

    mov ecx,10
    mov eax, '1'

_loop:
    mov [num], eax
    mov eax, 4
    mov rbx, 1
    push rcx

    mov ecx, num        
    mov edx,1        
    int 0x80

    call _printLine

    mov eax, [num]
    sub eax, '0'
    inc eax
    add eax, '0'
    pop rcx
    loop _loop

    call _closeProgram

_printLine:
    mov eax,SYS_WRITE
    mov ebx,STDOUT
    mov ecx,charLine
    mov edx,1
    int 80h
    ret

_closeProgram:
    mov eax, SYS_EXIT
    int 0x80
