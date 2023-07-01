%option noyywrap

%{

    /*
    ROLL: 17030##
    FULL QUESTION: 
    */

	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	
	int lineno = 1; // initialize to 1
	void yyerror();
%}

alpha     [a-zA-Z]
digit     [0-9]
alnum     {alpha}|{digit}
print     [ -~]

ID        {alpha}{alnum}*
ICONST    [0-9]{digit}*
FCONST    {digit}*"."{digit}+
CCONST    (\'{print}\')
STRING    \"{print}*\"
%%

"//".*     { } 

"int"       {printf("%s -> INT\n", yytext);}
"double"   	{printf("%s -> DOUBLE\n", yytext);}
"float"   	{printf("%s -> FLOAT\n", yytext);}
"char"	   	{printf("%s -> CHAR\n", yytext);}

"input"    {printf("%s -> INPUT\n", yytext);}
"print"    {printf("%s -> PRINT\n", yytext);}

"if"	   {printf("%s -> IF\n", yytext);}
"else"	   {printf("%s -> ELSE\n", yytext);}
"elif"     {printf("%s -> ELIF\n", yytext);}
"while"    {printf("%s -> WHILE\n", yytext);}
"for"      {printf("%s -> FOR\n", yytext);}
"continue" {printf("%s -> CONTINUE\n", yytext);}
"break"    {printf("%s -> BREAK\n", yytext);}
"void"     {printf("%s -> VOID\n", yytext);}
"return"   {printf("%s -> RETURN\n", yytext);}

"+"        {printf("%s -> ADDOP\n", yytext);}
"-"        {printf("%s -> SUBOP\n", yytext);}
"*"        {printf("%s -> MULOP\n", yytext);}
"/"        {printf("%s -> DIVOP\n", yytext);}
"++"       {printf("%s -> INCR\n", yytext);}
"--"       {printf("%s -> DECR\n", yytext);}
"||"       {printf("%s -> OROP\n", yytext);}
"&&"       {printf("%s -> ANDOP\n", yytext);}
"!"        {printf("%s -> NOTOP\n", yytext);}
"=="       {printf("%s -> EQUOP\n", yytext);}
"!="       {printf("%s -> NEQUOP\n", yytext);}
">="       {printf("%s -> GTEQ\n", yytext);}
">"        {printf("%s -> GT\n", yytext);}
"<="       {printf("%s -> LTEQ\n", yytext);}
"<"        {printf("%s -> LT\n", yytext);}

"("        {printf("%s -> LPAREN\n", yytext);}
")"        {printf("%s -> RPAREN\n", yytext);}
"{"        {printf("%s -> LBRACE\n", yytext);}
"}"        {printf("%s -> RBRACE\n", yytext);}
":"        {printf("%s -> COLON\n", yytext);}
";"        {printf("%s -> SEMI\n", yytext);}
","        {printf("%s -> COMMA\n", yytext);}
"="        {printf("%s -> ASSIGN\n", yytext);}

{ID}        {printf("%s -> ID\n", yytext);}
{ICONST}    {printf("%s -> ICONST\n", yytext);}
{FCONST}    {printf("%s -> FCONST\n", yytext);}
{CCONST}    {printf("%s -> CCONST\n", yytext);}
{STRING}    {printf("%s -> STRING\n", yytext);}



%%

int main()
{
  yylex();
  return 0;
}
