#ifndef TABELA_SIMBOLOS_H
#define TABELA_SIMBOLOS_H

#define TYPE_INT 300
#define TYPE_CHAR 301

typedef struct Simbolo {
    char nome[100];
    int tipo;
    int valor_int;
    char valor_char;
    struct Simbolo* prox;
} Simbolo;

Simbolo* buscar_simbolo(const char* nome);
void inserir_simbolo(const char* nome, int tipo);

#endif
