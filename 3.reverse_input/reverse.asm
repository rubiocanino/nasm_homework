section .data

    %define	SYS_EXIT	1
    %define	SYS_WRITE	4
    %define	SYS_READ	3
    %define	STDOUT		1
    %define STDIN       0

    welcomeMessage db "Reverse V.1.0",0xa,0xa
    intLenWelcome equ $- welcomeMessage

	inputNameMessage db "What's your name ? : ",0xa
    intLenNameMessage equ $- inputNameMessage

    inputName times 64 db 0, 0xa 
    max equ 64

    charLine db 0ax

section .text
    global _start

_start:
    call _printWelcome
    call _printMessage1
    call _captureName
    call _function
    call _closeProgram
    call _printLine
    call _printResult

_printWelcome:
    mov edx, intLenWelcome
    mov ecx, welcomeMessage
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80

_printMessage1:
    mov edx, intLenNameMessage
    mov ecx, inputNameMessage
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80


_captureName:  
    mov rdx,max
    mov rsi,inputName
    mov rdi,0
    mov rax,0
    syscall

_function:
    mov rcx,rax     ; Copy the string for later
    mov rdi,inputName     ; Set RDI and RSI to point at message
    mov rsi,inputName     ;
    add rdi,rax     ; RDI should point at last character in message
    dec rdi         ;
    shr rax,1       ; Divide length by 2

_loop:            ; Begin loop:
    mov bl,[rsi]    ; Swap the characters using 8 bit registers
    mov bh,[rdi]    ; 
    mov [rsi],bh    ; 
    mov [rdi],bl    ; 
    inc rsi         ; Increment rsi (which is a pointer)
    dec rdi         ; Decrement rdi (also a pointer)
    dec rax         ; Decrement our counter
    jnz _loop       ; If our counter isn't zero, keep looping

; Write
_printResult:
    mov rdx,rcx ; nbytes
    mov rsi,inputName ; *msg
    mov rdi,1 ; stream
    mov rax,1 ; syscall
    syscall

_printLine:
    mov edx, 1
    mov ecx, charLine
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80

_closeProgram:
    mov eax, SYS_EXIT
    int 0x80




