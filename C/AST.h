
extern int yylineno;
void yyerror(const char *s, ...);
extern int yylex();
extern unsigned int cursor;


struct AST {
    int node_type;
    struct AST *left, *right;
    double number;
};

struct AST *create_ast(int node_type, struct AST *left, struct AST *right);
struct AST *compare(int cmptype, struct AST *left, struct AST *right);