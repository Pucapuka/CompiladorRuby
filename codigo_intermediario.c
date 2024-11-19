#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "codigo_intermediario.h"

#define MAX_INSTRUCOES 1000
#define MAX_TEMP_VARS 100

static Instrucao instrucoes[MAX_INSTRUCOES];
static int contador_instrucoes = 0;
static int contador_temp = 0; // Contador para as variáveis temporárias

void adicionar_instrucao(const char *op, const char *arg1, const char *arg2, const char *result) {
    if (contador_instrucoes >= MAX_INSTRUCOES) {
        fprintf(stderr, "Erro: Número máximo de instruções intermediárias excedido.\n");
        exit(1);
    }
    instrucoes[contador_instrucoes].op = strdup(op);
    instrucoes[contador_instrucoes].arg1 = strdup(arg1);
    instrucoes[contador_instrucoes].arg2 = arg2 ? strdup(arg2) : NULL;
    instrucoes[contador_instrucoes].result = strdup(result);
    contador_instrucoes++;
}

void exibir_codigo_intermediario() {
    for (int i = 0; i < contador_instrucoes; i++) {
        printf("%s = %s %s %s\n", instrucoes[i].result, instrucoes[i].arg1, instrucoes[i].op, instrucoes[i].arg2 ? instrucoes[i].arg2 : "");
    }
}

void liberar_codigo() {
    for (int i = 0; i < contador_instrucoes; i++) {
        free(instrucoes[i].op);
        free(instrucoes[i].arg1);
        if (instrucoes[i].arg2) free(instrucoes[i].arg2);
        free(instrucoes[i].result);
    }
    contador_instrucoes = 0;
}

char* nova_temp() {
    char* temp = (char*)malloc(10);
    snprintf(temp, 10, "t%d", contador_temp++);
    return temp;
}
