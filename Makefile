CC = gcc
BISON = bison
FLEX = flex
CFLAGS = -g -Wall

all: cruby

cruby: compiler.tab.c lex.yy.c tabela_simbolos.o
	$(CC) $(CFLAGS) -o cruby compiler.tab.c lex.yy.c tabela_simbolos.o

compiler.tab.c: compiler.y
	$(BISON) -d compiler.y

lex.yy.c: compiler.l
	$(FLEX) compiler.l

tabela_simbolos.o: tabela_simbolos.c
	$(CC) $(CFLAGS) -c tabela_simbolos.c

clean:
	rm -f *.o lex.yy.c compiler.tab.c compiler.tab.h cruby
