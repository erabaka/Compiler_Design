%option noyywrap

%{
	#define INT_TYPE 1
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "parser.tab.h"
	
	int lineno = 1; // initialize to 1
	void yyerror();

	/*
    ROLL: 17030##
    FULL QUESTION:  

	*/

%}

alpha     [a-zA-Z]
digit     [0-9]
alnum     {alpha}|{digit}
print     [ -~]

ID        {alpha}{alnum}*
ICONST    [0-9]{digit}*
%%

"//".*        { } 


"Integer"       	{yylval.int_val=INT_TYPE; return INT; }
"Single"       		{yylval.int_val=INT_TYPE; return INT; }

"Sub"       		{ return SUB_TOKEN; }
"Dim"       		{ return DIM; }
"As"       			{ return AS; }
"For"       		{ return FOR; }
"To"       			{ return TO; }
"Next"       		{ return NEXT; }
"If"       			{ return IF; }
"Then"       		{ return THEN; }
"print"       		{ return PRINT; }
"End"       		{ return END; }



"+"       { return ADDOP; }
"-"       { return SUBOP; }
"*"       { return MULOP; }
"/"       { return DIVOP; }
"=="      { return EQUOP; }
">"       { return GT; }
"<"       { return LT; }

"("       { return LPAREN; }
")"       { return RPAREN; }
"{"       { return LBRACE; }
"}"       { return RBRACE; }
";"       { return SEMI; }
"="       { return ASSIGN; }

{ID}        {strcpy(yylval.str_val, yytext); return ID;}
{ICONST}    {yylval.int_val=atoi(yytext); return ICONST;}

"\n"        { lineno += 1; }
[ \t\r\f]+  

.       { yyerror("Unrecognized character"); }
