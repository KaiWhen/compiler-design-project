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

"if" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (IF); }
"else" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (ELSE); }
"then" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (THEN); }
"bool" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (BOOL); }
"int" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (INT); }
"true" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (TRUE); }
"false" 	{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (FALSE); }
"void" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (VOID); }
"printf" 	{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (PRINTF); }
"string" 	{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (STR); }
"struct" 	{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (STRUCT); }
"for" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (FOR); }
"return" 	{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (RETURN); }

"<" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (LT); }
"<=" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (LTE); }
">" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (GT); }
">=" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (GTE); }
"=="		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (EQ); }
"!=" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (NE); }
"{" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (LCB); }
"}" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (RCB); }
";" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (SC); }
"!" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (NEG); }
"(" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (LB); }
")" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (RB); }
"+" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (PLUS); }
"-" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (MINUS); }
"*" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (MUL); }
"/" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (DIV); }
"." 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (DOT); }
"=" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (ASGN); }
"mod" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (MOD); }
"and" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (AND); }
"or" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (OR); }
"not" 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (NOT); }


{ID}+ 		{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (ID); }


{Digit}+ 	{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (NUM); }
{String} 	{ printf("[token at line %d: \"%s\"]\n", yylineno, yytext); return (STRLIT); }


{WhiteSp} 	{  }

\n          { return (EOL); }

<<EOF>>     { yyterminate(); }

.       	{ printf("ERROR"); return *yytext; yyterminate(); }

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


