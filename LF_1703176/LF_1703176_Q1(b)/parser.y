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
    main () function 

    suru

        mone_kori p ar type hocche int

        mone_kori q  ar type hocche int

        p equal 20

        q  equal 20 biyog 10

        q k_output_a_dekhai

    end

	*/

%}

%union
{
    char str_val[100];
    int int_val;
}

%token MAIN FUNC MONE_KORI AR TYPE HOCCHE SURU ASSIGN PRINT END LPAREN RPAREN SUBOP
%token<int_val> FOR
%token<int_val> IF


%token<str_val> ID
%token<int_val> ICONST
%token<int_val> INT



%start program

%%
program: {gen_code(START, -1);} code {gen_code(HALT, -1);}

code: statements;

statements: statements statement | ;

statement:  init |
            start |
            declare |
            assignment |
            print |
            end
            ;

init: MAIN LPAREN RPAREN FUNC;
start: SURU;
declare: MONE_KORI ID AR TYPE HOCCHE INT
        {
            insert ($2, $6);
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
            | ID ASSIGN ICONST SUBOP ICONST
            {
                int address_i = idcheck($1);
               
                if(address_i != -1){
                   
                    gen_code(LD_INT, $3);
                    gen_code(LD_INT, $5);
                    gen_code(SUB, -1);
                    gen_code(STORE, address_i);
                }
            };
print: ID PRINT
        {
            int address_x = idcheck($1);
            gen_code(PRINT_INT_VALUE, address_x); 
        };
end: END;



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
