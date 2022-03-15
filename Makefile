default:
	clear
	jflex ToY.l
	javac *.java

test:
	java ToY.java test.txt

clean:
	rm *.java *.class *java\~
