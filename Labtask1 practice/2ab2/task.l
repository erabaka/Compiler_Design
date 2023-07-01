%option noyywrap

%{
#include "task.tab.h"
%}

delim [ \t\n]
ws {delim}+
letter [A-Za-z]
word {letter}+

%%
{ws} {}
{word} {return WORD;}
%%