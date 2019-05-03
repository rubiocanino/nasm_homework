section .data
	text db "Hello world",10 ; Definimos los bytes para la direccion de memoria de text

section .text
	global _start ; Mandamos a llamar la funcion start

_start:
	mov rax, 1	; 1 Por que estamos en un sys_write
	mov rdi, 1	; 1 Por que es un output
	mov rsi, text	; text para especificar la direccion de memoria de text
	mov rdx, 14	; El largo de la cadena que se va a dar al output
	syscall		; Se ejecuta en el kernel

	mov rax, 60	; 60 Por que estamos corriento sys_exit
	mov rdi, 0	; 0 para especificar que no existe error en la ejecucion
	syscall		; Se ejecuta en el kernel
