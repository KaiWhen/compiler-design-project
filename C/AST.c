#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include "astheader.h"

struct object_list *var_list = NULL;


struct AST *create_ast(int node_type, struct AST *left, struct AST *right) {
	struct AST *a = malloc(sizeof(struct AST));
    if(a == NULL) {
        yyerror("Error allocating memory.\n");
        exit(EXIT_FAILURE);
    }
	a->node_type = node_type;
	a->left = left;
	a->right = right;
    return a;
}

struct AST *compare(int cmptype, struct AST *left, struct AST *right) {
	struct AST *n = malloc(sizeof(struct AST));
    if(n == NULL) {
        yyerror("Error allocating memory.\n");
        exit(EXIT_FAILURE);
    }
    n->node_type = '0' + cmptype;
    n->left = left;
    n->right = right;
    return n;
}
