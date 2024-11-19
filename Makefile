CC = gcc
BISON = bison
FLEX = flex
CFLAGS = -g -Wall

# Nome do arquivo executável
EXEC = cruby

# Arquivos de origem
OBJS = compiler.tab.c lex.yy.c tabela_simbolos.o codigo_intermediario.o

# Alvo padrão
all: $(EXEC)

# Regra para gerar o executável
$(EXEC): $(OBJS)
	$(CC) $(CFLAGS) -o $(EXEC) $(OBJS)

# Regra para gerar o arquivo compiler.tab.c usando o Bison
compiler.tab.c: compiler.y
	$(BISON) -d compiler.y

# Regra para gerar o arquivo lex.yy.c usando o Flex
lex.yy.c: compiler.l
	$(FLEX) compiler.l

# Regra para compilar tabela_simbolos.c
tabela_simbolos.o: tabela_simbolos.c
	$(CC) $(CFLAGS) -c tabela_simbolos.c

# Regra para compilar codigo_intermediario.c
codigo_intermediario.o: codigo_intermediario.c
	$(CC) $(CFLAGS) -c codigo_intermediario.c

# Regra de limpeza
clean:
	rm -f *.o lex.yy.c compiler.tab.c compiler.tab.h $(EXEC)
