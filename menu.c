#include <stdio.h>
#include <stdlib.h>

// Função para exibir a tela inicial
void mostrar_tela_inicial() {
    system("clear"); // Limpa a tela

    // Adiciona fundo roxo e letras brancas
    printf("\033[37;45m");
    // Usa figlet para gerar letras grandes
    system("figlet 'IFMA - Imperatriz'");
    system("figlet 'Prof.: Varley'");
    system("figlet 'Alunos: Lucas, Ângelo, Paulo Anderson, Ester'");

    printf("\nPressione qualquer tecla para continuar...\n");
    printf("\033[0m"); // Reseta cores para o padrão do terminal
    getchar(); // Aguarda o usuário pressionar uma tecla
}

// Função para exibir o menu da segunda tela
void mostrar_menu() {
    printf("\nOpções:\n");
    printf("1) Exemplo Geral com If Elsif e Else\n");
    printf("2) Exemplo com erro sintático\n");
    printf("3) Exemplo com erro semântico\n");
    printf("4) Exemplo com Código Intermediário de três endereços\n");
    printf("0) Sair\n");
    printf("\nEscolha uma opção: ");
}

// Função para executar um comando usando o Makefile e o programa cruby
void executar_comando(const char *arquivo) {
    system("make"); // Executa o comando 'make'
    char comando[256];
    snprintf(comando, sizeof(comando), "./cruby < samples/%s", arquivo); // Monta o comando
    system(comando); // Executa o comando
}

// Função principal
int main() {
    int opcao;

    // Mostra a tela inicial
    mostrar_tela_inicial();

    do {
        system("clear"); // Limpa a tela no terminal
        mostrar_menu();
        scanf("%d", &opcao);
        getchar(); // Limpa o buffer do teclado

        switch (opcao) {
        
            case 1:
                executar_comando("IfElsifElseSample.rb");
                break;
            case 2:
                executar_comando("syntacticDefError.rb");
                break;
            case 3:
                executar_comando("semanticErrorSample.rb");
                break;
            case 4:
                executar_comando("threeAddressSample.rb");
                break;
            case 0:
                printf("\nSaindo...\n");
                break;
            default:
                printf("\nOpção inválida. Tente novamente.\n");
                break;
        }

        if (opcao != 0) {
            printf("\nPressione qualquer tecla para voltar ao menu...\n");
            getchar();
        }

    } while (opcao != 0);

    printf("\nPrograma encerrado. Obrigado por usar o COMPILADOR C-RUBY!\n");
    return 0;
}
