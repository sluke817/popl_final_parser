grammar PyParser;
prog: statements EOF;

statements: (statement)+ ;

/* Statements like assignments and arithmetic can be written on the same line,
   or separated by newlines. These are the 'simple statements.'
*/
statement: block | (assignment (';' assignment)* ';'? NEWLINE) ;

// block is just a placeholder for when we eventually add if, while, etc.
block: VAR ;

assignment: number_assignment | string_assignment | array_assignment | boolean_assignment ;

// integer assignments
number_assignment: VAR ASSIGN_OP (NUMBER | arithmetic | VAR) ;

// string assignments
string_assignment: VAR ('=' | '+=') (STRING | concat | VAR) ;

// array assignments
array_assignment: VAR '=' '[' ((STRING (',' STRING)*)? | (INT (',' INT)*)? | (FLOAT (',' FLOAT)*)?)? ']' ;

// boolean assignments
boolean_assignment: VAR '=' boolean_expression ;

// handling for doubles/floats and variables tbd
arithmetic: NUMBER ARITH_OP NUMBER ;

// concatenation of strings
concat: STRING ('+') STRING ;

// basic boolean logic
boolean_expression: BOOLEAN
                    | boolean_expression BOOL_OP boolean_expression
                    | 'not' boolean_expression ;


// VAR cannot start with a number
VAR : ([a-z] | [A-Z])([a-z] | [A-Z] | [0-9])* ;

// basic arithmetic assignments and operators
ASSIGN_OP: (ARITH_OP)? '=' ;
ARITH_OP: '+' | '-' | '*' | '/' | '%' ;

// boolean operators
BOOL_OP: 'and' | 'or' ;

// *** basic data types ***
// strings can have single or double quotes 
// note: add periods, exclamation marks, all that?
STRING: '\'' (CHAR | INT)* '\'' | '"' (CHAR | INT)* '"' ;

// Covers for float and int
NUMBER: INT | FLOAT ;

FLOAT : [0-9]+ '.' [0-9]+ ;
INT : [0-9]+ ;
CHAR : [a-z] | [A-Z] ;
BOOLEAN : 'True' | 'False' ;

// TODO: Need to somehow account for the indentation sensitivity in Python
WS : [ \t\f]+ -> skip ;

NEWLINE : [\r\n] ;



