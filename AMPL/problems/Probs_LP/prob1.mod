
set CRUDES ;
set PRODS  ;

param REND      { CRUDES , PRODS } >= 0 ;
param COST      { CRUDES         } >= 0 ;
param PROD_COST { CRUDES         } >= 0 ;
param SALES     {          PRODS } >= 0 ;
param MAX_PROD  {          PRODS } >= 0 ;

var crude{CRUDES} >= 0 ;
var prod{PRODS} >= 0 ;

s.t. prod_calc {p in PRODS} : prod[p] = sum{c in CRUDES} (crude[c]*REND[c,p]/100) ;

s.t. max_prod {p in PRODS} : prod[p] <= MAX_PROD[p] ;

var total_cost = sum {c in CRUDES} (crude[c]*(COST[c]+PROD_COST[c])) ;

var sales = sum {p in PRODS} prod[p]*SALES[p] ;

maximize profit : sales - total_cost ;

################################

data ;

set CRUDES := C1 C2 ;
set PRODS  := Gas Que Fuel Res ;

param COST := C1 24 C2 15 ;
param PROD_COST := C1 0.5 C2 1.0 ;

param SALES := Gas 36 Que 24 Fuel 21 Res 10 ;
param MAX_PROD := Gas 24000 Que 2000 Fuel 6000 Res Infinity ;

param REND: Gas Que Fuel Res :=
	C1  80   5   10   5
        C2  44  10   36  10 ;

################################

option solver "/home/tsantos/SOFTWARES/AMPL-lang/cplex" ;
solve;
display profit ;
display {c in CRUDES} crude[c] ;
display {p in PRODS} prod[p] ;