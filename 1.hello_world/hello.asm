section .data
	text db "Hello world",10    ; We declare the variable text
                                ; At las we use 10 for line break \n

section .text
	global _start ; We call _start to get the program 

_start:
	mov rax, 1	;We use it 1 because it's the number of the instruction SYS_WRITE
	mov rdi, 1	; Same as above, we are going to do and OUTPUT so 1 refers to and OUTPUT
	mov rsi, text	; To point the memory direction to TEXT variable
	mov rdx, 14	; How many chars need the computer to print the variable in our case
                ; 14 'cause the "Hello world" has 13 plus the line break 14
	syscall		; We call the kernel to execute the program

	mov rax, 60	; We call the kernel to execute the program
                ; 60 'cause we gonna need to call SYS_EXIT to close program
	mov rdi, 0	; 0 aclare that everything went well in the excution of the program
	syscall		; We call the kernel to execute the program
