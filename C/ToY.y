%define parse.error verbose

%{
#include <stdio.h>
#include <stdlib.h>
#include "sym.h"
#define YYDEBUG 1
extern FILE *yyin;
extern FILE *yyout;

int yylex();
int yyerror(const char *msg);

install (char *sym_name) { 
  symrec *s;
  s = getsym (sym_name);
  if (s == 0)
    s = putsym (sym_name);
  else { 
    printf( "%s is already defined\n", sym_name );
  }
}
context_check(char *sym_name) {
  if(getsym(sym_name) == 0)
    printf("%s is an undeclared identifier\n", sym_name);
}

%}

%token IF BOOL INT TRUE FALSE VOID PRINTF STR STRUCT FOR RETURN
%token LCB RCB SC LB RB DOT
%token NUM STRLIT
%token COMMA
%token EOL

%nonassoc THEN
%nonassoc ELSE
%nonassoc ID
%left OR
%left AND
%right ASGN
%left EQ NE LT LTE GT GTE
%left PLUS MINUS 
%left MUL DIV MOD NEG NOT
%nonassoc prec_unary

%start pgm


%%

type: INT
  | BOOL
  | STR
  | ID
  ;


returntype: type
  | VOID
  ;

struct: STRUCT ID LCB declarationlist RCB
  ;

declarationlist: declaration
  | declaration COMMA declarationlist
  ;

declaration: type ID
  ;

proc: returntype ID LB declarationlist RB LCB statementseq RCB
  | returntype ID LB RB LCB statementseq RCB
  ;

stmt: FOR LB ID ASGN expr SC expr SC stmt RB stmt
  | IF LB expr RB THEN stmt
  | IF LB expr RB THEN stmt ELSE stmt
  | PRINTF LB STR RB SC
  | RETURN expr SC
  | type ID SC
  | lexp ASGN expr SC
  | lexp LB exprlist RB SC
  | lexp ASGN lexp LB exprlist RB SC
  ;

statementseq: stmt
  | stmt statementseq
  ;

lexp: ID
  | ID DOT lexp
  ;
  
pgm: proc pgmp
  | struct pgm
  ;

pgmp: 
  | proc pgmp
  | struct pgmp
  ;

// EXPRESSIONS
expr: NUM
  | TRUE
  | FALSE
  | expr PLUS expr
  | expr MINUS expr
  | expr AND expr
  | expr MUL expr
  | expr DIV expr
  | expr MOD expr
  | expr OR expr
  | expr EQ expr
  | expr GT expr
  | expr LT expr
  | expr GTE expr
  | expr LTE expr
  | expr NE expr
  | MINUS expr
  %prec prec_unary
  | NEG expr
  | lexp
  | LB expr RB
  | STRLIT
  ;

exprlist: expr
  | expr COMMA exprlist
  ;




%%

int yyerror(const char *msg) {
	fprintf(stderr, "%s\n", msg);
  printf("ERROR\n");
  return 0;
}

int main(int argc, char *argv[])
{
    if(argc > 1) {
      yyin = fopen(argv[1], "r");
    }
    else {
      yyin = stdin;
    }
    int parse = yyparse();
    fclose(yyin);
    
    if(parse == 0) printf("VALID\n");
    return 0;
}