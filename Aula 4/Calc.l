%{
#include <stdio.h>
#include <string.h>
#include "Calc.tab.h"

%}

%option noyywrap

%%

IF              {return IF;}
ELSE            {return ELSE;}
"+"             {return PLUS;}
"-"             {return MINUS;}
"/"             {return DIVIDE;}
"*"             {return TIMES;}
"("             {return LEFT;}
")"             {return RIGHT;}
">"             {return GT;}
"<"             {return LT;}
"{"             {return LB;}
"}"             {return RB;}
[a-z]           {yylval.valueInt=(int)(yytext[0])- 97; return VARIABLE; }
"="		{return EQUALS;}
[0-9]+          {yylval.value = atof(yytext); return VAL;}
[0-9]+"."[0-9]+ {yylval.value = atof(yytext); return VAL;}
[ \t]           {}
"\n"            {return DONE;}
.               {printf("Error: invlaid lexeme '%s'.\n", yytext); return 0;}

%%



