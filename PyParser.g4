// ** TO DO ***
// Type checking???
// Array handling -> same type throughout
// Booleans

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
number_assignment: VAR asgn_operator (NUMBER | arithmetic | VAR) ;

// string assignments
string_assignment: VAR ('=' | '+=') (STRING | concat | VAR) ;

// array assignments
array_assignment: VAR '=' ARRAY;

// boolean assignments
boolean_assignment: VAR '=' boolean_expression ;

asgn_operator: '=' | '+=' | '-=' | '*=' | '/=' ;

// handling for doubles/floats and variables tbd
arithmetic: NUMBER arith_operator NUMBER ;

// concatonation of strings
concat: STRING ('+') STRING ;

// basic arithmetic operators
arith_operator: '+' | '-' | '*' | '/' | '%' ;

// boolean operators
AND: 'and' ;
OR: 'or' ;
NOT: 'not' ;
boolean_operator: AND | OR ;

// basic boolean logic
boolean_expression: BOOLEAN
                    | boolean_expression boolean_operator boolean_expression
                    | NOT boolean_expression ;


// VAR cannot start with a number
VAR : ([a-z] | [A-Z])([a-z] | [A-Z] | [0-9])* ;

// ARRAY of single type
ARRAY: '[' (((STRING ',')+ STRING) | STRING) ']'
        | '[' (((INT ',')+ INT) | INT) ']' 
        | '[' (((FLOAT ',')+ FLOAT) | FLOAT) ']'
        | '[' ']' ;

// STRING can have single or double quotes
STRING : '\'' (CHAR | INT)* '\'' 
        | '"' (CHAR | INT)* '"' ;

CHAR : [a-z] | [A-Z] ;
NUMBER : INT | FLOAT ;
FLOAT : (INT)* '.' (INT)+ ;
INT : [0-9]+ ;
BOOLEAN : TRUE | FALSE ;

// BOOLEAN can be True or False
TRUE: 'True';
FALSE: 'False';

// TODO: Need to somehow account for the indentation sensitivity in Python
WS : [ \t\f]+ -> skip ;

NEWLINE : [\r\n] ;

