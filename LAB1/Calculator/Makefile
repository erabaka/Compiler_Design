main: cal.l cal.y
	bison -d cal.y
	flex cal.l
	gcc cal.tab.c lex.yy.c
# a <input.txt>output.txt
main2: prog.l prog.y
	bison -d prog.y
	flex prog.l
	gcc prog.tab.c lex.yy.c
# b <input1.txt>output1.txt
# all:
# 	gcc lex.yy.c -o l1