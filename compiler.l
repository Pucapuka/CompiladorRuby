%{
#include "compiler.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

IDENTIFIER [a-zA-Z_][a-zA-Z_0-9]*

%%

{IDENTIFIER} {
    yylval.valor_int = 0;  // Atribua um valor apropriado ou use um valor padrão
    return IDENTIFIER;
}

"int" {
    return TIPO_INT;
}

"char" {
    return TIPO_CHAR;
}

[0-9]+ {
    yylval.valor_int = atoi(yytext); 
    return TIPO_INT;
}

[ \t\n]+  { /* Ignora espaços, tabs e novas linhas */ }

. { /* Ignora outros caracteres */ }

%%

int yywrap(void) {
    return 1;
}
