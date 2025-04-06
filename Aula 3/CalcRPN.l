%{
#include "CalcRPN.tab.h"
#include <stdlib.h>
%}

%option noyywrap

%%

[0-9]+(\.[0-9]+)?      { yylval.valor = atof(yytext); return VALOR; }
[a-z]                  { yylval.simbolo = yytext[0]; return VARIAVEL; }

"="                    { return IGUAL; }
"+"                    { return MAIS; }
"-"                    { return MENOS; }
"*"                    { return MULTI; }
"/"                    { return DIVISAO; }
\n                     { return ENDL; }

[ \t]+                 ;   
.                      ;   
%%