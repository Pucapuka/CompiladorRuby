int w = 2;

int main() {
    w = 3;  // Atribuição do valor de w dentro da função main

    if (1) {
        int a;
        int b;

        if (5) {
            b = 5;
            w = 3;
            int c = 9; // Variável 'c' acessível apenas dentro deste bloco
        }
    }

    int b = 0;

    // Laço for, manipulando a variável 'w'
    for (w = 0; w < 1; w = w + 1) {
        int y;
        for (y = 1; y < 4; y = y + 2) {
            int b = 0;
            b = 1 + 2 - 3 * (5 / 4);  // Cálculo e atribuição a b
        }
    }

    int y;
    char a = 'a';

    // Correção para 'x' não declarado. Declaramos 'x'
    int x;
    if (y == 5)
        x = 5;  // Agora 'x' está declarado
    else
        w = 5;

    // Laço while infinito
    while (1) {
        int kk;  // Variável kk declarada dentro do laço
        // Normalmente, seria bom adicionar uma condição de saída ou ação dentro do laço
        // Aqui o laço ficaria infinito sem um comando de interrupção, como um 'break'
    }

    return 0; // Retorno para indicar sucesso
}
