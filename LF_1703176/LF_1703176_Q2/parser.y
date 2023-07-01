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

       mone_kori  a ar type hocche int

       mone_kori  b ar type hocche int

        a equal 0

       while_loop( a less than 10)

         suru

                 a equal a jog 1

                 b equal a jog 2

          end

            b k_output_a_dekhai



end

	*/

%}

%union
{
    char str_val[100];
    int int_val;
}

%token MAIN FUNC MONE_KORI AR TYPE HOCCHE SURU ASSIGN PRINT END LPAREN RPAREN ADDOP THAN LESS WHILE
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
            loop |
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
            | ID ASSIGN ID ADDOP ICONST 
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
            ;

print: ID PRINT
        {
            int address_x = idcheck($1);
            gen_code(PRINT_INT_VALUE, address_x); 
        };
end: END;

loop: WHILE LPAREN ID LESS THAN ICONST RPAREN
        {
             // initilization
                int address_i = idcheck($3);
                if(address != -1)
                {
                    gen_code(LD_INT, $6);
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
            start 
            assignment
            end
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
