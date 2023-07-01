%option noyywrap

%{

%}

delim [ \t\n]
ws {delim}+
digit [0-9]
number {digit}+
letter [A-Za-z]
word {letter}+

%%
{ws} {}
{word} {printf("%s WORD", yytext)}
{number} {return NUM;}
%%
int main(){
    yylex();
    return 0;  
}
