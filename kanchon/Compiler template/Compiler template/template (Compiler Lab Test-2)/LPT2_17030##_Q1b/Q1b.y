%{
/*
ROLL: 17030##
FULL QUESTION: 

*/

#include<stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror();
extern int lineno;
extern int yylex();

%}

%union
{
    char str_val[100];
    int int_val;
}

%token INT DOUBLE FLOAT CHAR 
%token IF ELSE ELIF WHILE FOR CONTINUE BREAK VOID RETURN
%token INPUT PRINT STRING
%token ADDOP SUBOP MULOP DIVOP EQUOP LT GT 
%token INCR DECR OROP NOTOP NEQUOP GTEQ LTEQ COMMA ANDOP
%token LPAREN RPAREN LBRACE RBRACE COLON SEMI ASSIGN

%token<str_val> ID
%token ICONST
%token FCONST
%token CCONST

%start STATEMENTS

%%
STATEMENTS: STATEMENTS STATEMENT | 
    ;

STATEMENT: DECLARATION | IF_STATEMENT | PRINT_STATEMENT
  ;

DECLARATION: FLOAT ID ASSIGN INPUT LPAREN STRING RPAREN
  ;

IF_STATEMENT: IF EXPRESSION COLON STATEMENTS ELSE_STATEMENT
  ;

ELSE_STATEMENT: ELIF EXPRESSION COLON STATEMENTS ELSE_STATEMENT | ELSE COLON STATEMENTS
  ;

EXPRESSION: ID LOGICAL_OPERATOR ICONST
  ;

LOGICAL_OPERATOR: GT | EQUOP
  ;

PRINT_STATEMENT: PRINT LPAREN STRING RPAREN
  ;
  

%%

void yyerror ()
{
	printf("Syntax error at line %d\n", lineno);
	exit(1);
}

int main (int argc, char *argv[])
{
	yyparse();
	printf("Parsing finished!\n");	
	return 0;
}
