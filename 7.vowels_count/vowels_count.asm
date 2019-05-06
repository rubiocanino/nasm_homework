section .data
    %define	SYS_EXIT	1
    %define	SYS_WRITE	4
    %define	SYS_READ	3
    %define	STDOUT		1
    %define STDIN       0

    welcomeMessage db "Vowels count V.1.0",0xa,0xa
    intLenWelcome equ $- welcomeMessage

    inputMessage db "Input text: ",0xa
    lenInpuntMessage equ $- inputMessage

    messageA db "Vowel A count:  ",0xa
    lenMessageA: equ $- messageA

    messageE db "Vowel E count:  ",0xa
    lenMessageE equ $- messageE

    messageI db "Vowel I count:  ",0xa
    lenMessageI equ $- messageI

    messageO db "Vowel O count:  ",0xa
    lenMessageO equ $- messageO

    messageU db "Vowel U count:  ",0xa
    lenMessageU equ $- messageU
    
    charLine db 0ax

section .bss
    string  resw 50     ; Variable to reserver the memory of the input 
    temp    resb 1      ; Variable temporal to copy the value of the string
    length  resb 1      ; Variable to establish the jump, meaning char by char of the string capturated
    i       resb 1      ; Counter
    countA  resb 1      ; Counter for letter A/a
    countE  resb 1      ; Counter for letter E/e
    countI  resb 1      ; Counter for letter I/i
    countO  resb 1      ; Counter for letter O/o
    countU  resb 1      ; Counter for letter U/u

section .text
    global _start

_start:
    mov eax,SYS_WRITE
    mov ebx,STDOUT
    mov ecx,welcomeMessage  ; We display the version of the program
    mov edx,intLenWelcome
    int 0x80

    mov eax,SYS_WRITE
    mov ebx,STDOUT
    mov ecx,inputMessage    ; We display the input message
    mov edx,lenInpuntMessage
    int 0x80

    mov rbx,string          ; We point rbx to the value of the input that we will capture
    mov byte[length],0      ; And the length of this rbx/input value we start in 0
                            ; To start counting the size

_acceptingString:
    push rbx                ; We send rbx pointer to the stack
    mov eax,SYS_READ        ; We capture the string in temp variable
    mov ebx,STDIN
    mov ecx,temp   
    mov edx,1               
    int 80h                 ; We execute the capture of the input

    pop rbx                 ; Now we bring back the pointer rbx

    mov al,byte[temp]       ; Now we keep in al the first byte of the temp (input) value
    mov byte[rbx],al        ; Also we send to the first byte of rbx(string) the value of al, hola  (return,enter)

    inc byte[length]        ; Now we add +1 to the length of our input [0],1
    inc rbx                 ; And we point to next byte of rbx         [0],1

    cmp byte[temp],10       ; Now we compare the value of the pointer in temp and the value of return [0], 0xa = return
    jne _acceptingString    ; If the value is not equal to return, then we loop in _acceptingString
                            ; Because we are determining the length of the inp

    dec rbx                 ; If the loop breaks, that means that we have the length of the input
    dec byte[length]        ; So we need to decrese 1 the pointer in rbx and the length
    mov byte[rbx],0         ; And now we point to the begging of our input


    mov byte[countA],0  ; We assign the value of 0 the unique byte of the counter A
    mov byte[countE],0  ; We assign the value of 0 the unique byte of the counter E
    mov byte[countI],0  ; We assign the value of 0 the unique byte of the counter I
    mov byte[countO],0  ; We assign the value of 0 the unique byte of the counter O
    mov byte[countU],0  ; We assign the value of 0 the unique byte of the counter U
    
    mov byte[i],0       ; We assign the value of 0 the unique byte of the counter i

