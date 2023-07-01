%{
#include<stdio.h>
int x = 1;
void yyerror(char *s);
int yylex();    
%}

%token WORD NUM 
%start val

%%
    val:val WORD WORD NUM
        |
%%

int main(){
    yyparse();
    if(x==1)
        printf("Accepted\n");
    else
        printf("Rejected\n");
}

void yyerror(char *s){
    fprintf(stderr, "error: %s\n", s);
    x=0;
}