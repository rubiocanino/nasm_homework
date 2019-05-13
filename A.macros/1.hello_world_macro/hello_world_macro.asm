section	.data
    %define	SYS_EXIT	1
    %define	SYS_WRITE	4
    %define	SYS_READ	3
    %define	STDOUT		1
    %define STDIN       0

    msg1 db	'Hola mundo!',0xA,0xD
    len1 equ $ - msg1

    msg2 db 'Estamos usando MACROS,', 0xA,0xD 
    len2 equ $- msg2 

    msg3 db 'en ensamblador en LINUX! ',0xa
    len3 equ $- msg3

section	.text
   global _start

%macro _printString 2 
    mov   eax, SYS_WRITE
    mov   ebx, STDOUT
    mov   ecx, %1
    mov   edx, %2
    int   80h
%endmacro   

_start:
   _printString msg1, len1
   _printString msg2, len2
   _printString msg3, len3
	
   mov eax,1
   int 0x80



