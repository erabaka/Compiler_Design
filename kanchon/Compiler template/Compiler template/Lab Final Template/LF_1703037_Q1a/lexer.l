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
	Consider following Version1 of Code Snippet:
	
	main function () 
	suru
		dhori a akta integer
		dhori b akta integer
		a soman 2
		b soman 3 jog a
		print kori b
	sesh

	a. Design Lexical Analysis and Syntax Analysis part of compiler based on the version1 of code snippet.
	b. Design Intermediate Code Generation and Code Generation part of compiler based on the version1 of code snippet.

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


"integer"       	{yylval.int_val=INT_TYPE; return INT; }
"Single"       		{yylval.int_val=INT_TYPE; return INT; }

"main"       		{ return MAIN; }
"function"       	{ return FUNCTION; }
"suru"       		{ return SURU; }
"sesh"       		{ return SESH; }
"dhori"       		{ return DHORI; }
"akta"       		{ return AKTA; }

"soman"       		{ return SOMAN; }
"jog"       		{ return JOG; }
"print"       		{ return PRINT; }
"kori"       		{ return KORI; }



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
