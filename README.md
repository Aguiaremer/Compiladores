# Compiladores

Repositório de materiais e exercícios da disciplina de **Compiladores**. A pasta está organizada por aula e reúne especificações do Flex (`.l`), gramáticas do Bison (`.y`), arquivos C gerados, executáveis e um PDF de exercícios.

## Organização

| Pasta | Conteúdo |
|---|---|
| `Aula 1` | PDF de exercícios de Lex/Flex e dois exemplos: reconhecimento de números/telefones/números romanos e ocultação de texto usando estados do Flex. |
| `Aula 2` | Calculadora de expressões em notação pós-fixa (RPN), implementada com Flex e uma pilha em C. |
| `Aula 3` | Calculadora RPN com Flex e Bison, incluindo valores, variáveis e operações aritméticas. |
| `Aula 4` | Calculadora com expressões infixas, variáveis, comparações e estruturas `if`/`else`. |
| `Aula 5` | Continuação do exemplo de calculadora, com tokens para tipos e uma tabela de símbolos em desenvolvimento. |
| `Aula 6` | Arquivo `3end.l` com regras léxicas para palavras-chave, identificadores, números e operadores. Não há nesta pasta uma gramática Bison correspondente. |

## Compilar os exemplos

Os Makefiles chamam `flex`, `bison` e `gcc`. Instale essas ferramentas e o `make` antes de compilar. No Windows, use um ambiente que disponibilize esses comandos, como MSYS2/MinGW ou WSL.

Execute `make` dentro da pasta do exemplo. Por exemplo:

```sh
cd "Aula 3"
make
```

Os exemplos das Aulas 1 e 2 usam Flex e GCC; as Aulas 3, 4 e 5 também geram o parser com Bison. Para compilar manualmente o exercício 1 da Aula 1:

```sh
cd "Aula 1/Exercício 1"
make
```

O executável é criado na própria pasta. Os arquivos `lex.yy.c`, `*.tab.c` e `*.tab.h` são saídas geradas pelo Flex/Bison; os executáveis `.exe` já presentes são binários previamente compilados.

## Observações

- A Aula 6 inclui `#include "3end.tab.h"`, mas não contém `3end.y` nem esse cabeçalho. Portanto, o arquivo ainda não pode ser compilado como está.
- A Aula 5 parece ser um protótipo em andamento: embora existam tokens e regras para tipos, a gramática atual não inclui uma produção de declaração de variáveis. Confira e valide os exemplos antes de usá-los como referência de um compilador funcional.
- Alguns nomes de Makefile variam entre `Makefile` e `makefile`; em sistemas de arquivos que diferenciam maiúsculas de minúsculas, use o nome existente na pasta.
