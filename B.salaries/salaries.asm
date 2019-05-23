section .data
    %define	SYS_EXIT	1
    %define	SYS_WRITE	4
    %define	SYS_READ	3
    %define	STDOUT		1
    %define STDIN       0
    
    equal   db "They are equal", 0xa
    intLenEqual equ $- equal

    more    db "The first one is bigger", 0xa
    intLenMore equ $- more

    less    db "The second one is bigger", 0xa
    intLenLess equ $- less

    welcomeMessage db "Salaries V.1.0",0xa,0xa
    intLenWelcome equ $- welcomeMessage

    firstText db "Work hours: ",0xa
    intLenFirstMessage equ $- firstText

    secondText db "Hour price: ",0xa
    intLenSecondMessage equ $- secondText

    resultMessage db "The salary is: "
    intLenResultMessage equ $- resultMessage

    charLine db 0ax
    thirty db 25d
    twentyfive db 25d
    fifteen db 15d
    fd dq 0

section .bss
    workHours   resb 10
    priceHours  resb 10
    result   resb 10

section .text
	global _start 

    %macro _printString 2 
        mov   eax, SYS_WRITE
        mov   ebx, STDOUT
        mov   ecx, %1
        mov   edx, %2
        int   80h
    %endmacro  

    %macro _captureInput 2 
        mov   eax, SYS_READ
        mov   ebx, STDIN
        mov   ecx, %1
        mov   edx, %2
        int 0x80
    %endmacro

    %macro _getSalary 3 

       mov	al, [%1]
        
       mov 	bl, [%3]
       mul 	bl
       mov [result], al

        mov rdi, fifteen   ;Filename
        mov rsi, 0102o     ;O_CREAT, man open
        mov rdx, 0666o     ;umode_t
        mov rax, 2
        syscall

        mov [fd], rax
        mov rdx, 10       ;message length
        mov rsi, fifteen      ;message to write
        mov rdi, [fd]      ;file descriptor
        mov rax, 1         ;system call number (sys_write)
        syscall            ;call kernel

        mov rdi, [fd]
        mov rax, 3         ;sys_close
        syscall
    

        mov   eax, SYS_WRITE
        mov   ebx, STDOUT
        mov   ecx, result
        mov   edx, %2
        int 0x80
    %endmacro

    _start:
        _printString welcomeMessage, intLenWelcome
        _printString firstText, intLenFirstMessage
        _captureInput workHours, 10
        _printString secondText, intLenSecondMessage
        _captureInput priceHours, 10
        call _calculateFunction
        jmp _closeProgram

    _calculateFunction:
        mov ah, [workHours]
        sub ah, '0'

        mov al, [fifteen]
        cmp byte ah, al
        jle _fifteen 
        je  _fifteen

        mov al, [twentyfive]
        jle _twentyfive
        je  _twentyfive

        mov al, [thirty]
        jle _thirty
        je _thirty

        ret

    _fifteen:
        _getSalary workHours, 10, fifteen
        ret

    _twentyfive:
        _getSalary workHours, 10, twentyfive
        ret

    _thirty:
        _getSalary workHours, 10, thirty
        ret 

    _closeProgram:
        mov eax, SYS_EXIT
        int 0x80
        ret

