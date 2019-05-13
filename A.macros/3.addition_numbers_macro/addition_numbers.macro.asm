section .data
    %define	SYS_EXIT	1
    %define	SYS_WRITE	4
    %define	SYS_READ	3
    %define	STDOUT		1
    %define STDIN       0

    welcomeMessage db "Suma V.1.1",0xa
    intLenWelcome equ $- welcomeMessage

    firstNumber db "Primer digito: ",0xa
    intLenFirstMessage equ $- firstNumber

    secondNumber db "Segundo digito: ",0xa
    intLenSecondMessage equ $- secondNumber

    resultMessage db "El resultado: ",0xa
    intLenResultMessage equ $- resultMessage

    charLine db 0ax

section .bss
    intNumber1  resb 1
    intNumber2  resb 1
    intResult   resb 1

section .text
	global _start ; We start the program

%macro _printString 2 
    mov   eax, SYS_WRITE
    mov   ebx, STDOUT
    mov   ecx, %1
    mov   edx, %2
    int   80h
%endmacro

%macro _captureDigit 2 
    mov   eax, SYS_READ
    mov   ebx, STDIN
    mov   ecx, %1
    mov   edx, %2
    int 0x80
%endmacro

_start:
    _printString welcomeMessage, intLenWelcome
    _printString firstNumber, intLenFirstMessage 
    _captureDigit intNumber1, intNumber1
    _printString secondNumber, intLenSecondMessage
    _captureDigit intNumber2, intNumber2    
    call _additionFunction
    _printString resultMessage, intLenResultMessage
    _printString intResult, 1
    _printString charLine, 1
    call _closeProgram

_additionFunction:
    mov eax, [intNumber1]   ; We point to memory value of INTNUMBER1
    sub eax, '0'            ; We subtract the hexadecimal value 0 to substract 48
                            ; Example: 
                            ; 5 decimal = 35 hexadecimal ASCII
                            ; 35-30 = 5
                               
    mov ebx, [intNumber2]   ;Same as above
    sub ebx, '0'
                            ; 2 decimal = 32 hexadecimal ASCII
                            ; 32-30= 2

    add eax,ebx             ; 5 + 2 = 7
    add eax, '0'            ; 7 + 30 = 37
                            ; 7 decimal is = 37 hexadecimal ASCII

    mov [intResult], eax    ; We assign the value 37 hexadecimal value to intResult
    ret

_closeProgram
    mov eax, SYS_EXIT
    int 0x80
