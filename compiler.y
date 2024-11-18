%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tabela_simbolos.h"

// Função para exibir mensagens de erro
void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}

int yylex(void);
%}

%token TIPO_INT TIPO_CHAR IDENTIFIER
%union {
    int valor_int;
    char *valor_str;
}

%type <valor_str> IDENTIFIER
%type <valor_int> TIPO_INT

%%
programa:
    declaracoes
    ;

declaracoes:
    declaracao
    | declaracoes declaracao
    ;

declaracao:
    TIPO_INT IDENTIFIER ';' { printf("Declaração de int: %s\n", $2); }
    | TIPO_CHAR IDENTIFIER ';' { printf("Declaração de char: %s\n", $2); }
    ;

%%

int main() {
    return yyparse();
}
