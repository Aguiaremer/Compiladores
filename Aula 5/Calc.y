%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int yywrap();
void yyerror(const char *str);

double result = 0;
int symb[26];
typedef enum { INT_TYPE, FLOAT_TYPE, CHAR_TYPE, STRING_TYPE, BOOL_TYPE, UNDEFINED_TYPE } VarType;

typedef struct {
    VarType type;
    union {
        int iValue;
        float fValue;
        char cValue;
        char* sValue;
        int bValue; // 0 or 1 for boolean
    } value;
} Symbol;

Symbol symbolTable[26]; // Support up to 26 variables (a-z)

%}

%union {
    double value;
    int valueInt;
    Symbol symbol;
}

%token <value> VAL
%token PLUS MINUS DIVIDE TIMES LEFT RIGHT DONE
%token <valueInt> VARIABLE
%token LT GT LB RB EQUALS 
%token IF ELSE INT FLOAT CHAR STRING BOOL

%type <value> stmt simple_exp term factor exp ifstmt type_decl

%error-verbose

%%

progexec: stmt
    | stmt progexec

stmt: 
    | atrib DONE {}
    | simple_exp DONE {result = $1; return 0;}
    | ifstmt DONE {result = $1; return 0;}

atrib: VARIABLE EQUALS simple_exp { 
        // Verifica o tipo da variável antes da atribuição
        if (symbolTable[$1].type == UNDEFINED_TYPE) {
            printf("Erro: variável '%c' não definida.\n", $1 + 'a');
            return 0;
        }
        if (symbolTable[$1].type == BOOL_TYPE && (int)$3 != 0 && (int)$3 != 1) {
            printf("Erro: variável booleana '%c' não pode receber um valor diferente de 0 ou 1.\n", $1 + 'a');
            return 0;
        }
        symbolTable[$1] = symbolTable[$3];  // Atribui o valor  variável
    }

simple_exp: simple_exp PLUS term {$$ = $1 + $3;}
    | simple_exp MINUS term {$$ = $1 - $3;}
    | term {$$ = $1;}

term: term TIMES factor {$$ = $1 * $3;}
    | term DIVIDE factor {$$ = $1 / $3;}
    | factor {$$ = $1;}

factor: VAL {$$ = $1;}
      | LEFT exp RIGHT {$$ = $2;}
      | VARIABLE { 
          if (symbolTable[$1].type == UNDEFINED_TYPE) {
              printf("Erro: variável '%c' não definida.\n", $1 + 'a');
              return 0;
          }
          $$ = symbolTable[$1].value.iValue; 
      }

ifstmt: IF exp LB simple_exp RB {
        if($2){
            $$ = $4;
        }
    }    
    | IF exp LB simple_exp RB ELSE LB simple_exp RB {
        if($2){
            $$ = $4;
        }
        else{
            $$ = $8;
        }
    }

exp: simple_exp { $$ = $1; }
    | simple_exp GT simple_exp { $$ = ($1 > $3) ? 1 : 0; }
    | simple_exp LT simple_exp { $$ = ($1 < $3) ? 1 : 0; }
    | simple_exp EQUALS simple_exp { $$ = ($1 == $3) ? 1 : 0; }

type_decl: INT { $$ = INT_TYPE; }
         | FLOAT { $$ = FLOAT_TYPE; }
         | CHAR { $$ = CHAR_TYPE; }
         | STRING { $$ = STRING_TYPE; }
         | BOOL { $$ = BOOL_TYPE; }

%%

int yywrap() {
    return 1;
}

void yyerror(const char* str) {
    fprintf(stderr, "Compiler error: '%s'.\n", str);
}

int main() {
    yyparse();
    printf("The answer is %lf\n", result);
    return 0;
}
