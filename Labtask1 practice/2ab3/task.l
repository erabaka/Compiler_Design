%option noyywrap

%{
#include "task.tab.h"    
%}

delim [ \t\n]
ws {delim}+
roll (0(0[1-9]|[1-9][0-9])|1[0-7][0-9]|80)

%%
{ws} {}
{roll} {return ROLL;}
%%