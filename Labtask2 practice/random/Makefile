main: x.l x.y
	bison -d x.y
	flex x.l
	gcc lex.yy.c x.tab.c
	./a<input.txt> output.txt