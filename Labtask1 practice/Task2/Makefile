main: cal.l cal.y
	flex cal.l
	bison -d cal.y
	gcc lex.yy.c cal.tab.c
	
