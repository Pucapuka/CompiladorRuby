%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>         /* Necessário para strdup */
#include "compiler.tab.h"   /* Cabeçalho gerado pelo Bison */

// Variáveis para rastrear linha e coluna
extern int yylineno;  // A variável yylineno já é definida no Flex
int yycolumn = 1;     // Definindo yycolumn globalmente

%}

%%

    /* Definindo os padrões para os tokens */
[0-9]+                  { yylval.valor_int = atoi(yytext); return NUMERO; }
[ \t]+                  { yycolumn += yyleng; }  // Conta o número de caracteres (coluna) que avançou
"\n"                    { ++yylineno; yycolumn = 1; }  // Incrementa a linha e reseta a coluna
"+"                     { ++yycolumn; return '+'; }
"-"                     { ++yycolumn; return '-'; }
"*"                     { ++yycolumn; return '*'; }
"/"                     { ++yycolumn; return '/'; }
"="                     { ++yycolumn; return '='; }
[A-Za-z_][A-Za-z0-9_]*  { yylval.nome = strdup(yytext); ++yycolumn; return IDENTIFIER; }

%%

int yywrap(void) {
    return 1;  /* Indica o final da entrada */
}
