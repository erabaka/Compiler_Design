bison:
	bison -d q2b.y
	flex q2b.l
	gcc q2b.tab.c lex.yy.c
	a < input.txt
	# a < input.txt > output.txt 
