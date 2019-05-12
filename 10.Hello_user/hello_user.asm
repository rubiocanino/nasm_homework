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

_start:
    call _printWelcome
    call _printMessage1
    call _captureName
    call _printLine
    call _printHiUser
    call _printName
    call _closeProgram

_printWelcome:
    mov edx, intLenWelcome
    mov ecx, welcomeMessage
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80

_printMessage1:
    mov edx, intLenFirstMessage
    mov ecx, firstMessage
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80
    
_captureName:
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, name
    mov edx, 25
    int 0x80

_printHiUser:
    mov edx, lenDisplayMessage
    mov ecx, displayMessage
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80

_printName:
    mov edx, 25
    mov ecx, name
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 80h
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
