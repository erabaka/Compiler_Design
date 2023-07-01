%{
#include<stdio.h>
void yyerror(char *s);
int x=1;
int yylex();
%}

%token NUM WORD
%start val

%%
    val: WORD NUM
%%

int main(){
    yyparse();
    if(x==1){printf("ok");}
    else{printf("not ok");}
    return 0;  
}

 void yyerror(char *s){
    fprintf(stderr,"Error Occured :%s\n",s);
    x=0;
}

