#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "semantics.h"

// actual types are: INT_TYPE, REAL_TYPE, CHAR_TYPE

int get_result_type(int type_1, int type_2, int op_type){ /* type check and result type */
	switch(op_type){
		case NONE: /* type compatibility only, '1': compatible */
			// first type INT
			if(type_1 == INT_TYPE){
				// second type INT
				if(type_2 == INT_TYPE ){
					return 1;
				}
				else{
					type_error(type_1, type_2, op_type);
				}
			}
			// first type STR
			else if(type_1 == STR_TYPE){
				// second type STR
				if(type_2 == STR_TYPE ){
					return 1;
				}
				else{
					type_error(type_1, type_2, op_type);
				}
			}
            // first type BOOL
            else if(type_1 == BOOL_TYPE) {
                // second type bool
                if(type_2 == BOOL_TYPE ){
					return 1;
				}
				else{
					type_error(type_1, type_2, op_type);
				}
            }
			break;
		/* ---------------------------------------------------------- */
		case ARITHM_OP: /* arithmetic operator */
			// first type INT
			if(type_1 == INT_TYPE){
				// second type INT
				if(type_2 == INT_TYPE ){
					return INT_TYPE;
				}
				else{
					type_error(type_1, type_2, op_type);
				}
			}
			else{
				type_error(type_1, type_2, op_type);
			}
			break;
		/* ---------------------------------------------------------- */
		case BOOL_OP: /* Boolean operator */
			// first type INT
			if(type_1 == BOOL_TYPE){
				// second type BOOL
				if(type_2 == BOOL_TYPE ){
					return BOOL_TYPE;
				}
				else{
					type_error(type_1, type_2, op_type);
				}
			}
			else{
				type_error(type_1, type_2, op_type);
			}
			break;
		/* ---------------------------------------------------------- */
		case NOT_OP: /* special case of NOTOP */
			// type INT
			if(type_1 == INT_TYPE){
				return BOOL_TYPE;
			}
            else if(type_1 == BOOL_TYPE) {
                return BOOL_TYPE;
            }
			else{
				type_error(type_1, type_2, op_type);
			}
			break;
		/* ---------------------------------------------------------- */
		case REL_OP: /* Relational operator */
			// first type INT
			if(type_1 == INT_TYPE){
				// second type INT
				if(type_2 == INT_TYPE ){
					return BOOL_TYPE;
				}
				else{
					type_error(type_1, type_2, op_type);
				}
			}
			// first type STR
			else if(type_1 == STR_TYPE){
				// second type STR
				if(type_2 == STR_TYPE ){
					return BOOL_TYPE;
				}
				else{
					type_error(type_1, type_2, op_type);
				}
			}
			else{
				type_error(type_1, type_2, op_type);
			}
			break;
		/* ---------------------------------------------------------- */
		case EQU_OP: /* Equality operator */
			// first type INT
			if(type_1 == INT_TYPE){
				// second type INT
				if(type_2 == INT_TYPE ){
					return BOOL_TYPE;
				}
				else{
					type_error(type_1, type_2, op_type);
				}
			}
			else if(type_1 == BOOL_TYPE){
				// second type BOOL
				if(type_2 == BOOL_TYPE){
					return BOOL_TYPE;
				}
				else{
					type_error(type_1, type_2, op_type);
				}
			}
			// first type STR
			else if(type_1 == STR_TYPE){
				// second type STR
				if(type_2 == STR_TYPE ){
					return BOOL_TYPE;
				}
				else{
					type_error(type_1, type_2, op_type);
				}
			}
			else{
				type_error(type_1, type_2, op_type);
			}
			break;
		/* ---------------------------------------------------------- */
		default: /* wrong choice case */
			fprintf(stderr, "Error in operator selection!\n");
			exit(1);
	}
}

void type_error(int type_1, int type_2, int op_type){ /* print type error */
	fprintf(stderr, "Type conflict between %d and %d using op type %d\n", type_1, type_2, op_type);
	exit(1);
}
