maxEdim = 3
maxDeg = 2
maxNumGens = 3
k = ZZ/101
R = k[z_1 .. z_maxEdim]


-* Including 1 in the list creates lots of extra duplications, but is neccessary to get all ideals
(at least, based on my testing).
There may be a better way to generate these so that there's less unecessary duplication.
Something...triangular???
*-

--maybe I should try dropping linear forms...they should end up in indices 0, myDegree+1, 2myDegree+1,...

recursiveMonomialList = (myList, myMonomial, myDegree) -> (
	if #(myList)==0 then outputList = (for i from 0 to myDegree list myMonomial^i) else
	outputList = for i from 0 to myDegree list (
		for entry in myList list entry*myMonomial^i
		);
	flatten outputList)
generateMonomialList = {dropLinearForms => true} >> opts -> (myRing,myDegree) -> (myVariables = flatten entries vars R;
	myMonomialList = {};
	for var in myVariables do myMonomialList = recursiveMonomialList (myMonomialList,var,myDegree);
	myMonomialList = drop(myMonomialList, {0,0}); -- Drops the superflous "{1}"
	if opts.dropLinearForms then 
		myMonomialList = select(myMonomialList, g -> not ((degree(g))#0 == 1));
	return myMonomialList)

generateGenLists = (myRing, myList, myNumGens) -> (perms = permutations flatten entries vars myRing;
	myMaps = for perm in perms list map(myRing,myRing, matrix{perm});
	-- This quickly suffers from a combinatorial explosion.  Breaking this into pieces somehow might help
	myList = unique apply(subsets(myList,myNumGens),L -> flatten entries gens trim ideal L);
	trimedGenSets = {};
	duplicateGenSets = {};
	for genSet in myList do (
		if member(set genSet,duplicateGenSets) then continue
		else (
			trimedGenSets = append(trimedGenSets, genSet);
			duplicateGenSets = duplicateGenSets | for f in myMaps list set (for gen in genSet list f(gen))
			);
		);

	return trimedGenSets
	)


