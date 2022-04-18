%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "symtab.c"
  #include "semantics.c"
  extern FILE *yyin;
  extern FILE *yyout;

  int yylex();
  int yyerror(const char *msg);

%}

%union {
  int data_type;
	struct list_t* symtab_item;
}


%token IF BOOL INT VOID PRINTF STR STRUCT FOR RETURN THEN ELSE
%token TRUE FALSE
%token EQ NE LT LTE GT GTE OR AND
%token LCB RCB SC LB RB DOT ASGN COMMA
%token NUM 
%token STRLIT
%token EOL
%token <symtab_item> ID

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

%type <data_type> type

%start pgm


%%

type: INT { $$ = INT_TYPE; }
  | BOOL { $$ = BOOL_TYPE; }
  | STR { $$ = STR_TYPE; }
  | ID { $$ = ID_TYPE; }
  ;


returntype: type
  | VOID
  ;

struct: STRUCT ID LCB declarationlist RCB
  ;

declarationlist:
  | declaration
  | declaration COMMA declarationlist
  ;

declaration: { declare = 1; } type ID { declare = 0; }
  ;

proc: { incr_scope(); } returntype ID LB declarationlist RB LCB statementseq RCB { hide_scope(); }
  ;

stmt: FOR LB ID ASGN expr SC boolexpr SC fortail RB LCB statementseq RCB
  | FOR LB ID ASGN expr SC boolexpr SC fortail RB stmt
  | IF LB boolexpr RB THEN LCB statementseq RCB
  | IF LB boolexpr RB THEN stmt
  | IF LB boolexpr RB THEN LCB statementseq RCB ELSE LCB statementseq RCB
  | IF LB boolexpr RB THEN LCB statementseq RCB ELSE stmt
  | IF LB boolexpr RB THEN stmt ELSE stmt
  | IF LB boolexpr RB THEN stmt ELSE LCB statementseq RCB
  | PRINTF LB STR RB SC
  | RETURN expr SC
  | type ID SC
  | lexp ASGN expr SC
  | lexp LB exprlist RB SC
  | lexp ASGN lexp LB exprlist RB SC
  ;

statementseq:
  | stmt statementseq
  ;

fortail: lexp ASGN expr SC ;

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
  | expr PLUS expr
  | expr MINUS expr
  | expr AND expr
  | expr MUL expr
  | expr DIV expr
  | expr MOD expr
  | MINUS expr
  %prec prec_unary
  | lexp
  | LB expr RB
  | STRLIT
  | boolexpr
  ;

boolexpr: expr OR expr
  | expr EQ expr
  | expr GT expr
  | expr LT expr
  | expr GTE expr
  | expr LTE expr
  | expr NE expr
  | NEG expr
  | TRUE
  | FALSE
  ;

exprlist: 
  | expr
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
    init_hash_table();

    queue = NULL;

    if(argc > 1) {
      yyin = fopen(argv[1], "r");
    }
    else {
      yyin = stdin;
    }
    int parse = yyparse();
    fclose(yyin);
    
    if(parse == 0) printf("\nVALID\n");
    return 0;
}