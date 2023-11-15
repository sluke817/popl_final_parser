grammar PyParser;
prog: statement+ EOF;

statement: assignment | if_block;

assignment: number_assignment | string_assignment | array_assignment | boolean_assignment ;

// integer assignments
number_assignment: VAR ARITH_OP? '=' number_operand (ARITH_OP number_operand)* NEWLINE?;
number_operand: INT | FLOAT | VAR ;

// string assignments
string_assignment: VAR ('=' | '+=') (STRING | VAR) NEWLINE?;

// TODO: warning(154): PyParser.g4:18:0: rule array_assignment contains an optional block with at least one alternative that can match an empty string
// array assignments
array_assignment: VAR '=' '[' ((STRING (',' STRING)*)? | (INT (',' INT)*)? | (FLOAT (',' FLOAT)*)?)? ']' NEWLINE?;

// boolean assignments
boolean_assignment: VAR '=' boolean_expression NEWLINE?;

// basic boolean logic
boolean_expression: BOOLEAN
                    | boolean_expression BOOL_OP boolean_expression
                    | 'not' boolean_expression ;

// TODO 
// fix line where there is just a tab (line 40 on deliverable testcase 2)
// when these issues are removed from deliverable testcase 2, it passes
if_block: 'if' complex_conditional ':' NEWLINE
    (INDENT statement)+ (elif_block | else_block)?;

elif_block: 'elif' complex_conditional ':' NEWLINE
    (INDENT statement)+ (elif_block | else_block)?;

else_block: 'else' ':' NEWLINE
    (INDENT statement)+;

// handles boolean expressions in conditional statements if/elif 
// It supports comparisons,and/or,not), and nested expressions with parentheses
complex_conditional:
      VAR (COND_OP comp_element)?
    | complex_conditional BOOL_OP complex_conditional
    | 'not' complex_conditional
    | '(' complex_conditional ')';
    
//added complex element for modularity 
comp_element: VAR | number_operand | STRING;

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
STRING: '\'' (CHAR | INT | ' ')* '\'' | '"' (CHAR | INT | ' ')* '"' ;
FLOAT : '-'? [0-9]+ '.' [0-9]+ ;
INT : '-'? [0-9]+ ;
CHAR : [a-z] | [A-Z] ;
BOOLEAN : 'True' | 'False' ;

NEWLINE: '\r'? '\n';
INDENT: '\t';

// Skip whitespace
WS : [ \r\n\f]+ -> skip ;
