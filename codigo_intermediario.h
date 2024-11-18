#ifndef CODIGO_INTERMEDIARIO_H
#define CODIGO_INTERMEDIARIO_H

typedef struct {
    char *op;      // Operador
    char *arg1;    // Primeiro argumento
    char *arg2;    // Segundo argumento (se necessário)
    char *result;  // Resultado da operação
} Instrucao;

void inicializar_codigo();
void adicionar_instrucao(const char *op, const char *arg1, const char *arg2, const char *result);
void exibir_codigo_intermediario();
void liberar_codigo();

#endif
