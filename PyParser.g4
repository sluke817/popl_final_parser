grammar PyParser;
prog: statements EOF;

statements: (statement)+ ;

/* Statements like assignments and arithmetic can be written on the same line,
   or separated by newlines. These are the 'simple statements.'
*/
statement: block | (assignment (';' assignment)* ';'?)* NEWLINE ;

// block is just a placeholder for when we eventually add if, while, etc.
block: VAR ;

assignment: number_assignment | string_assignment | array_assignment | boolean_assignment ;

// integer assignments
number_assignment: VAR ASSIGN_OP ((INT | FLOAT) | arithmetic | VAR) ;

// string assignments
string_assignment: VAR ('=' | '+=') (STRING | concat | VAR) ;

// array assignments
array_assignment: VAR '=' ARRAY;

// boolean assignments
boolean_assignment: VAR '=' boolean_expression ;

// handling for doubles/floats and variables tbd
arithmetic: (INT | FLOAT) ARITH_OP (INT | FLOAT) ;

// concatenation of strings
concat: STRING ('+') STRING ;

// basic boolean logic
boolean_expression: BOOLEAN
                    | boolean_expression BOOL_OP boolean_expression
                    | NOT boolean_expression ;


// VAR cannot start with a number
VAR : ([a-z] | [A-Z])([a-z] | [A-Z] | [0-9])* ;


// basic arithmetic operators
ARITH_OP: '+' | '-' | '*' | '/' | '%' ;
//ASSIGN_OP: '=' | '+=' | '-=' | '*=' | '/=' ;
ASSIGN_OP : (ARITH_OP)? '=' ;

// boolean operators
AND: 'and' ;
OR: 'or' ;
NOT: 'not' ;
BOOL_OP: AND | OR ;

// ARRAY of single type
ARRAY: '[' ((STRING (',' STRING)*) | (INT (',' INT)*) | (FLOAT (',' FLOAT)*) | (BOOLEAN (',' BOOLEAN)*))* ']' ;

// STRING can have single or double quotes
STRING : '\'' (CHAR | INT)* '\'' 
        | '"' (CHAR | INT)* '"' ;

FLOAT : (INT)+ '.' (INT)+ ;
INT : [0-9]+ ;
CHAR : [a-z] | [A-Z] ;
BOOLEAN : TRUE | FALSE ;

// BOOLEAN can be True or False
TRUE: 'True';
FALSE: 'False';

// TODO: Need to somehow account for the indentation sensitivity in Python
// currently skips any space before or between characters
WS : [ \t\f]+ -> skip ;

NEWLINE : [\r\n] ;

