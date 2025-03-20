%{
/*Reconhecedor de: 
Nro. real com qualquer representação (científica, sinal, etc). Exemplos:
	1 ; 1.0 ; -1 ; -1.0 ; 1.99 ; 0.99 ; 1.0E05 ; 0.99E-05 ... 
Nros. Romanos: de 0 a 1999
	Incluindo os símbolos: I=1, V=5, X=10, L=50, C=100, D=500, M=1000
Números de telefone válidos no Brasil, inclusive com operadora. Exemplos:
	55555555 ; 5555.5555 ; 5555-5555 ; (55) 55555555 ; 55-5555.5555 ; (55) (55) 5555-5555 ; */


#undef yywrap
#define yywrap() 1
%}

%%

(\(?[0-9]{2}\)?[ ]?)?(\(?[0-9]{2}\)?)?[ ]?[9]?[0-9]+{4}\-[0-9]+{4}  printf("Numero de telefone detectado");
[+-]?(([0-9]+)|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) printf("Numero real detectado");
M?(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3}) printf("Numero romano detectado\n");
.|\n;

%%

int main()
{
	yylex();
}
