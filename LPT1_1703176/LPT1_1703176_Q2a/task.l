%option noyywrap

%{

%}

delim [\t]
ws {delim}+
pos [10]
neg [-10]
real [10.2]
prop [is a]
positive [Positive Number]
negative [Negative Number]
reals [Real Number]

%%
{ws} {}
{pos} {printf("%s", yytext);}
{neg} {printf("%s", yytext);}
{real} {printf("%s", yytext);}
{prop} {printf("%s", yytext);}
{positive} {printf("%s", yytext);}
{negative} {printf("%s", yytext);}
{reals} {printf("%s", yytext);}
%%

int main()
{
    yylex();
    return 0;
}
