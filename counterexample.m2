R=QQ[x,y,z,w]/ideal(x^2,x*y,y*z,z*w,w^2)
f=random(1,R)
n=5---how many variables -1 we've adjoined
K=koszulComplexDGA({f})
A=acyclicClosure(K,EndDegree=>n)----still minimal!
B = (R/(ideal vars R))[gens A.natural]-- record the map from A to B that mods things out
phi = map(B,A.natural,gens B)-- apply the map to the entries of "matrix A.diff" which has the values of the differential of the variables in the DGA
matrix {apply(flatten entries matrix A.diff, f -> phi f)}
