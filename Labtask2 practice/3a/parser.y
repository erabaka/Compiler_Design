%{
#include <stdio.h>
int x=1;
void yyerror(char *s);
int yylex();
%}

%token FUNC ID LP COLON INT_TYPE RP BEG RET MOD FLOAT_NUM EQU INT_NUM SEMI END 
%start pg

%%
pg: FUNC ID LP ID COLON INT_TYPE RP BEG RET ID MOD FLOAT_NUM EQU INT_NUM SEMI END
    ;
%%

int main(){
    yyparse();
    if(x==1){
        printf("ok");
    }
    else{printf("not ok");}
}
void yyerror(char *s){
    fprintf(stderr, "error: %s\n", s);
    x=0;
}