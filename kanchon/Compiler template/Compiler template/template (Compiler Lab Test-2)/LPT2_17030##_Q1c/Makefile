bison:
	bison -d Q1c.y
	flex Q1c.l
	gcc Q1c.tab.c lex.yy.c
	# a < input.txt
	a < input.txt > output.txt 
