%option noyywrap

%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "x.tab.h"
int line = 1;
void yyerror();
%}

delim [ \t\n]
ws {delim}+
digit [0-9]
alpha [a-zA-Z]
alphanum {alpha}|{digit}
print [ -~]

ID {alpha}{alphanum}*
ICONST {digit}{digit}*
FCONST {digit}*"."{digit}+
CCONST (\'{print\'})
STRING \"{print}*\"

%%
{ws} {}
{ID} {return ID;}
{ICONST} {return ICONST;}
{FCONST} {return FCONST;}
"int" {return INT_TYPE;}
"(" {return LP;}
")" {return RP;}
"{" {return LB;}
"}" {return RB;}
"abc" {return FUNC;}
"main" {return FUNC;}
"=" {return ASSIGN;}
";" {return SEMI;}
"return" {return RET;}
"\n" {line+=1;}
%%