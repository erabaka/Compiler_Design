%option noyywrap

%{

%}

delim [ \t\n]
ws {delim}+
digit [0-9]
number {digit}+
uni (BUET|RUET|CUET)
dept (EEE|CSE)

%%
{ws} {}
{number} {printf("series=%s\n\n\n", yytext);}
{uni} {printf("university=%s\n\n", yytext);}
{dept} {printf("dept=%s\n", yytext);}
%%

int main(){
    yylex();
    return 0;
}