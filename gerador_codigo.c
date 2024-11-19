#include <stdio.h>
#include <stdlib.h>

// Declaração de variável externa do arquivo `compiler.c`
extern FILE *output; 

// Função para adicionar uma instrução no arquivo de saída
void adicionar_instrucao(const char* op, const char* arg1, const char* arg2, const char* result) {
    // Verifica se o arquivo de saída foi corretamente aberto
    if (output == NULL) {
        fprintf(stderr, "Erro: arquivo de saída não está aberto.\n");
        return;
    }

    // Escreve a instrução no arquivo de saída
    fprintf(output, "%s %s, %s -> %s\n", op, arg1, arg2, result);
}
