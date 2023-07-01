%option noyywrap

%{
/*
ROLL: 17030##
FULL QUESTION: 

*/
%}

digit [0-9]
delim [ \t]
letter [A-Za-z_]

%%
{delim}+ {}
(R|K|C|B)(UET) {printf("%s -> UNIVERSITY\n", yytext);}
(CSE|EEE) {printf("%s -> DEPT\n", yytext);}
({digit}{2}) {printf("%s -> SERIES\n", yytext);}
%%

int main()
{
  yylex();
  return 0;
}
