grammar Calculator;

INT : ('0'..'9')+ ;

BOOL    : 'true' | 'false' ;

NOT    : '!' ;
MINUS  : '-' ;
PLUS   : '+' ;
POW    : '^';
MULT   : '*' ;
DIV    : '/' ;
MOD    : '%' ;
EQC    : '==' ;
NEQ    : '!=';
LT     : '<' ;
GT     : '>';
LE     : '<=' ;
GE     : '>=' ;
AND    : '&&' ;
XOR    : '^^' ;
OR     : '||' ;
RPAREN : '(' ;
LPAREN : ')' ;

WS : ('\t' | '\r'? '\n' | ' ')+ -> channel(HIDDEN) ;


calculator : logic_expr | arithm_expr ;

logic_expr : NOT logic_expr #LogicNegativeExpr
           | lvalue=arithm_expr op=compare_op rvalue=arithm_expr #LogicalCompareExpr
           | lvalue=logic_expr op=logic_op rvalue=logic_expr #LogicalBinaryExpr
           | RPAREN logic_expr LPAREN #LogicalParensExpr
           | BOOL #LogicalAtomExpr;

arithm_expr : MINUS arithm_expr #ArithmeticNegativeExpr
            | value=arithm_expr op=exponent_op degree=arithm_expr #ArithmeticExponentExpr
            | lvalue=arithm_expr op=arithm_prior1 rvalue=arithm_expr #ArithmeticPrior1BinaryExpr
            | lvalue=arithm_expr op=arithm_prior2 rvalue=arithm_expr  #ArithmeticPrior2BinaryExpr
            | RPAREN arithm_expr LPAREN #ArithmeticParensExpr
            | INT #ArithmeticAtomExpr;

arithm_prior1 : MULT | DIV | MOD ;

arithm_prior2 : PLUS | MINUS ;

exponent_op : POW ;

compare_op : EQC | NEQ | LT | GT | LE | GE ;

logic_op : AND | OR | XOR;