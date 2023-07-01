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

	*/

%}

%union
{
    char str_val[100];
    int int_val;
}

%token SUB_TOKEN DIM AS TO NEXT THEN PRINT END
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

code: SUB_TOKEN ID LPAREN RPAREN statements END SUB_TOKEN;

statements: statements statement | ;

statement:  declear |
            assignment |
            for_loop |
            if_stat
            ;

declear: DIM ID AS INT
            {
                insert($2, $4);
            }
            ;

for_loop: FOR ID ASSIGN ICONST TO ICONST 
            {
                // initilization
                int address_i = idcheck($2);
                if(address != -1)
                {
                    gen_code(LD_INT, $4);
                    gen_code(STORE, address_i);
                }

                //loop name creation
                $1 = gen_label();

                //loop label start
                gen_code(WHILE_LABEL, $1);

                // compare
                gen_code(LD_VAR, address_i);
                gen_code(LD_INT, $6 + 1);
                gen_code(LT_OP, gen_label());

                //level start
                gen_code(WHILE_START, $1);

            }
            statements NEXT ID
            {
                int address_i = idcheck($2);
                if(address_i != -1)
                    {
                        gen_code(LD_VAR, address_i);
                        gen_code(LD_INT, 1);
                        gen_code(ADD, -1);
                        gen_code(STORE, address_i);
                    }
                gen_code(WHILE_END, $1);
            }
        ;


if_stat: IF ID GT ICONST THEN 
            {
                $1 = gen_label();
                gen_code(LD_VAR, idcheck($2));
                gen_code(LD_INT, $4);
                gen_code(GT_OP, gen_label());
                gen_code(IF_START, $1);

            }
            statements END IF
            {
                gen_code(ELSE_START, $1);
                gen_code(ELSE_END, $1);
                
            }
        ;

assignment: ID ASSIGN ICONST
                {
                    int address = idcheck($1);
                    if(address != -1)
                    {
                        gen_code(LD_INT, $3);
                        gen_code(STORE, address);
                    }
                }
            |
            ID ASSIGN ID ADDOP ID ADDOP ICONST SEMI
                {
                    int address_x = idcheck($1);
                    int address_i = idcheck($5);
                    if(address_x != -1 && address_i != -1)
                    {
                        gen_code(LD_VAR, address_x);
                        gen_code(LD_VAR, address_i);
                        gen_code(ADD, -1);
                        gen_code(LD_INT, $7);
                        gen_code(ADD, -1);
                        gen_code(STORE, address_x);
                    }   
                }
            |
            ID ASSIGN ID ADDOP ICONST 
            {
                int address_x = idcheck($1);
                if(address_x != -1)
                    {
                        gen_code(LD_VAR, address_x);
                        gen_code(LD_INT, $5);
                        gen_code(ADD, -1);
                        gen_code(STORE, address_x);
                    }

            }
            |
            PRINT LPAREN ID RPAREN
            {
                int address_x = idcheck($3);
                gen_code(PRINT_INT_VALUE, address_x);
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
