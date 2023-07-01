%{
#include <stdio.h>
int x=1;
void yyerror(char *s);
int yylex();
%}

%token KEYWORD ID INT_TYPE ASSIGN NUM SEMI STR 
%start pg

%%
pg: stats
    ;
stats: stat1 stat2;
stat1: KEYWORD ID KEYWORD INT_TYPE ASSIGN NUM SEMI;
stat2: KEYWORD ID KEYWORD STR ASSIGN ID SEMI;
%%

int main(){
    yyparse();
    if(x==1){
        printf("Parse Finished");
    }
    else{printf("not ok");}
}
void yyerror(char *s){
    fprintf(stderr, "error: %s\n", s);
    x=0;
}