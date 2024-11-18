%{
#include <stdio.h>
#include <stdlib.h>
#include "tabela_simbolos.h"

extern int yylex(void);
extern void yyerror(const char *s);
%}

%union {
    int valor_int;
    char valor_char;
}

%token <valor_int> TIPO_INT
%token <valor_char> TIPO_CHAR
%token <valor_int> IDENTIFIER
%type <valor_int> expression

%%

program:
    | program statement
;

statement:
      TIPO_INT IDENTIFIER ';'
    | TIPO_CHAR IDENTIFIER ';'
    | expression ';'
;

expression:
    IDENTIFIER { 
        Simbolo* sim = buscar_simbolo(yytext);
        if (sim == NULL) {
            printf("Erro: variável '%s' não declarada.\n", yytext);
            exit(1);
        }
        $$ = sim->valor_int;
    }
    | expression '+' expression
    | expression '-' expression
;

%%

int main(void) {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Erro de sintaxe: %s\n", s);
}
