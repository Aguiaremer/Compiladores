%{
#include <stdio.h>
#include <stdlib.h>
#define MAX 100

#undef yywrap
#define yywrap() 1

// Definindo uma pilha
typedef struct {
    int topo;
    float itens[MAX];
} Pilha;

void inicializar(Pilha *p);
int estaVazia(Pilha *p);
int estaCheia(Pilha *p);
void push(Pilha *p, float valor);
float pop(Pilha *p);
float topo(Pilha *p);

Pilha calc_pilha;
%}

%%

[+-]?([0-9]+)|([0-9]*\.[0-9]+) {
    push(&calc_pilha,atof(yytext));
    }
\+ {
    float x = pop(&calc_pilha);
    float y = pop(&calc_pilha);
    push(&calc_pilha,y+x);
}
\- {
    float x = pop(&calc_pilha);
    float y = pop(&calc_pilha);
    push(&calc_pilha,y-x);
}
\* {
    float x = pop(&calc_pilha);
    float y = pop(&calc_pilha);
    push(&calc_pilha,y*x);
}
\/ {
    float x = pop(&calc_pilha);
    float y = pop(&calc_pilha);
    push(&calc_pilha,y/x);
}
= {
    printf("%.2f\n",topo(&calc_pilha));
}
.|\n|\r;

%%

int main()
{
    inicializar(&calc_pilha);
	yylex();
}


// Inicializa a pilha
void inicializar(Pilha *p) {
    p->topo = -1;
}

// Verifica se a pilha está vazia
int estaVazia(Pilha *p) {
    return (p->topo == -1);
}

// Verifica se a pilha está cheia
int estaCheia(Pilha *p) {
    return (p->topo == MAX - 1);
}

// Adiciona um elemento no topo da pilha
void push(Pilha *p, float valor) {
    if (estaCheia(p)) {
        printf("Erro: Pilha cheia!\n");
        return;
    }
    p->itens[++(p->topo)] = valor;
}

// Remove o elemento do topo da pilha e retorna
float pop(Pilha *p) {
    if (estaVazia(p)) {
        printf("Erro: Pilha vazia!\n");
        return -1.0;  // Retorno de erro
    }
    return p->itens[(p->topo)--];
}

// Retorna o elemento do topo sem removê-lo
float topo(Pilha *p) {
    if (estaVazia(p)) {
        printf("Erro: Pilha vazia!\n");
        return -1.0;
    }
    return p->itens[p->topo];
}