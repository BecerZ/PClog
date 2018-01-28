
/* pclog.y */
%{
#include <stdio.h>
%}
%union {
  int integer;
  char str[128];
}
%token IF ELSE FOR WHILE DO RETURN INTEGER_VAR BOOLEAN_VAR TRUE FALSE INPUT OUTPUT CONST IDENTIFIER COMMA SEMICOLON LBRACE RBRACE LP RP ADDITION_OPERATOR SUBTRACTION_OPERATOR MULTIPLICATION_OPERATOR DIVISION_OPERATOR LOGICAL_IMPLIES_OPERATOR ASSIGNMENT_OPERATOR EQUALITY_OPERATOR NOT_EQUALITY_OPERATOR LESS_THAN_OPERATOR GREATER_THAN_OPERATOR LESS_THAN_OR_EQUAL_OPERATOR GREATER_THAN_OR_EQUAL_OPERATOR LOGICAL_OR_OPERATOR LOGICAL_AND_OPERATOR NOT_OPERATOR NEW_LINE PREDICATE
ARGUMENT COLON FUNCTION LBRACKET RBRACKET 
%token <integer> INTEGER_VAL
%%
start : statements { printf( " is in language\n"); return 0;}
;

statements : statement
         | statements statement
	
;
statement :  statement_para
          |  if_statement 
          | non_if_statement
  	  | NEW_LINE              
;
statement_para : LP statement RP
;
non_if_statement : //proposition
//                 | complex_statement
                  function_call
                 | for_loop
                 | while_loop
                 | logical_assignment
		 | logical_expr
                 | function
                 | predicate
                 | declaration
                 | arithmetic_assignment
                 | predicate_call
                 | input_statement
                 | output_statement
		 | array_modification
		

;                  
// If Else

if_statement : matched_if
             | unmatched_if
;             
matched_if : IF LP logical_expr RP LBRACE statements RBRACE  ELSE  LBRACE statements RBRACE
	     | IF LP boolean_expr RP LBRACE statements RBRACE  ELSE  LBRACE statements RBRACE 
	     
;           
unmatched_if : IF LP logical_expr RP LBRACE statements RBRACE
	     | IF LP boolean_expr RP LBRACE statements RBRACE
; 

/*
if_statement: IF LP logical_expr RP LBRACE statements RBRACE
	    | IF LP logical_expr RP LBRACE statements RBRACE ELSE LBRACE statements RBRACE
; 
*/   
predicate : predicate_name LP arg_list RP LBRACE statements RBRACE
;
arg_list : ARGUMENT COLON IDENTIFIER
          | arg_list COMMA ARGUMENT COLON IDENTIFIER 
;
term_list :  IDENTIFIER
          | term_list COMMA IDENTIFIER 
;
predicate_name : PREDICATE IDENTIFIER 
;               
function : function_name LP arg_list RP brace_location 
;
function_name : FUNCTION INTEGER_VAR IDENTIFIER
	      | FUNCTION BOOLEAN_VAR IDENTIFIER
;
//;
//alphabetic : IDENTIFIER;           
function_call : IDENTIFIER LP term_list RP
;
predicate_call : predicate_name LP term_list RP
;
brace_location: LBRACE statements RETURN IDENTIFIER RBRACE
	      | NEW_LINE LBRACE statements RETURN IDENTIFIER NEW_LINE RBRACE
	      | LBRACE statements RETURN IDENTIFIER NEW_LINE RBRACE
;
// Arithmetic
arithmetic_assignment : IDENTIFIER assignment_operator arithmetic_expr
;
arithmetic_expr : IDENTIFIER arithmetic_operator LP arithmetic_expr RP
           	| IDENTIFIER arithmetic_operator INTEGER_VAL
		| IDENTIFIER arithmetic_operator IDENTIFIER
		| INTEGER_VAL
;                
// Logical
logical_assignment : IDENTIFIER assignment_operator logical_expr
		   | IDENTIFIER assignment_operator boolean_expr 
;
logical_operation : IDENTIFIER logical_operator logical_expr
;
// Loops           

while_loop : WHILE LP logical_expr RP NEW_LINE LBRACE statements RBRACE NEW_LINE
	   | WHILE LP boolean_expr RP NEW_LINE LBRACE statements RBRACE NEW_LINE
;              
for_loop : FOR LP logical_assignment SEMICOLON logical_operation SEMICOLON logical_assignment RP LBRACE statements RBRACE
;        
// IO
input_statement : INPUT LP IDENTIFIER COMMA IDENTIFIER RP
;
output_statement : OUTPUT LP IDENTIFIER RP
;
        
// Operators
assignment_operator : ASSIGNMENT_OPERATOR
;
arithmetic_operator : SUBTRACTION_OPERATOR
                    | ADDITION_OPERATOR
                    | MULTIPLICATION_OPERATOR
                    | DIVISION_OPERATOR
;
logical_operator : LOGICAL_IMPLIES_OPERATOR
                 | LOGICAL_OR_OPERATOR
                 | LOGICAL_AND_OPERATOR
                 | LESS_THAN_OPERATOR
                 | LESS_THAN_OR_EQUAL_OPERATOR
                 | GREATER_THAN_OPERATOR
                 | EQUALITY_OPERATOR
                 | GREATER_THAN_OR_EQUAL_OPERATOR
		 | NOT_EQUALITY_OPERATOR
;                 
// Other Declarations
boolean_expr : TRUE
             | FALSE
;            

declaration : variable_declaration
            | int_array_declaration
            | boolean_array_declaration
;
variable_declaration : int_declaration
                     | CONST int_declaration
                     | boolean_declaration
                     | CONST boolean_declaration
		   
;
int_declaration : INTEGER_VAR IDENTIFIER assignment_operator INTEGER_VAL
		| INTEGER_VAR IDENTIFIER
;
boolean_declaration : BOOLEAN_VAR logical_assignment
		    | BOOLEAN_VAR IDENTIFIER
;
int_array_declaration : INTEGER_VAR IDENTIFIER LBRACKET INTEGER_VAL RBRACKET
;
boolean_array_declaration : BOOLEAN_VAR IDENTIFIER LBRACKET INTEGER_VAL RBRACKET
;
array_modification: int_array_modification | boolean_array_modification
;
int_array_modification: IDENTIFIER LBRACKET INTEGER_VAL RBRACKET assignment_operator INTEGER_VAL
;
boolean_array_modification: IDENTIFIER LBRACKET INTEGER_VAL RBRACKET assignment_operator boolean_expr
;

//const_declaration : CONST var IDENTIFIER assignment_operator statements
//var : INTEGER_VAR
//    | BOOLEAN_VAR
//;    
logical_expr : IDENTIFIER logical_operator IDENTIFIER
	       | IDENTIFIER logical_operator LP logical_expr RP
               | NOT_OPERATOR IDENTIFIER
               | NOT_OPERATOR logical_expr
	       | IDENTIFIER logical_operator INTEGER_VAL
	       | IDENTIFIER logical_operator boolean_expr
	      // | boolean_expr 
;            


//IDENTIFIER : IDENTIFIER
;

%%
#include "lex.yy.c"   /**/
int lineno;
main() {
  return yyparse();
}
int yyerror( char *s ) { fprintf( stderr, "Syntax error @ line:%d \n", lineno + 1); }
