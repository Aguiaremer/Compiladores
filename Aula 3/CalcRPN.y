%{
#include <stdio.h>
#include <stdlib.h>

float simb[26];
float ans = 0;
void yyerror(const char* s);
int yylex(void);
%}

%union {
    float valor;
    char simbolo;
}

%token <valor> VALOR
%token <simbolo> VARIAVEL
%token MAIS MENOS MULTI DIVISAO IGUAL ENDL

%type <valor> EXPRESSAO

%%

INPUT:
    | INPUT LINHA
;

LINHA:
      ENDL
    | EXPRESSAO ENDL { printf("= %f\n", $1); ans = $1; }
;

EXPRESSAO:
      VALOR                      { $$ = $1; }
    | VARIAVEL                   { $$ = simb[$1 - 'a']; }
    | VARIAVEL IGUAL EXPRESSAO  { simb[$1 - 'a'] = $3; $$ = $3; }
    | EXPRESSAO EXPRESSAO MAIS  { $$ = $1 + $2; }
    | EXPRESSAO EXPRESSAO MENOS { $$ = $1 - $2; }
    | EXPRESSAO EXPRESSAO MULTI { $$ = $1 * $2; }
    | EXPRESSAO EXPRESSAO DIVISAO { $$ = $1 / $2; }
;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Erro: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}