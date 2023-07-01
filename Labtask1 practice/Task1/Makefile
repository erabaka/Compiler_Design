all:
	gcc -o co code.c
	gcc -E code.c>co.i
	gcc -S -masm=intel co.i
	as -o co.o co.s
	objdump -M intel -d co.o>co.dump