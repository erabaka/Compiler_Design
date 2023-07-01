main: lexer.l parser.y
	bison -d parser.y
	flex lexer.l
	gcc lex.yy.c parser.tab.c
	./a<input.txt