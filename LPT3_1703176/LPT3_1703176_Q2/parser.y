%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
    #include "symtab.c"
    #include "codeGen.c"
	void yyerror();
	extern int lineno;
	extern int yylex();
    
	/*
    ROLL: 1703176
    FULL QUESTION:
    def I as INT;
    I = IN(); 
    def J as INT =  I + 10;
    OUT(J);  

	*/

%}

%union
{
    char str_val[100];
    int int_val;
}

%token SUB_TOKEN DEF AS IN OUT
%token<int_val> FOR
%token<int_val> IF

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
program: {gen_code(START, -1);} code {gen_code(HALT, -1);}

code: statements;

statements: statements statement | ;

statement:  declare |
            declare2 |
            assignment |
            print
            ;

declare: DEF ID AS INT SEMI
            {
                insert($2, $4);
            }
            ;
declare2: DEF ID AS INT;
assignment: ID ASSIGN IN LPAREN RPAREN SEMI
                {
                    int address = idcheck($1);
                    if(address != -1)
                    {
                        gen_code(SCAN_INT_VALUE, address);
                        gen_code(STORE, address);
                    }
                }
            |
            declare2 ASSIGN exp SEMI
exp: ID ADDOP ICONST
        {
            int add1 = idcheck($1);
            if(add1 != -1){
                gen_code(LD_VAR, add1);
                gen_code(LD_INT, $3);
                gen_code(ADD, -1);
            }
        }
print:                
            OUT LPAREN ID RPAREN SEMI
            {
                int address_j = idcheck($3);
                gen_code(PRINT_INT_VALUE, address_j);
            }
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

    printf("============= INTERMEDIATE CODE===============\n");
    print_code();

    printf("============= ASM CODE===============\n");
    print_assembly();

	return 0;
}
