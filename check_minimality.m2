needsPackage "DGAlgebras"

isMinimalComplex = method(TypicalValue=>Boolean)

isMinimalComplex DGAlgebra := A -> (
	varList = flatten entries vars A.natural;
	for var in varList do (
		output = A.diff(var);
		(M,C) = coefficients(output);
		coefs = flatten entries C;
		noCounterExampleYet = true; 
		for coef in coefs when noCounterExampleYet do (
			degList = degree(coef);
			internalDeg = degList#1;
			if not internalDeg > 0 then noCounterExampleYet = false
			);
		if not noCounterExampleYet then break
		);
	
	return noCounterExampleYet
	)
