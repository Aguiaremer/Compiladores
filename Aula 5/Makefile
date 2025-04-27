all:
	@bison -d Calc.y -o Calc.tab.c
	@flex Calc.l
	@gcc Calc.tab.c lex.yy.c -Wall -o Calc