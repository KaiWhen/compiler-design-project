default:
	clear
	flex -l ToY.l
	bison -d ToY.y 
	gcc -o ToY ToY.tab.c lex.yy.c -lm

clean:
	rm ToY ToY.tab.* lex.yy.c
