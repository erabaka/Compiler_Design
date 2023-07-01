%option noyywrap

%{
#include "task.tab.h"
%}

delim [\t]
ws {delim}+
num (10|10.2|-10)
prop ("is a")
val ("Positive Number"|"Negative Number"|"Real Number")


%%
{ws} {}
{num} {return NUM;}
{val} {return VAL;}
{prop} {return PROP;}
%%


