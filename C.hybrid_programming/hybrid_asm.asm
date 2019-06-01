; Para ejecutar este programa:
;nasm  -f elf64 -o hp64.o -l hp64.lst hybrid_asm.asm
;ld hp64.o  -o hp64  -lc  --dynamic-linker /lib64/ld-linux-x86-64.so.2 
;./hp64

section .data
    %define	SYS_EXIT	1
    %define	SYS_WRITE	4
    %define	SYS_READ	3
    %define	STDOUT		1
    %define STDIN       0

    welcomeMessage db "Hybrid Programming V.1.0",0xa
    intLenWelcome equ $- welcomeMessage

    firstText db "Este programa esta hecho en NASM y C",0xa,0xa
    intLenFirstMessage equ $- firstText

    fmt     db "%u  %s",10,0
    msg1    db "Hello world!",0
    msg2    db "Usando printf de C",0

section .text
    extern printf
    global _start

    %macro _printString 2 
        mov   eax, SYS_WRITE
        mov   ebx, STDOUT
        mov   ecx, %1
        mov   edx, %2
        int   80h
    %endmacro  

_start:
    _printString welcomeMessage, intLenWelcome
    _printString firstText, intLenFirstMessage
    mov  edx, msg1
    mov  esi, 1     ; Usamos esi para enviar el parametro "1"
    mov  edi, fmt   ; Usamos edi para enviar el formato para imprimirse en C
    mov  eax, 0     
    call printf     ; Llamamos printf libreria de C

    mov  edx, msg2
    mov  esi, 2     ; Usamos esi para enviar el parametro "2"
    mov  edi, fmt   ; Usamos edi para enviar el formato para imprimirse en C
    mov  eax, 0     
    call printf     ; Llamamos printf libreria de C

    mov  ebx, 0     ; return value
    mov  eax, 1
    int  0x80

    jmp _closeProgram
 
_closeProgram:
    mov eax, SYS_EXIT
    int 0x80
    ret

