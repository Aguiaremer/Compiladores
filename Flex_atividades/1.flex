%{
#undef yywrap
#define yywrap() 1
%}

%%


-?[0-9]+.?[0-9]+?E?-?[0-9]+? printf("Numero real detectado");
\([0-9]{2}\)\ 9[0-9]{4}-[0-9]{4}  printf("Numero de telefone detectado");
.|\n;

%%

int main()
{
	yylex();
}
