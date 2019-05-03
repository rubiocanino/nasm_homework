section .data
    %define	SYS_EXIT	1
    %define	SYS_WRITE	4
    %define	SYS_READ	3
    %define	STDOUT		1
    %define STDIN       0

    welcomeMessage db "Addition V.1.0",0xa
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
	global _start ; We start the program

_start:
    call _printWelcome
    call _printMessage1
    call _captureNumber1
    call _printMessage2
    call _captureNumber2
    call _additionFunction
    call _printResult
    call _closeProgram

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

_printResult:
    mov edx, intLenResultMessage
    mov ecx, resultMessage
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80

    mov edx, 1
    mov ecx, intResult
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80

    mov edx, 1
    mov ecx, charLine
    mov ebx, STDOUT 
    mov eax, SYS_WRITE
    int 0x80

_closeProgram
    mov eax, SYS_EXIT
    int 0x80
