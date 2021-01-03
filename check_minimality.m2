needsPackage "DGAlgebras"

isMinimalComplex = method()

isMinimalComplex DGAlgebra := A -> (
	varList = flatten entries vars A.natural;
	myVar = true;
	for var in varList do (
		output = A.diff(var);
		(M,C) = coefficients(output);
		coefs = flatten entries C;
		noCounterExampleYet = true; 
		for coef in coefs when noCounterExampleYet do (
			degList = degree(coef);
			internalDeg = degList#1;
			if not internalDeg > 0 then (
				noCounterExampleYet = false;
				myVar = {var,A.diff(var)}
				)
			);
		if not noCounterExampleYet then break
		);
	return myVar
	)

checkClosed = method(Options => {EndDegree => 3})
checkClosed DGAlgebra := opts -> A -> (B = acyclicClosure(A,EndDegree=>opts.EndDegree);
	isMinimalComplex B)

checkClosed Ideal := opts -> I -> (K = koszulComplexDGA(I);
	checkClosed(K,EndDegree=>opts.EndDegree))

