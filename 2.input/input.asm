section .data						;The section .data it's for declare not null variables
	text1 db "What is your name? "	;We declare text1
	text2 db "Hello, "				;We decleare text2

section .bss						;The section .bss it's for declare null variables
									;and just reserve the memory
	name resb 16

section .text
	global _start

_start:
	call _printText1		; We call the subrutine
	call _getName			; We call the subrutine
	call _printText2		; We call the subrutine
	call _printName			; We call the subrutine

	mov rax, 60				; 60 to call SYS_EXIT
	mov rdi, 0				; 0 indicate the programs has no Errors
	syscall

_getName:
	mov rax, 0			; We need to call a SYS_READ and the 0 calls it
	mov rdi, 0			; Same as above, we are going to do and OUTPUT so 0 refers to an OUTPUT
	mov rsi, name		; To point the memory direction to NAME variable
	mov rdx, 16			; Cause is goona print 16 chars
	syscall				; Call the kernel to execute
	ret

_printText1:
	mov rax, 1          ; We need to call a SYS_WRITE 1 calls it
	mov rdi, 1			; Same as above, we are goint to do an INPUT so 1 refers to an INPUT
	mov rsi, text1		; To point the memory direction to TEXT1 variable
	mov rdx, 19			;Max 19 bytes
	syscall
	ret

_printText2:
	mov rax, 1
	mov rdi, 1
	mov rsi, text2
	mov rdx, 7
	syscall
	ret

_printName:
	mov rax, 1
	mov rdi, 1
	mov rsi, name
	mov rdx, 16	
	syscall
	ret


