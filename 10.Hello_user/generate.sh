#!/bin/bash

#Program
#	genera.sh

#Task
# Compile and link a NASM program

#Use
# ./genera.sh name_file.asm
#	compile name_file.asm
#	link 	name_file.o
#	execute	name_file

#Verifys 2 captured arguments
if [ $# -eq 1 ]
then
	#Message
	echo "Compiling and linking..."

	#Compile and link the file
	nasm -f elf64 $1.asm;ld $1.o -o $1.exe

	if [ $? -eq 0 ]
	then
		#Mesagge
		echo "Executing..."

		#Executable file generated
		./$1.exe
	else
		echo "Error compiling and linking the file" >&2
	fi

else
	#Error message
	echo "---------------------------------------------"
	echo "Something went wrong: ERROR"
	echo "You have to pass 1 argument"
fi
