grammar PyParser;
prog: statements EOF;

statements: (statement)+ ;

/* Statements like assignments and arithmetic can be written on the same line,
   or separated by newlines. These are the 'simple statements.'
*/
statement: block | (simple (';' simple)* ';'? NEWLINE) ;

// block is just a placeholder for when we eventually add if, while, etc.
block: VAR ;

simple: assignment | arithmetic ;

assignment: VAR asgn_operator (INT | STRING) ;

asgn_operator: '=' | '+=' | '-=' | '*=' | '/=' ;

// handling for doubles/floats and variables tbd
arithmetic: INT arith_operator INT ;

arith_operator: '+' | '-' | '*' | '/' | '%' ;


// VAR cannot start with a number
VAR : ([a-z] | [A-Z])([a-z] | [A-Z] | [0-9])* ;


// STRING can have single or double quotes
STRING : '\'' (CHAR | INT)* '\'' 
        | '"' (CHAR | INT)* '"' ;

CHAR : [a-z] | [A-Z];
INT : [0-9]+ ;

// TODO: Need to somehow account for the indentation sensitivity in Python
WS : [ \t\f]+ -> skip ;

NEWLINE : [\r\n] ;

