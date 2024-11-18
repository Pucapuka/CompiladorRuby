%{
#include "compiler.tab.h"
#include <string.h>
#include <stdlib.h>

// Definindo yywrap como um protótipo completo para evitar o aviso
int yywrap(void) {
    return 1;
}
%}

IDENTIFIER [a-zA-Z_][a-zA-Z_0-9]*

%%

"int"       { return TIPO_INT; }
"char"      { return TIPO_CHAR; }

{IDENTIFIER} {
    yylval.valor_str = strdup(yytext);
    return IDENTIFIER;
}

[0-9]+      {
    yylval.valor_int = atoi(yytext);
    return TIPO_INT;
}

[ \t\n]+    ;       // Ignora espaços em branco

.           ;       // Ignora outros caracteres

%%