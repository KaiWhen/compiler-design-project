/* token types */
#define UNDEF 0
#define INT_TYPE 1
#define STR_TYPE 2
#define BOOL_TYPE 3
#define ID_TYPE 4
#define FUNCTION_TYPE 5

/* operator types */
#define NONE 0		// to check types only - assignment, parameter
#define ARITHM_OP 1 // ADDOP, MULOP, DIVOP (+, -, *, /)
#define BOOL_OP 2   // OROP, ANDOP (||, &&)
#define NOT_OP 3    // NOTOP (!)
#define REL_OP 4    // RELOP (>, <, >=, <=)
#define EQU_OP 5    // EQUOP (==, !=)

// Function Declarations
int get_result_type (int type_1, int type_2, int op_type); /* type check and result type */
void type_error(int type_1, int type_2, int op_type);      /* print type error */