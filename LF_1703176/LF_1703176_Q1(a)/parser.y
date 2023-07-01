%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	void yyerror();
    int x = 1;
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



%token MAIN FUNC MONE_KORI AR TYPE HOCCHE SURU ASSIGN PRINT END ID ICONST INT
%token SUBOP LPAREN RPAREN




%start program

%%
program: code;

code: statements

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
declare: MONE_KORI ID AR TYPE HOCCHE INT;
assignment: ID ASSIGN ICONST 
            | ID ASSIGN exp;
exp: ICONST SUBOP ICONST;
print: ID PRINT;
end: END;
%%

void yyerror(char *s){
    fprintf(stderr, "error: %s\n", s);
    x=0;
}

int main (int argc, char *argv[])
{
	yyparse();
    if(x==1){
	printf("Parsing finished!\n");}
    else{
        printf("NOT ok\n");
    }
}
