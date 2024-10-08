//source: https://github.com/drifter1/compiler

typedef enum Node_Type {
	BASIC_NODE,   // no special usage (for roots only)
	// declarations
	DECLARATIONS, // declarationlist
	DECL_NODE,    // declaration
	// statements
	STATEMENTS,   // statementseq
	IF_NODE,      // if statement
	ELSIF_NODE,   // else if branch
	FOR_NODE,     // for statement
    STRUCT_NODE,  // struct
	ASSIGN_NODE,  // assigment
	CALL_PARAMS,  // function call parameters
	FUNC_CALL,
	// expressions
	ARITHM_NODE,  // arithmetic expression
	BOOL_NODE,    // boolean expression
	EQU_NODE,     // equality expression
	REL_NODE,
    EXPRESSIONS,  // expr list
	// functions
	FUNC_DECLS,   // function declarations
	FUNC_DECL,    // function declaration
	RET_TYPE,     // function return type
	DECL_PARAMS,  // function parameters
	RETURN_NODE,  // return statement of functions
} Node_Type;

/* --------------------OPERATOR TYPES----------------------- */

typedef enum Arithm_op{
	ADD,  // + operator
	SUB,  // - operator
	MUL,  // * operator
	DIV , // / operator
	INC, // ++ operator
	DEC, // -- operator
}Arithm_op;

typedef enum Bool_op{
	OR,  // || operator
	AND, // && operator
	NOT  // ! operator
}Bool_op;

typedef enum Rel_op{
	GREATER,        // > operator
	LESS,           // < operator
	GREATER_EQUAL,  // >= operator
	LESS_EQUAL     // <= operator
}Rel_op;

typedef enum Equ_op{
	EQUAL,    // == operator
	NOT_EQUAL // != operator
}Equ_op;

/* -----------------------AST NODES------------------------- */

/* The basic node */
typedef struct AST_Node{
	enum Node_Type type; // node type
	struct AST_Node *left;  // left child
	struct AST_Node *right; // right child
}AST_Node;

/* Declarations */
typedef struct AST_Node_Decl{
	enum Node_Type type; // node type
	
	// data type
	int data_type;
	
	// symbol table entries of the variables
	list_t **names;
	int names_count;
}AST_Node_Decl;

/* Statements */
typedef struct AST_Node_If{
	enum Node_Type type; // node type
	
	// condition
	struct AST_Node *condition;
	
	// if branch
	struct AST_Node *if_branch;
	
	// else if branches
	struct AST_Node **elsif_branches;
	int elseif_count;
	
	// else branch
	struct AST_Node *else_branch;
}AST_Node_If;

typedef struct AST_Node_Elsif{
	enum Node_Type type; // node type
	
	// condition
	struct AST_Node *condition;
	
	// branch
	struct AST_Node *elsif_branch;
}AST_Node_Elsif;

typedef struct AST_Node_For{
	enum Node_Type type; // node type
	
	// initialization
	struct AST_Node *initialize;
	
	// condition
	struct AST_Node *condition;
	
	// incrementation
	struct AST_Node *increment;
	
	// branch
	struct AST_Node *for_branch;
}AST_Node_For;

typedef struct AST_Node_Assign{
	enum Node_Type type; // node type
	
	// symbol table entry
	list_t *entry;
	
	// assignment value
	struct AST_Node *assign_val;
}AST_Node_Assign;

typedef struct AST_Node_Simple{
	enum Node_Type type; // node type
	
	// continue, break or "main" return
	int statement_type;
}AST_Node_Simple;

typedef struct AST_Node_Func_Call{
	enum Node_Type type; // node type
	
	// function identifier
	list_t *entry;
	
	// call parameters
	AST_Node **params;
	int num_of_pars;
}AST_Node_Func_Call;

/* Expressions */
typedef struct AST_Node_Arithm{
	enum Node_Type type; // node type
	
	// operator
	enum Arithm_op op;
	
	struct AST_Node *left;  // left child
	struct AST_Node *right; // right child
}AST_Node_Arithm;

typedef struct AST_Node_Bool{
	enum Node_Type type; // node type
	
	// operator
	enum Bool_op op;
	
	struct AST_Node *left;  // left child
	struct AST_Node *right; // right child
}AST_Node_Bool;

typedef struct AST_Node_Rel{
	enum Node_Type type; // node type
	
	// operator
	enum Rel_op op;
	
	struct AST_Node *left;  // left child
	struct AST_Node *right; // right child
}AST_Node_Rel;

typedef struct AST_Node_Equ{
	enum Node_Type type; // node type
	
	// operator
	enum Equ_op op;
	
	struct AST_Node *left;  // left child
	struct AST_Node *right; // right child
}AST_Node_Equ;

/* Functions */
typedef struct AST_Node_Func_Decl{
	enum Node_Type type; // node type
	
	// return type
	int ret_type;
	
	// symbol table entry
	list_t *entry;
}AST_Node_Func_Decl;

typedef struct AST_Node_Return{
	enum Node_Type type; // node type
	
	// return type
	int ret_type;
	
	// return value
	struct AST_Node *ret_val;
}AST_Node_Return;

/* ------------------AST NODE MANAGEMENT-------------------- */

/* The basic node */
AST_Node *new_ast_node(Node_Type type, AST_Node *left, AST_Node *right); 	 // simple nodes

/* Declarations */
AST_Node *new_ast_decl_node(int data_type, list_t **names, int names_count); // declaration
AST_Node *new_ast_const_node(int const_type, Value val);					 // constant

/* Statements */
AST_Node *new_ast_if_node(AST_Node *condition, AST_Node *if_branch, AST_Node **elsif_branches, 
	int elseif_count, AST_Node *else_branch);
AST_Node *new_ast_elsif_node(AST_Node *condition, AST_Node *elsif_branch);
AST_Node *new_ast_for_node(AST_Node *initialize, AST_Node *condition, AST_Node *increment, AST_Node *for_branch);
AST_Node *new_ast_while_node(AST_Node *condition, AST_Node *while_branch);
AST_Node *new_ast_assign_node(list_t *entry, AST_Node *assign_val);
AST_Node *new_ast_simple_node(int statement_type);							 // continue, break or "main" return
AST_Node *new_ast_incr_node(list_t *entry, int incr_type, int pf_type);      // increment decrement
AST_Node *new_ast_func_call_node(list_t *entry, AST_Node **params, int num_of_pars); // function call

/* Expressions */
AST_Node *new_ast_arithm_node(enum Arithm_op op, AST_Node *left, AST_Node *right);
AST_Node *new_ast_bool_node(enum Bool_op op, AST_Node *left, AST_Node *right);
AST_Node *new_ast_rel_node(enum Rel_op op, AST_Node *left, AST_Node *right);
AST_Node *new_ast_equ_node(enum Equ_op op, AST_Node *left, AST_Node *right);

/* Functions */
AST_Node *new_ast_func_decl_node(int ret_type, list_t *entry);				 // function declaration
AST_Node *new_ast_return_node(int ret_type, AST_Node *ret_val);				 // function return

/* Tree Traversal */
void ast_print_node(AST_Node *node);	// print information of node
void ast_traversal(AST_Node *node);		// tree traversal (for testing right now)