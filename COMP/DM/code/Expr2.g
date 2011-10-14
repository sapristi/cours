
expr returns [int value]
    :   e=multExpr {$value = $e.value;}
        (   '+' e=multExpr {$value += $e.value;}
        |   '-' e=multExpr {$value -= $e.value;}
        )*
    ;
    
 multExpr returns [int value]
    :   e=powExpr {$value = $e.value;}
        (   '*' e=powExpr {$value *= $e.value;}
        |   '/' e=powExpr {$value /= $e.value;}
        )*
    ;
    
powExpr returns [int value]
    :   e=atom {$value = $e.value;} ('^' e=atom {$value = (int)Math.pow($value, $e.value);})*
    ; 
