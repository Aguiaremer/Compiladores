%{
#include <stdio.h>
#include <string.h>
#include "Calc.tab.h"
#include <ctype.h>

%}

%option noyywrap

%%

"int"           {return INT;}
"float"         {return FLOAT;}
"char"          {return CHAR;}
"string"        {return STRING;}
"bool"          {return BOOL;}

[ \t]           {} // Ignorar espaços em branco
"\n"            {return DONE;}

[a-zA-Z_][a-zA-Z0-9_]* { 
    if (strlen(yytext) > 10) {
        printf("Erro: variável '%s' tem mais de 10 caracteres.\n", yytext);
        return 0;
    }
    yylval.valueInt = 0; // Placeholder para armazenar o nome da variável
    return VARIABLE;
}

[0-9]+          {yylval.value = atof(yytext); return VAL;}
[0-9]+"."[0-9]+ {yylval.value = atof(yytext); return VAL;}

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
"="             {return ATRIB;}
"=="            {return EQUALS;}
"!"             {return NEG;}
.               {printf("Error: invlaid lexeme '%s'.\n", yytext); return 0;}

%%

int yywrap() {
  return 1;
}
