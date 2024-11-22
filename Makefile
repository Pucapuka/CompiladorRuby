prog: ./compiler/lexer.l ./compiler/grammar.y
	flex ./compiler/lexer.l
	bison -d ./compiler/grammar.y
	gcc -o cruby grammar.tab.c lex.yy.c -lfl

clean:
	rm -f lex.* grammar.tab.* cruby