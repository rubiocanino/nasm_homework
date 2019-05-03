section .data
	text1 db "What is your name? "	;Variable que utilizamos para hablar con el usuario
	text2 db "Hello, "		;Variable que utilizamos para desplegar su nombre

section .bss
	name resb 16

section .text
	global _start

_start:
	call _printText1		;Declaramos las funcion prinText
	call _getName			;Declaramos la funcion getName
	call _printText2		;Declaramos la function prinText
	call _printName			;Declaramos la funcion  printName

	mov rax, 60
	mov rdi, 0
	syscall

_getName:
	mov rax, 0
	mov rdi, 0			;Como buscamos el input es 0, si fuera a imprimir seria 1
	mov rsi, name			;Variable para guardar el input del usuario
	mov rdx, 16			;Max 16 bytes
	syscall
	ret

_printText1:
	mov rax, 1
	mov rdi, 1
	mov rsi, text1
	mov rdx, 19			;Max 19 bytes
	syscall
	ret

_printText2:
	mov rax, 1
	mov rdi, 1
	mov rsi, text2
	mov rdx, 7			;Max 7 bytes
	syscall
	ret

_printName:
	mov rax, 1
	mov rdi, 1
	mov rsi, name
	mov rdx, 16			;Max 16 bytes
	syscall
	ret


