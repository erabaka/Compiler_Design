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

       mone_kori  a ar type hocche int

       mone_kori  b ar type hocche int

        a equal 0

       while_loop( a less than 10)

         suru

                 a equal a jog 1

                 b equal a jog 2

          end

            b k_output_a_dekhai



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


"int"       		{yylval.int_val=INT_TYPE; return INT; }
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
"jog"				{ return ADDOP; }
"("					{ return LPAREN; }
")"					{ return RPAREN; }
"while_loop"		{ return WHILE; }
"less" 				{ return LESS; }
"than"				{ return THAN; }


{ID}        {strcpy(yylval.str_val, yytext); return ID;}
{ICONST}    {yylval.int_val=atoi(yytext); return ICONST;}

"\n"        { lineno += 1; }
[ \t\r\f]+  

.       { yyerror("Unrecognized character"); }
