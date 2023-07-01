%option noyywrap

%{
	
%}


delim [ \t\n]
ws {delim}+
digit [0-9]
letter [A-Z]

number {digit}{digit}*
ID  {letter}{letter}*


%%

{ws} {}
{ID} {printf("%s ID\n", yytext);}
{number} {printf("%s int_val\n",yytext);}
"string" {printf("%s STR_TYPE\n",yytext);}
"let" {printf("%s KEYWORD\n", yytext);}
"as" {printf("%s KEYWORD\n", yytext);}
"integer" {printf("%s INT_TYPE\n", yytext);}
"=" {printf("%s ASSIGN\n",yytext);}
";" {printf("%s SEMI\n",yytext);}


%%

int main(){
    yylex();
}