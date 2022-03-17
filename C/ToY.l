%option noyywrap

%{
#include <stdio.h>
#include <string.h>
#include "ToY.tab.h"
%}

Digit           [0 - 9]
ID              [_a-zA-Z][_a-zA-Z0-9]
String          \"([^\\\"]|\\\.)*\"
LineTerminator  \r|\n|\r\n
WhiteSp         {LineTerminator} | [ \t\f]

%%

"if" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (KEYWORD); }
"else" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (KEYWORD); }
"then" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (KEYWORD); }
"bool" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (KEYWORD); }
"int" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (KEYWORD); }
"true" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (KEYWORD); }
"false" 	{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (KEYWORD); }
"void" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (KEYWORD); }
"printf" 	{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (KEYWORD); }
"string" 	{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (KEYWORD); }
"struct" 	{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (KEYWORD); }
"for" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (KEYWORD); }
"return" 	{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (KEYWORD); }

"<" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
"<=" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
">" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
">=" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
"=="		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
"!=" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
"{" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
"}" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
";" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
"!" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
"(" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
")" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
"+" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
"-" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
"." 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
"=" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
"mod" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
"and" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
"or" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }
"not" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OP); }


{ID}+ 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (ID); }


{Digit}+ 	{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (INT); }
{String} 	{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (STRING); }


{WhiteSp} 	{  }

\n          { return (EOL); }

<<EOF>>     { yyterminate(); }

.       	{return *yytext; yyterminate(); }

%%

// int main( int argc, char **argv )
// {
//     ++argv, --argc;
//     if ( argc > 0 )
//         yyin = fopen( argv[0], "r" );
//     else
//         yyin = stdin;
//         yylex();
// }


