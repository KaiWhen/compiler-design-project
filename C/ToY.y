%define parse.error verbose

%{
#include <stdio.h>

int yylex();
int yyerror(const char *msg);

%}

%token IF THEN ELSE BOOL INT TRUE FALSE VOID PRINTF STR STRUCT FOR RETURN
%token LT LTE GT GTE EQ NE LCB RCB SC NEG LB RB PLUS MINUS DOT ASGN MOD AND OR NOT
%token ID NUM STRLIT
%token EOL

%%

type: INT
  | BOOL
  | STR
  | ID
  ;

string: STRLIT
  ;

returntype: type
  | VOID
  ;

struct: STRUCT ID LCB declaration ',' declaration RCB
  ;

declaration: type ID
  ;

proc: returntype ID LB declaration RB LCB stmt RCB
  ;

stmt: FOR LB ID ASGN expr ';' expr ';' stmt RB stmt
  | IF LB expr RB THEN stmt
  | IF LB expr RB THEN stmt ELSE stmt
  | PRINTF LB string RB ';'
  | RETURN expr ';'
  | LCB statementseq RCB
  | type ID ';'
  | lexp ASGN expr ';'
  | ID LB expr RB ';'
  | ID ASGN ID LB expr RB ';'
  ;

statementseq:
  | stmt statementseq
  ;

lexp: ID 
  | ID DOT lexp
  ;

expr: TRUE
  ;
  


%%

int yyerror(const char *msg) {
	fprintf(stderr, "%s\n", msg);
  printf("ERROR");
  return 0;
}

int main()
{
    int parse = yyparse();
    if(parse == 0) printf("VALID\n");
    return 0;
}
