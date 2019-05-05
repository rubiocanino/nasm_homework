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
    string  resw 50
    temp    resb 1
    length  resb 1
    i       resb 1
    countA  resb 1
    countE  resb 1
    countI  resb 1
    countO  resb 1
    countU  resb 1

section .text

global _start

_start:
    call _printWelcome
    call _printInputMessage
    call _captureString

_printWelcome:
    mov edx, intLenWelcome
    mov ecx, welcomeMessage
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80

_printInputMessage:
    mov edx, lenInpuntMessage
    mov ecx, inputMessage
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80

_captureString:
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, string
    mov edx, 2
    int 0x80

    mov rbx, string
    mov byte[length],0
    int 0x80

_accepting_string:
    push rbx

    mov eax,3
    mov rbx,0
    mov ecx,temp
    mov edx,1
    int 80h

    pop rbx

    mov al,byte[temp]
    mov byte[rbx],al

    inc byte[length]
    inc rbx

    cmp byte[temp],10
    jne _accepting_string

    dec rbx
    dec byte[length]
    mov byte[rbx],0

    mov byte[countA],0
    mov byte[countE],0
    mov byte[countI],0
    mov byte[countO],0
    mov byte[countU],0

    mov byte[i],0

_vowelCheck:
    mov eax,string
    movzx ecx,byte[i]
    add eax,ecx

    cmp byte[eax],97
    je _countA

    cmp byte[eax],101
    je _countE

    cmp byte[eax],105
    je _countI

    cmp byte[eax],111
    je _countO

    cmp byte[eax],117
    je _countU

    continue:
    inc byte[i]
    mov al,byte[length]
    cmp byte[i],al
    jl _vowelCheck

    add byte[countA],30h
    add byte[countE],30h
    add byte[countI],30h
    add byte[countO],30h
    add byte[countU],30h

    call _print

    jmp _closeProgram

_countA:
    add byte[countA],1
    jmp continue

_countE:
    add byte[countE],1
    jmp continue

_countI:
    add byte[countI],1
    jmp continue

_countO:
    add byte[countO],1
    jmp continue

_countU:
    add byte[countU],1
    jmp continue

_print:
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

    ;call _printLine

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

    ;call _printLine

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

;    call _printLine

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

 ;   call _printLine

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

  ;  call _printLine

    ret

_printLine:
    mov edx, 1
    mov ecx, charLine
    mov rbx, STDOUT
    mov eax, SYS_WRITE
    int 0x80

_closeProgram:
    mov eax, SYS_EXIT
    int 0x80