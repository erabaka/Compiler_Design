%{
    #include<stdio.h>
    #include<stdlib.h>
    void yyerror(char *s);
    extern int line;
    extern int yylex();
    int x = 1;
%}

%token INT_TYPE FUNC LP INT_TYPE exp RP LB RB ASSIGN SEMI RET ID ICONST FCONST
%start do

%%
do: functions function_dec;

type: INT_TYPE;

function_dec: type FUNC LP dec RP;
dec: type exp;

functions: main abc;

main: type FUNC LP RP LB exp f_call RB;

exp: 
    exp ASSIGN ICONST|
    exp ASSIGN FCONST|
    ID|
    exp ASSIGN exp
    ;
f_call: FUNC LP exp RP SEMI;
abc: type FUNC LP dec RP LB exp SEMI RET exp SEMI RB;

%%

int main(){
    yyparse();
    if(x==1)
    printf("ok");
    else
    printf("no");
}

void yyerror(char *s){
    printf("Syntax error at line %d\n", line );
    exit(1);
}