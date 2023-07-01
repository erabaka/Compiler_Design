%option noyywrap

%{
/*
ROLL: 17030##
FULL QUESTION: 

*/
#include "q2b.tab.h"
%}

digit [0-9]
delim [ \t]
letter [A-Za-z_]

%%
{delim}+ {}
(R|K|C|B)(UET) {return UNIVERSITY;}
(CSE|EEE) {return DEPT;}
({digit}{2}) {return SERIES;}
%%

