%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>  // Para usar strdup()
#include <stdarg.h>  // Necessário para va_list em yyerror
#include "tabela_simbolos.h"  // Inclusão de cabeçalho para a tabela de símbolos

// Funções auxiliares para código intermediário e temporários
void adicionar_instrucao(const char* op, const char* arg1, const char* arg2, const char* result);
const char* nova_temp();
const char* temp_atual();
void yyerror(const char *s, ...);  // Definição da função yyerror
extern int yylex(void);  // Declaração da função yylex no Bison
%}

%union {
    int valor_int;      // Para armazenar valores inteiros
    char* nome;         // Para armazenar identificadores e temporários
}

// Definindo os tokens com os tipos apropriados
%token <valor_int> NUMERO
%token <nome> IDENTIFIER

%type <nome> exp term fator

%start programa

%%

// Regra principal, que utiliza 'exp' e conecta todas as outras regras
programa:
    exp ';' { printf("Programa reconhecido com sucesso.\n"); }
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
        sprintf(temp, "%d", $1);  // Convertendo o inteiro para string
        $$ = temp;
    }
    | IDENTIFIER { 
        $$ = strdup($1);  // Armazenando o nome do identificador
    }
    | '(' exp ')' { $$ = $2; }
    ;

%%

// Funções de suporte

// Função de geração de código intermediário
void adicionar_instrucao(const char* op, const char* arg1, const char* arg2, const char* result) {
    printf("Instrucao: %s %s, %s -> %s\n", op, arg1, arg2, result);
}

// Função para gerar novos temporários
const char* nova_temp() {
    static int contador_temp = 0;
    char* nome = malloc(10);
    sprintf(nome, "t%d", contador_temp++);
    return nome;
}

// Função para retornar o temporário atual
const char* temp_atual() {
    static int contador_temp = 0;
    char* nome = malloc(10);
    sprintf(nome, "t%d", contador_temp);
    return nome;
}

// Função de erro para a sintaxe
void yyerror(const char *s, ...) {
    va_list args;
    va_start(args, s);
    vfprintf(stderr, s, args);
    va_end(args);
}
