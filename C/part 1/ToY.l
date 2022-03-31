%option noyywrap

%{
#include <stdio.h>
#include <string.h>
%}

Digit           [0 - 9]
ID              [_a-zA-Z][_a-zA-Z0-9]
String          \"([^\\\"]|\\\.)*\"
LineTerminator  \r|\n|\r\n
WhiteSp         {LineTerminator} | [ \t\f]
Comment         \^\/\/.*|##.*
Comment2         \/\/[^\r\n]*

%%

"if" 		{ printf("VALID\n"); }
"else" 		{ printf("VALID\n"); }
"then" 		{ printf("VALID\n"); }
"bool" 		{ printf("VALID\n"); }
"int" 		{ printf("VALID\n"); }
"true" 		{ printf("VALID\n"); }
"false" 	{ printf("VALID\n"); }
"void" 		{ printf("VALID\n"); }
"printf" 	{ printf("VALID\n"); }
"string" 	{ printf("VALID\n"); }
"struct" 	{ printf("VALID\n"); }
"for" 		{ printf("VALID\n"); }
"return" 	{ printf("VALID\n"); }

"<" 		{ printf("VALID\n"); }
"<=" 		{ printf("VALID\n"); }
">" 		{ printf("VALID\n"); }
">=" 		{ printf("VALID\n"); }
"=="		{ printf("VALID\n"); }
"!=" 		{ printf("VALID\n"); }
"{" 		{ printf("VALID\n"); }
"}" 		{ printf("VALID\n"); }
";" 		{ printf("VALID\n"); }
"!" 		{ printf("VALID\n"); }
"(" 		{ printf("VALID\n"); }
")" 		{ printf("VALID\n"); }
"+" 		{ printf("VALID\n"); }
"-" 		{ printf("VALID\n"); }
"*"         { printf("VALID\n"); }
"/"         { printf("VALID\n"); }
"." 		{ printf("VALID\n"); }
"=" 		{ printf("VALID\n"); }
"mod" 		{ printf("VALID\n"); }
"and" 		{ printf("VALID\n"); }
"or" 		{ printf("VALID\n"); }
"not" 		{ printf("VALID\n"); }

{ID}+ 		{ printf("VALID\n"); }

{Digit}+ 	{ printf("VALID\n"); }
{String} 	{ printf("VALID\n"); }

{WhiteSp} 	{}

{Comment} 	{ printf("VALID\n"); }

.       	{ printf("ERROR\n"); yyterminate(); }

%%

int main( int argc, char **argv )
{
    ++argv, --argc;
    if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
    else
        yyin = stdin;
        yylex();
}


