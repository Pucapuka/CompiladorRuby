%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include "tabela_simbolos.h"
#include "codigo_intermediario.h"

extern int yylex();   // Declaração explícita de yylex
// Variáveis para linha e coluna
extern int yylineno;
extern int yycolumn;

void yyerror(const char *s, ...);  // Declaração da função yyerror para o Bison

%}

%union {
    int valor_int;
    char* nome;
}

%token <valor_int> NUMERO
%token <nome> IDENTIFIER

%type <nome> exp term fator atribuicao

%start programa

%%

programa:
    lista_atribuicoes { 
        printf("Fim do processamento\n"); 
        exibir_codigo_intermediario();  // Exibe o código intermediário ao final do processamento
        liberar_codigo();  // Libera memória alocada
    }
    ;

lista_atribuicoes:
    lista_atribuicoes atribuicao ';'
    | atribuicao ';'
    ;

atribuicao:
    IDENTIFIER '=' exp { 
        char* temp = nova_temp();
        adicionar_instrucao("=", $3, "", $1);
        $$ = temp;
    }
    ;

exp:
    exp '+' term { 
        char* temp = nova_temp();
        adicionar_instrucao("+", $1, $3, temp);
        $$ = temp;
    }
    | exp '-' term { 
        char* temp = nova_temp();
        adicionar_instrucao("-", $1, $3, temp);
        $$ = temp;
    }
    | term { $$ = $1; }
    ;

term:
    term '*' fator { 
        char* temp = nova_temp();
        adicionar_instrucao("*", $1, $3, temp);
        $$ = temp;
    }
    | term '/' fator { 
        char* temp = nova_temp();
        adicionar_instrucao("/", $1, $3, temp);
        $$ = temp;
    }
    | fator { $$ = $1; }
    ;

fator:
    NUMERO { 
        char* temp = nova_temp();
        sprintf(temp, "%d", $1);
        $$ = temp;
    }
    | IDENTIFIER { 
        $$ = strdup($1);
    }
    | '(' exp ')' { $$ = $2; }
    ;

%%

// Função de erro
void yyerror(const char *s, ...) {
    va_list args;
    va_start(args, s);
    fprintf(stderr, "Erro na linha %d, coluna %d: ", yylineno, yycolumn);
    vfprintf(stderr, s, args);
    va_end(args);
}

int main() {
    printf("Iniciando o compilador...\n");
    if (yyparse() == 0) {
        printf("Compilação concluída com sucesso!\n");
        exibir_codigo_intermediario();
    } else {
        printf("Falha na compilação.\n");
    }
    liberar_codigo();
    return 0;
}