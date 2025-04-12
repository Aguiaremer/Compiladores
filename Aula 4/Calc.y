%{

#include <stdio.h>
#include <string.h>

int yywrap( );
void yyerror(const char* str);

double result = 0;
int symb[26];

%}

%union {
  double value;
  int valueInt;
}

%token <value> VAL
%token PLUS
%token MINUS
%token DIVIDE
%token TIMES
%token LEFT
%token RIGHT
%token DONE
%token <valueInt> VARIABLE
%token LT GT LB RB EQUALS
%token IF ELSE 

%type <value> stmt simple_exp term factor exp ifstmt

%error-verbose

%%

progexec: stmt
    |  stmt progexec

stmt: 
    | atrib DONE {}
    | simple_exp DONE {result = $1; return 0;}
    | ifstmt DONE {result = $1; return 0;}


ifstmt: IF exp LB simple_exp RB  {
          if($2){
            $$=$4;
          }
        }    
      | IF exp LB simple_exp RB ELSE LB simple_exp RB  {
          if($2){
            $$=$4;
          }
          else{
            $$=$8;
          }
        }

atrib: VARIABLE EQUALS simple_exp { symb[$1] = $3;}

exp : simple_exp {$$=$1;}
    | simple_exp GT simple_exp {$$ = ($1 > $3) ? 1 : 0;}
    | simple_exp LT simple_exp {$$ = ($1 < $3) ? 1 : 0;}
    | simple_exp EQUALS simple_exp {$$ = ($1 == $3) ? 1 : 0;}
    

simple_exp: simple_exp PLUS term {$$ = $1 + $3;}
    | simple_exp MINUS term {$$ = $1 - $3;}
    | term {$$ = $1;}

term: term TIMES factor {$$ = $1 * $3;}
    | term DIVIDE factor {$$ = $1 / $3;}
    | factor {$$ = $1;}

factor: VAL {$$ = $1;}
      | LEFT exp RIGHT {$$ = $2;}
      | VARIABLE { $$ = symb[$1];}

%%

int yywrap( ) {
  return 1;
}

void yyerror(const char* str) {
  fprintf(stderr, "Compiler error: '%s'.\n", str);
}

int main( ) {
  yyparse( );
  printf("The answer is %lf\n", result);
  return 0;
}


