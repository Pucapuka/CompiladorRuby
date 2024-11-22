prog: ./compiler/grammar.l ./compiler/grammar.y
	flex ./compiler/grammar.l
	bison -d ./compiler/grammar.y
	gcc -o cruby grammar.tab.c lex.yy.c -lfl

clean:
	rm -f lex.* grammar.tab.* cruby