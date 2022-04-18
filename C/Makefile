default:
	clear
	bison -d ToY.y 
	flex -l ToY.l
	gcc -o ToY ToY.tab.c lex.yy.c

clean:
	rm ToY ToY.tab.* lex.yy.c
