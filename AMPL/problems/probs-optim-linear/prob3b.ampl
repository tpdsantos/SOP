
param minBc >= 0 ;
param maxBc >= 0 ;

var stateB binary ;

s.t. min_bc : bc >= stateB * minBc ;
s.t. max_bc : bc <= stateB * maxBc ;

#####################################

data ;

param minBc := 5  ;
param maxBc := 10 ;