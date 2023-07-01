main: lexer.l parser.y
	bison -d parser.y 
	flex lexer.l 
	gcc parser.tab.c lex.yy.c
	./a<input.txt> output.txt

assembler:
	C:\masm32\bin\ml /c /coff /Cp q1.asm
	C:\masm32\bin\link -entry:main /subsystem:console q1.obj
	./q1
	


