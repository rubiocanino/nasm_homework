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

    welcomeMessage db "Multiply V.1.0",0xa
    intLenWelcome equ $- welcomeMessage

    firstNumber db "First number: ",0xa
    intLenFirstMessage equ $- firstNumber

    secondNumber db "Second number: ",0xa
    intLenSecondMessage equ $- secondNumber

    resultMessage db "The result: ",0xa
    intLenResultMessage equ $- resultMessage

    charLine db 0ax

section .bss
    intNumber1  resb 1
    intNumber2  resb 1
    intResult   resb 1

section .text
	global _start 

_start:
    call _printWelcome
    call _printMessage1
    call _captureNumber1
    call _printMessage2
    call _captureNumber2
    call _compareFunction

_printWelcome:
    mov edx, intLenWelcome
    mov ecx, welcomeMessage
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80

_printMessage1:
    mov edx, intLenFirstMessage
    mov ecx, firstNumber
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80

_captureNumber1:
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, intNumber1 
    mov edx, 2
    int 0x80
 
_printMessage2:
    mov edx, intLenSecondMessage
    mov ecx, secondNumber
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80

_captureNumber2:
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, intNumber2
    mov edx, 2
    int 0x80

_compareFunction:
    mov ah, [intNumber1]    ;We assignt the first value to ah
    sub ah, '0'             ;Now we do a subsctraction for the hexamdecimal ASCCI value of 0 = 30
                            ;EXAMPLE: The first input will be equal to 3
                            ; 3 decimal = 33 hexadecimal ASCII
                            ; 33 - 30 = 3
    mov al, [intNumber2]    ; And the second input will be equal to 2   
    sub al, '0'             ; 2 decimal = 32 hexadecimal ASCII
                            ; 32 - 40 = 2
    
                            ;NOTE: All the comparation are the first one respect the second one
    cmp byte ah, al         ;Now we compare the 3 and 2
    je _equal               ; If the values are equal, then we jump to _equal function
    jg _true                ; If the first value greater, then we jump to _true
    jle _less               ; If the first values is tinier, then we jump to _less

    mov eax, SYS_EXIT

_true:
    mov edx, intLenMore
    mov ecx, more
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    
    int 0x80
    call _closeProgram

        

_equal:
    mov edx, intLenEqual
    mov ecx, equal
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80
    call _closeProgram

_less:
    mov edx, intLenLess
    mov ecx, less
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80
    call _closeProgram

_closeProgram:
    mov eax, SYS_EXIT
    int 0x80

