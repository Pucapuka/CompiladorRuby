prog: ./compiler/grammar.l ./compiler/grammar.y
	bison -d ./compiler/grammar.y
	flex ./compiler/grammar.l
	gcc -o cruby grammar.tab.c lex.yy.c -lfl

clean:
	rm lex.* grammar.tab.* cruby