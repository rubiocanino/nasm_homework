section .data
    %define	SYS_EXIT	1
    %define	SYS_WRITE	4
    %define	SYS_READ	3
    %define	STDOUT		1
    %define STDIN       0
    
    welcomeMessage db "Escribir Archivo V.1.0",0xa,0xa
    intLenWelcome equ $- welcomeMessage

    fileMessage db "Creando archivo...",0xa
    lenFileMessage equ $- fileMessage

    creating db "Creando archivo...",0xa
    lenCreating equ $- creating

    created db "Archivo exitosamente creado",0xa
    lenCreated equ $- created

    message db "Archivo de ejemplo",0xa
    lenMessage equ $- message
    
    fileName db "file.txt",0
    lenFileName equ $- fileName

    delay dq 2,2000000
    
    fd dq 0

section .text
    global _start          ;must be declared for linker (ld)

_start:
    call _printWelcome 
    call _printCreating
    call _sleep
    call _createFile
    call _printCreated
    call _closeProgram

_printWelcome:
    mov edx, intLenWelcome
    mov ecx, welcomeMessage
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80


_printCreating:
    mov edx, lenCreating
    mov ecx, creating
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80

_printCreated:
    mov edx, lenCreated
    mov ecx, created
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80

_sleep:
    mov rax, 35
    mov rdi, delay
    mov rsi, 0
    syscall 

_createFile:
    mov rdi, fileName
    mov rsi, 0102o      ;O_CREAT, man open
    mov rdx, 0666o      ;umode_t
    mov rax, 2
    syscall

    mov [fd], rax
    mov rdx, lenMessage ;message length
    mov rsi, message    ;message to write
    mov rdi, [fd]       ;file descriptor
    syscall             ;call kernel

    mov rdi, [fd]
    mov rax, 3         ;sys_close
    syscall

    mov rax, 60        ;system call number (sys_exit)
    syscall            ;call kernel

_closeProgram:
    mov eax, SYS_EXIT
    syscall
