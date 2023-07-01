%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	void yyerror();
    #include "symtab.c"
	extern int lineno;
	extern int yylex();
%}

%union{
    char str_val[100];
    int int_val;
}

%token INT IF ELSE WHILE CONTINUE BREAK PRINT DOUBLE CHAR
%token ADDOP SUBOP MULOP DIVOP EQUOP LT GT
%token LPAREN RPAREN LBRACE RBRACE SEMI ASSIGN
%token<str_val> ID
%token<str_val> ICONST
%token<str_val> FCONST
%token<str_val> CCONST

%type<int_val> type exp constant 

%left ADDOP SUBOP
%left MULOP DIVOP
%left LT GT
%left EQUOP
%right ASSIGN

%start code

%%
code: statements;

statements: statements statement | ;

statement: id_declare
          |if_statement else_statement
          |ID ASSIGN exp SEMI
          {
            if(id_check($1)==-1){
            printf("%s is not declared\n", $1);
            yyerror();
            }


            if(type_check(get_type($1), $3)==-1)
            yyerror();

          }
          |while_statement
           ;

if_statement: IF LPAREN exp RPAREN LBRACE statements RBRACE 

else_statement: ELSE LBRACE statements RBRACE | ;

while_statement: WHILE LPAREN exp RPAREN LBRACE statements RBRACE;

exp: ID {$$ = get_type($1);}
    | constant 
    | exp ADDOP exp
    { printf("%d + %d\n", $1, $3);
    
    if(type_check($1, $3)==-1)
    yyerror();

    else
      $$ = type_check($1, $3);

    }
    | exp SUBOP exp
    | exp MULOP exp 
    | exp DIVOP exp
    | exp GT exp
    | exp LT exp
    | exp EQUOP exp
    ;

id_declare: type ID SEMI
           {
            insert($2, $1);
           }
        |type ID ASSIGN constant SEMI
        ;

constant: ICONST {$$ = INT_TYPE;} | FCONST {$$ = REAL_TYPE;} | CCONST {$$ = CHAR_TYPE;};

type: INT {$$ = INT_TYPE; } | DOUBLE {$$ = REAL_TYPE;} | CHAR {$$ = CHAR_TYPE;};
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
