%option noyywrap

%{
#include "task.tab.h"
%}

delim [ \t\n]
ws {delim}+
digit [0-9]
number {digit}+
letter [A-Za-z]
word {letter}+

%%
{ws} {}
{word} {return WORD;}
{number} {return NUM;}
%%

