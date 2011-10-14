
expr [char op] returns [float value]
	: a= multExpr['m']{$value = $a.value;}
	( '+' e = expr['a'] {
		if ($op == 'a') {$value += $e.value;}
		else { $value -= $e.value;} }
	| '-' e = expr['s'] {
		if ($op == 'a') {$value -= $e.value;}
		else { $value += $e.value;} })?
	;

multExpr [char op] returns [float value]
	: a= powExpr{$value = $a.value;}
	( '*' e = multExpr['m'] {
		if ($op == 'm') {$value *=  $e.value;}
		else { $value /= $e.value;} }
	| '/' e = multExpr['d'] {
		if ($op == 'm') {$value /= $e.value;}
		else { $value *= $e.value;;} })?
	;
	
	
powExpr returns [float value]
    :   e=atom {$value = $e.value;} ('^' e=atom {$value = (float)Math.pow($value, $e.value);})*
        	; 

atom returns [float value]
    :   FLOAT {$value = Float.parseFloat($FLOAT.text);}
    |   ID
        {
        Float v = (Float)memory.get($ID.text);
        if ( v!=null ) $value = v.floatValue();
        else System.err.println("undefined variable "+$ID.text);
        }
    |   '(' expr['a']')' {$value = $expr.value;}
    ;

FLOAT :   '0'..'9'+ ('.' '0'..'9'+)?;
