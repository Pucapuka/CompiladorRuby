#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tabela_simbolos.h"

Simbolo* tabela_simbolos = NULL;

// Função para buscar um símbolo na tabela de símbolos
Simbolo* buscar_simbolo(const char* nome) {
    Simbolo* sim = tabela_simbolos;
    while (sim != NULL) {
        if (strcmp(sim->nome, nome) == 0) {
            return sim;
        }
        sim = sim->prox;
    }
    return NULL; // Não encontrado
}

// Função para inserir um novo símbolo na tabela
void inserir_simbolo(const char* nome, int tipo) {
    Simbolo* novo = (Simbolo*)malloc(sizeof(Simbolo));
    if (novo == NULL) {
        printf("Erro: Memória insuficiente.\n");
        exit(1);
    }
    strcpy(novo->nome, nome);
    novo->tipo = tipo;
    novo->prox = tabela_simbolos;
    tabela_simbolos = novo;
}
