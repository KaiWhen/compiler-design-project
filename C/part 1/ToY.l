%option noyywrap

%{
#include <stdio.h>
#include <string.h>
#include "ToY.tab.h"
%}

Digit           [0-9]
ID              [_a-zA-Z][_a-zA-Z0-9]+
String          \"([^\\\"]|\\\.)*\"
LineTerminator  \r|\n|\r\n
WhiteSp         {LineTerminator} | [ \t\f]
UCN	            (\\u[0-9a-fA-F]{4}|\\U[0-9a-fA-F]{8})

%%

"if" 		{  return (IF); }
"else" 		{  return (ELSE); }
"then" 		{  return (THEN); }
"bool" 		{  return (BOOL); }
"int" 		{  return (INT); }
"true" 		{  return (TRUE); }
"false" 	{  return (FALSE); }
"void" 		{  return (VOID); }
"printf" 	{  return (PRINTF); }
"string" 	{  return (STR); }
"struct" 	{  return (STRUCT); }
"for" 		{  return (FOR); }
"return" 	{  return (RETURN); }

"<" 		{  return (LT); }
"<=" 		{  return (LTE); }
">" 		{  return (GT); }
">=" 		{  return (GTE); }
"=="		{  return (EQ); }
"!=" 		{  return (NE); }
"{" 		{  return (LCB); }
"}" 		{  return (RCB); }
";" 		{  return (SC); }
"!" 		{  return (NEG); }
"(" 		{  return (LB); }
")" 		{  return (RB); }
"+" 		{  return (PLUS); }
"-" 		{  return (MINUS); }
"*" 		{  return (MUL); }
"/" 		{  return (DIV); }
"." 		{  return (DOT); }
"=" 		{  return (ASGN); }
"mod" 		{  return (MOD); }
"and" 		{  return (AND); }
"or" 		{  return (OR); }
"not" 		{  return (NOT); }


([_a-zA-Z]|{UCN})([_a-zA-Z0-9]|{UCN})* 		{  return (ID); }


{Digit}+ 	{  return (NUM); }
{String} 	{  return (STRLIT); }


{WhiteSp} 	{  }

\n          { return (EOL); }

<<EOF>>     { yyterminate(); }

.       	{ printf("ERROR"); return *yytext; yyterminate(); }

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