_vowelCheck:
    mov eax,string      ; We point to the input variable
    movzx ecx,byte[i]   ; Now we get where is the counter i vector[0],[1]
    add eax,ecx         ; We point the n character of the string adding the value of i

    cmp byte[eax],97   ; 97 = a
    je _countA         ; If the value of the char is 97 countA = +1

    cmp byte[eax],65   ; 65 = A
    je _countA         ; If the value of the char is 65 countA = +1

    cmp byte[eax],101   ; 101 = e
    je _countE          ; If the value of the char is 101 countE = +1

    cmp byte[eax],69   ; 69 = E
    je _countE         ; If the value of the char is 69 countE = +1

    cmp byte[eax],105   ; 105 = i
    je _countI          ; If the value of the char is 105 countI = +1

    cmp byte[eax],73   ; 73 = I
    je _countI         ; If the value of the char is 73 countI = +1

    cmp byte[eax],111   ; 111 = o
    je _countO          ; If the value of the char is 111 countO = +1

    cmp byte[eax],79   ; 79 = O
    je _countO         ; If the value of the char is 79 countO = +1

    cmp byte[eax],117   ; 117 = u
    je _countU          ; If the value of the char is 117 countU = +1

    cmp byte[eax],85    ; 85 = U
    je _countU          ; If the value of the char is 85 countU = +1

_continue:
    inc byte[i]             ; We increment the counter of i, meaning the next char of our string capturated,[0],[1]
    mov al,byte[length]     ; We point to next char in the memory space
    cmp byte[i],al          ; We compare the the counter with the next char of the string 1 < 10, 11 < 10
    jl _vowelCheck          ; If the string is not null, then go back to check the char

    add byte[countA],30h    ; We add the value of 0, to get the decimal value to printed in the next subrutine
    add byte[countE],30h    ; We add the value of 0, to get the decimal value to printed in the next subrutine
    add byte[countI],30h    ; We add the value of 0, to get the decimal value to printed in the next subrutine
    add byte[countO],30h    ; We add the value of 0, to get the decimal value to printed in the next subrutine
    add byte[countU],30h    ; We add the value of 0, to get the decimal value to printed in the next subrutine

    call _printResult       ; We print the counters
    call _closeProgram      ; We close the program

    _countA:
    add byte[countA],1      ; countA+1
    jmp _continue

    _countE:
    add byte[countE],1      ; countE+1
    jmp _continue

    _countI:
    add byte[countI],1      ; countI+1
    jmp _continue

    _countO:
    add byte[countO],1      ; countO+1
    jmp _continue

    _countU:
    add byte[countU],1      ; countU+1
    jmp _continue

_printResult:
    mov eax,SYS_WRITE
    mov ebx,STDOUT
    mov ecx,messageA
    mov edx,lenMessageA
    int 80h

    mov eax,SYS_WRITE
    mov ebx,STDOUT
    mov ecx,countA
    mov edx,1
    int 80h

    call _printLine

    mov eax,SYS_WRITE
    mov ebx,STDOUT
    mov ecx,messageE
    mov edx,lenMessageE
    int 80h

    mov eax,SYS_WRITE
    mov ebx,STDOUT
    mov ecx,countE
    mov edx,1
    int 80h

    call _printLine

    mov eax,SYS_WRITE
    mov ebx,STDOUT
    mov ecx,messageI
    mov edx,lenMessageI
    int 80h

    mov eax,SYS_WRITE
    mov ebx,STDOUT
    mov ecx,countI
    mov edx,1
    int 80h

    call _printLine

    mov eax,SYS_WRITE
    mov ebx,STDOUT
    mov ecx,messageO
    mov edx,lenMessageO
    int 80h

    mov eax,SYS_WRITE
    mov ebx,STDOUT
    mov ecx,countO
    mov edx,1
    int 80h

    call _printLine

    mov eax,SYS_WRITE
    mov ebx,STDOUT
    mov ecx,messageU
    mov edx,lenMessageU
    int 80h

    mov eax,SYS_WRITE
    mov ebx,STDOUT
    mov ecx,countU
    mov edx,1
    int 80h

    call _printLine
    ret

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
