%{
// identificador de um formato (XX) 9XXXX-YYYY

#undef yywrap
#define yywrap() 1
%}

%%

\([0-9]{2}\)\ 9[0-9]{4}-[0-9]{4}  printf("detecto");
.|\n;

%%

int main()
{
    printf("escreva um numero de telefone");
	yylex();
}
