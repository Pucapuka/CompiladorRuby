%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>         /* Necessário para strdup */
#include "compiler.tab.h"   /* Cabeçalho gerado pelo Bison */
%}

%%

 /* Definindo os padrões para os tokens */
[0-9]+                  { yylval.valor_int = atoi(yytext); return NUMERO; }
[ \t\n]+                { /* ignora espaços em branco */ }
"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }
"="                     { return '='; }
[A-Za-z_][A-Za-z0-9_]*  { yylval.nome = strdup(yytext); return IDENTIFIER; }

%%

int yywrap(void) {
    return 1;  /* Indica o final da entrada */
}

int main() {
    yylex();  // Chama a função yylex gerada automaticamente
    return 0;
}
