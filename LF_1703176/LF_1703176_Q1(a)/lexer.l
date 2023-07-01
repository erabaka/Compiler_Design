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
    ROLL: 1703176
    FULL QUESTION:  
	main () function 

	suru

		mone_kori p ar type hocche int

		mone_kori q  ar type hocche int

		p equal 20

		q  equal 20 biyog 10

		q k_output_a_dekhai

	end

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


"int"       		{ return INT; }

"main"       		{ return MAIN; }
"function"       	{ return FUNC; }
"mone_kori"       	{ return MONE_KORI; }
"ar"       			{ return AR; }
"type"       		{ return TYPE; }
"hocche"       		{ return HOCCHE; }
"suru"       		{ return SURU; }
"equal"       		{ return ASSIGN; }
"k_output_a_dekhai" { return PRINT; }
"end"       		{ return END; }
"biyog"				{ return SUBOP; }





"("       { return LPAREN; }
")"       { return RPAREN; }


{ID}        { return ID;}
{ICONST}    { return ICONST;}

"\n"        { lineno += 1; }
[ \t\r\f]+  

.       { yyerror("Unrecognized character"); }


