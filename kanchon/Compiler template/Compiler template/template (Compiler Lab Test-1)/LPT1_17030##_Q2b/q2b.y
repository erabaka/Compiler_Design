%{
/*
ROLL: 1703037
FULL QUESTION: 

*/

#include<stdio.h>
void yyerror(char *s);
int yylex();
%}

%token UNIVERSITY DEPT SERIES
%start BEGIN

%%
BEGIN: UNIVERSITY DEPT SERIES
    ;
%%

int main()
{
  yyparse();
  printf("Parsing Finished");
  return 0;
}

void yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
}