grammar PyParser;
prog: statement+ EOF;

statement: assignment | if_block ;

assignment: number_assignment | string_assignment | array_assignment | boolean_assignment ;

// integer assignments
number_assignment: VAR ARITH_OP? '=' number_operand (ARITH_OP number_operand)*;
number_operand: INT | FLOAT | VAR ;

// string assignments
string_assignment: VAR ('=' | '+=') (STRING | concat | VAR) ;

// array assignments
array_assignment: VAR '=' '[' ((STRING (',' STRING)*)? | (INT (',' INT)*)? | (FLOAT (',' FLOAT)*)?)? ']' ;

// boolean assignments
boolean_assignment: VAR '=' boolean_expression ;

// concatenation of strings
concat: STRING ('+') STRING ;

// basic boolean logic
boolean_expression: BOOLEAN
                    | boolean_expression BOOL_OP boolean_expression
                    | 'not' boolean_expression ;

if_block: 'if' (VAR (COND_OP (VAR | number_operand | STRING))?) 
            | ((VAR COND_OP)? boolean_expression) ':' 
            ('\n' '\t' assignment)+ //Deals with the indentations
            (elif_block | else_block)? ;

elif_block: 'elif' (VAR (COND_OP (VAR | number_operand | STRING))?) 
            | ((VAR COND_OP)? boolean_expression) ':' 
            ('\n' '\t' assignment)+ //Deals with the indentations
            (elif_block | else_block)? ;

else_block: 'else' ':' ('\n' '\t' assignment)+ ;

// VAR cannot start with a number
VAR : ([a-z] | [A-Z])([a-z] | [A-Z] | [0-9] | '_')* ;

// basic arithmetic operators
ARITH_OP: '+' | '-' | '*' | '/' | '%' ;

// boolean operators
BOOL_OP: 'and' | 'or' ;

// conditional operators
COND_OP: '<' | '<=' | '>' | '>=' | '==' | '!=' ;

// *** basic data types ***
// strings can have single or double quotes
STRING: '\'' (CHAR | INT)* '\'' | '"' (CHAR | INT)* '"' ;
FLOAT : [0-9]+ '.' [0-9]+ ;
INT : [0-9]+ ;
CHAR : [a-z] | [A-Z] ;
BOOLEAN : 'True' | 'False' ;

// TODO: Need to somehow account for the indentation sensitivity in Python
WS : [ \r\n\t\f]+ -> skip ;
