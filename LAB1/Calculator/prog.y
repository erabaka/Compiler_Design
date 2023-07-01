%{
#include<stdio.h>
void yyerror(char*s);
int yylex();
%}
%token NUM ADD SUB IF ID EQUAL LP RP LB RB ASSIGN SEMI
%start prog
%%
prog: statement
    ;
    statement: IF LP exp RP LB id_declare RB
    ;
    exp: ID EQUAL NUM
    ;
    id_declare: id_declare ID ASSIGN NUM SEMI
                |
    ;
%%
int main(){
    yyparse();
    printf("Parsing Finished\n");
}
void yyerror(char*s){
    fprintf(stderr,"error:%s",s);
}