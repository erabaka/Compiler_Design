all:
	gcc -o HelloWorld HelloWorld.c
	gcc -E HelloWorld.c > HelloWorld.i 
	gcc -S -masm=intel HelloWorld.i
	as -o HelloWorld.o HelloWorld.s
	objdump -M intel -d HelloWorld.o > HelloWorld.dump
	gcc -c -o HelloWorld.o HelloWorld.c
	objdump -M intel -d HelloWorld.o > HelloWorld2.dump
