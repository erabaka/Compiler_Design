%option noyywrap

%{
    #include "parser.tab.h"
%}

delim [ \t\n]
ws {delim}+
digit [0-9]
letter [a-zA-Z]
word {letter}{letter}*
number {digit}{digit}*
float {digit}*"."{digit}+
us [_]
func ("function")
begin ("begin")
ret ("return")
end ("end")
int ("int")


%%
{ws} {}
{end} {return END;}
{ret} {return RET;}
{begin} {return BEG;}
{int} {return INT_TYPE;}
{number} {return INT_NUM;}
{func}  {return FUNC;}
{word} {return ID ;}
{float} {return FLOAT_NUM;}
";" {return SEMI;}
"%" {return MOD;}
":" {return COLON;}
"(" {return LP;}
")" {return RP;}
"==" {return EQU;}

%%

