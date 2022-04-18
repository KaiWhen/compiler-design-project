%option noyywrap

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <limits.h>
    #include "ToY.tab.h"
    #include "semantics.h"
    #include "symtab.h"
%}

Digit           -?[0-9]+
ID              [_a-zA-Z][_a-zA-Z0-9]*
String          \"([^\\\"]|\\\.)*\"
WhiteSp         [ \n\t\r]+

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

","         {  return (COMMA); }
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


{ID}		{ 
                insert(yytext, strlen(yytext), UNDEF, yylineno);
				yylval.symtab_item = lookup(yytext);
                 return (ID); 
            }


{Digit} 	{
        if(atof(yytext) < INT_MIN || atof(yytext) > INT_MAX) { 
            printf("ERROR\n"); return *yytext; yyterminate(); 
        } 
        else  
        return (NUM); 
    }
{String} 	{  return (STRLIT); }

"//".*|"#".*      {  } 

{WhiteSp} 	{  }

\n          { return (EOL); }

<<EOF>>     { yyterminate(); }

.       	{ printf("ERROR\n"); return *yytext; yyterminate(); }

%%

 /* int main( int argc, char **argv )
 {
     ++argv, --argc;
     if ( argc > 0 )
         yyin = fopen( argv[0], "r" );
     else
         yyin = stdin;
         yylex();
 } */


