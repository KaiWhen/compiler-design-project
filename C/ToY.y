%define parse.error verbose

%{
#include <stdio.h>

int yylex();
int yyerror(const char *msg);

%}

%token KEYWORD OP ID INT STRING COMMENT EOL

%%

exp:
  KEYWORD OP
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
