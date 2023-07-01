main: task.l task.y
	flex task.l
	bison -d task.y
	gcc lex.yy.c task.tab.c