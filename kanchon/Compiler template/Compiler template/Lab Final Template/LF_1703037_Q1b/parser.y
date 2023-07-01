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
    ROLL: 17030##
    FULL QUESTION: 
    
    Q1.  Consider following Version1 of Code Snippet:

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
program: {gen_code(START, -1);} code {gen_code(HALT, -1);}

code: MAIN FUNCTION LPAREN RPAREN SURU statements SESH;

statements: statements statement | ;

statement:  declear |
            assignment |
            output;
            ;

declear: DHORI ID AKTA INT
            {
                insert($2, $4);
            }
        ;

assignment: ID SOMAN ICONST 
                {
                    int address = idcheck($1);
                    if(address != -1)
                    {
                        gen_code(LD_INT, $3);
                        gen_code(STORE, address);
                    }
                }
            |
            ID SOMAN ICONST JOG ID
                {
                    int address_b = idcheck($1);
                    int address_a = idcheck($5);
                    if(address_b != -1)
                        {
                            gen_code(LD_VAR, address_a);
                            gen_code(LD_INT, $3);
                            gen_code(ADD, -1);
                            gen_code(STORE, address_b);
                        }

                }
        ;

output: PRINT KORI ID
            {
                int address_b = idcheck($3);
                gen_code(PRINT_INT_VALUE, address_b);
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
