grammar PyParser;
prog: statement+ EOF;

statement: assignment | if_block;

assignment: number_assignment | string_assignment | array_assignment | boolean_assignment ;

// integer assignments
number_assignment: VAR ARITH_OP? '=' number_operand (ARITH_OP number_operand)* NEWLINE?;
number_operand: INT | FLOAT | VAR ;

// string assignments
string_assignment: VAR ('=' | '+=') (STRING | VAR) NEWLINE?;

// array assignments
array_assignment: VAR '=' '[' ((STRING (',' STRING)*)? | (INT (',' INT)*)? | (FLOAT (',' FLOAT)*)?)? ']' NEWLINE?;

// boolean assignments
boolean_assignment: VAR '=' boolean_expression NEWLINE?;

// basic boolean logic
boolean_expression: BOOLEAN
                    | boolean_expression BOOL_OP boolean_expression
                    | 'not' boolean_expression ;

if_block: 'if' (VAR (COND_OP (VAR | number_operand | STRING))?) ':' NEWLINE
    INDENT assignment+ OUTDENT (elif_block | else_block)?;

elif_block: 'elif' (VAR (COND_OP (VAR | number_operand | STRING))?) ':' NEWLINE
    INDENT assignment+ OUTDENT (elif_block | else_block)?;

else_block: 'else' ':' NEWLINE
    INDENT assignment+ OUTDENT;

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

NEWLINE: '\r'? '\n';
INDENT: '\t';
OUTDENT: '\n' | EOF;

// Skip whitespace
WS : [ \r\n\f]+ -> skip ;
