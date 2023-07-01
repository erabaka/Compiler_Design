%{
#include<stdio.h>
int x=1;
void yyerror(char *s);
int yylex();    
%}

%token WORD
%start val

%%
    val:val WORD WORD WORD
        |
%%

int main(){
    yyparse();
    if(x==1)
        printf("accepted\n");
    else
        printf("rejection\n");
}

void yyerror(char *s){
    fprintf(stderr, "error: %s\n",s);
    x=0;
}