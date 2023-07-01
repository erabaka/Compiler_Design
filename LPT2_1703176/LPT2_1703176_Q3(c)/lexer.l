%option noyywrap

%{
	#include "parser.tab.h"
%}


delim [ \t\n]
ws {delim}+
digit [0-9]
letter [a-zA-Z]
number {digit}{digit}*
float {digit}*"."{digit}+
print     [ -~]
ID        {letter}{letter}*
LET ("let")
STRING ("string")
AS ("as")
INTEGER ("integer")


%%

{ws} {}
{STRING} {return STR;}
{LET} {return KEYWORD;}
{AS} {return KEYWORD;}
{INTEGER} {return INT_TYPE;}
{ID} {return ID;}
{number} {return NUM;}
"=" {return ASSIGN;}
";" {return SEMI;}


%%

