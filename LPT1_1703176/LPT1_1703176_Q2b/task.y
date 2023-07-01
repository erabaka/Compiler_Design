%{
#include<stdio.h>
int x=1;
void yyerror(char *s);
int yylex();    
%}

%token NUM PROP VAL
%start val

%%
    val: NUM PROP VAL
        |
%%

int main(){
    yyparse();
    if(x==1)
       {printf("Success\n");}
    else
        {printf("Fail!\n");}
}

void yyerror(char *s){
    fprintf(stderr,"Error detected: %s\n", s);
    x=0;
}