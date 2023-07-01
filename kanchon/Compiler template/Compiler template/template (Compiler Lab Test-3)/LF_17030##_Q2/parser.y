%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
    #include "symtab.c"
    #include "codeGen.c"
	void yyerror();
	extern int lineno;
	extern int yylex();
%}

%union
{
    char str_val[100];
    int int_val;
}

%token PRINT SCAN INPUT OUTPUT
%token ADDOP SUBOP MULOP DIVOP EQUOP LT GT
%token LPAREN RPAREN LBRACE RBRACE SEMI ASSIGN ELSE 
%token<str_val> ID
%token<int_val> ICONST
%token<int_val> INT
%token<int_val> IF
%token<int_val> WHILE

%left LT GT /*LT GT has lowest precedence*/
%left ADDOP 
%left MULOP /*MULOP has lowest precedence*/

%start program

%%
program: {gen_code(START, -1);} code {gen_code(HALT, -1);}
code: statements;

statements: statements statement | ;

statement:  declaration
            |print
            ;

declaration: INT ID ASSIGN INPUT LPAREN RPAREN ADDOP ICONST
            {
                insert($2, $1);   
                int address = idcheck($2);
                if(address != -1)
                {
                    gen_code(SCAN_INT_VALUE, address);
                    gen_code(LD_VAR, address);
                    gen_code(LD_INT, $8);
                    gen_code(ADD, -1);
                    gen_code(STORE, address);
                } 
                else 
                    yyerror();        

            }
            |
            INT ID ASSIGN INPUT LPAREN RPAREN SUBOP ID
            {
                insert($2, $1);   
                int add1 = idcheck($2);
                int add2 = idcheck($8);
                if(add1 != -1)
                {
                    gen_code(SCAN_INT_VALUE, add1);
                    gen_code(LD_VAR, add1);
                    gen_code(LD_VAR, add2);
                    gen_code(SUB, -1);
                    gen_code(STORE, add1);
                }    
                else 
                    yyerror();              
            }
            ;

print: OUTPUT LPAREN ID RPAREN
            {
                int address = idcheck($3);
                if(address != -1)
                {   
                    gen_code(PRINT_INT_VALUE, address);
                }
                else 
                    yyerror();
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
