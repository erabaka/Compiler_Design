%option noyywrap

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "parser.tab.h"

    int lineno = 1;
    void yyerror();

%}

alpha   [a-zA-Z]
digit   [0-9]
alnum   {alpha}|{digit}
print   [ -~]

ID      {alpha}{alnum}*
ICONST  {digit}{digit}*
FCONST  {digit}*"."{digit}+
CCONST  (\'{print}\')
STRING  \"{print}*\"