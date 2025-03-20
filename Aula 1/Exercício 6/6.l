%{
/*Ocultador de Textos com uso e troca de "estados" (%s) do Lex
 Entrada: blá blá <HIDE>Texto oculto</HIDE> blá blá
 Saída : blá blá <HIDE>XXXXXXXXXXXX</HIDE> blá blá */

#undef yywrap
#define yywrap() 1
%}

%x HIDE

%%

."<HIDE>" BEGIN HIDE;
<HIDE>"<HIDE>" BEGIN INITIAL;
<HIDE>. printf("X");
. ECHO;

%%

int main()
{
	yylex();
}