#ifndef CODIGO_INTERMEDIARIO_H
#define CODIGO_INTERMEDIARIO_H

typedef struct Instrucao {
    char *op;
    char *arg1;
    char *arg2;
    char *result;
} Instrucao;

//void inicializar_codigo();
void adicionar_instrucao(const char *op, const char *arg1, const char *arg2, const char *result);
void exibir_codigo_intermediario();
void liberar_codigo();
char* nova_temp(); // Declaração da função nova_temp

#endif
