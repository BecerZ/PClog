out: y.tab.c lex.yy.c
	cc -o parser y.tab.c
y.tab.c: cs315f17_group16.yacc lex.yy.c
	yacc -v cs315f17_group16.yacc
lex.yy.c: cs315f17_group16.lex
	lex cs315f17_group16.lex
clean:
	rm -f lex.yy.c y.tab.c out
