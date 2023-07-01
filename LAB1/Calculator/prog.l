%option noyywrap
%{
#include "prog.tab.h"
%}
delim [ \t\n]
ws {delim}+
digit[0-9]
number{digit}+
letter[A-Za-z]
us[_]
id({letter}|{us})({letter}|{us}|{digit})*

%%
{ws} {}
{number} {yylval=atoi(yytext);return NUM;}
"+" {return ADD;}
"-" {return SUB;}
"if" {return IF;}
{id} {return ID;}
"==" {return EQUAL;}
"(" {return LP;}
")" {return RP;}
"{" {return LB;}
"}" {return RB;}
"=" {return ASSIGN;}
";" {return SEMI;}
%%
