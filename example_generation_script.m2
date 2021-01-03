maxEdim = 2;
maxDegree = 2;
maxNumGens = 2;
k = ZZ/101;
myDirStem = "~/Documents/Research/StuffWithJosh/M2Code/Data/";
load "~/Documents/Research/StuffWithJosh/M2Code/example_generation.m2";
-- I decided to exclude the edim 1 case because it's all just k[x]/x^j, which is already well understood.
for i from 2 to maxEdim do (
	R = k[z_1 .. z_maxEdim];
	for j from 1 to maxDegree do
		for k from 1 to maxNumGens do (
			myFileName = toString(i) | "e" | toString(j) | "d" |
				 toString(k) | "g" | ".data";
			print(myFileName);
			-- e, d, etc are abbreviations for edim, degree, and numgens.
			myList = generateMonomialList(R,maxDegree);
			myList = generateGenLists (R,myList, maxNumGens);
			myDirStem | myFileName << toString(apply(myList, l -> (apply (l,g -> toString(g))))) << endl << close
				)
	)
