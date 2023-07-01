%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	void yyerror();
	extern int lineno;
	extern int yylex();
    
	/*
    ROLL: 17030##
    FULL QUESTION:  
	Consider following Version1 of Code Snippet:
	
	main function () 
	suru
		dhori a akta integer
		dhori b akta integer
		a soman 2
		b soman 3 jog a
		print kori b
	sesh

	a. Design Lexical Analysis and Syntax Analysis part of compiler based on the version1 of code snippet.
	b. Design Intermediate Code Generation and Code Generation part of compiler based on the version1 of code snippet.

	*/

%}

%union
{
    char str_val[100];
    int int_val;
}

%token MAIN FUNCTION SURU SESH DHORI AKTA SOMAN JOG PRINT KORI

%token ADDOP SUBOP MULOP DIVOP EQUOP LT GT
%token LPAREN RPAREN LBRACE RBRACE SEMI ASSIGN ELSE 
%token<str_val> ID
%token<int_val> ICONST
%token<int_val> INT

%left LT GT /*LT GT has lowest precedence*/
%left ADDOP 
%left MULOP /*MULOP has lowest precedence*/

%start program

%%
program: MAIN FUNCTION LPAREN RPAREN SURU code SESH

code: statements;

statements: statements statement | ;

statement:  declear |
            assignment |
            output;
            ;

declear: DHORI ID AKTA INT
            ;

assignment: ID SOMAN ICONST 
            |
            ID SOMAN ICONST JOG ID
        ;

output: PRINT KORI ID
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
