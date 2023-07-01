%{
#include<stdio.h>
int x=1;
void yyerror(char *s);
int yylex();    
%}

%token ROLL
%start val

%%
    val: ROLL
%%

int main(){
    yyparse();
    if(x==1)
        printf("ok\n");
    else
        printf("Darn\n");
}

void yyerror(char *s){
    fprintf(stderr, "error: %s\n",s);
    x=0;
}