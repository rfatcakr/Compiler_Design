all: yacc lex
	cc lex.yy.c y.tab.c -o example4

yacc: a.y
	yacc -d a.y

lex: a.l
	lex a.l


