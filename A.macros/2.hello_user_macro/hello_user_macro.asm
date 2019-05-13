section .data
    %define	SYS_EXIT	1
    %define	SYS_WRITE	4
    %define	SYS_READ	3
    %define	STDOUT		1
    %define STDIN       0

    welcomeMessage db "Saludar al usuario V.1.0",0xa,0xa
    intLenWelcome equ $- welcomeMessage

    firstMessage db "Ingresa tu nombre: "
    intLenFirstMessage equ $- firstMessage

    displayMessage db "---> Hola!  "
    lenDisplayMessage equ $- displayMessage

    charLine db 0xa

section .bss
   name resb 25

section .text
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
    _printString firstMessage, intLenFirstMessage
    call _captureName
    _printString charLine, 1
    _printString displayMessage, lenDisplayMessage
    _printString name, 25
    call _closeProgram
    
_captureName:
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, name
    mov edx, 25
    int 0x80

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
