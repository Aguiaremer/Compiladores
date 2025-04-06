all:
	@bison -d CalcRPN.y -o CalcRPN.tab.c
	@flex CalcRPN.l
	@gcc CalcRPN.tab.c lex.yy.c -Wall -o CalcRPN