
set REAG ;
set PROD ;
set REAG_PROD := REAG union PROD ;

param FRAC_CONS { PROD , REAG             } >= 0 ;
param REAG_COST {        REAG             } >= 0 ;
param AVAIL     {        REAG             } >= 0 ;
param OP_COST   { PROD ,        REAG_PROD } >= 0 ;
param PROFIT    { PROD                    } >= 0 ;

##########################

var flows { REAG_PROD } >= 0.0 ;

s.t. reag_flow {r in REAG} : flows[r] = sum {p in PROD} ( FRAC_CONS[p,r]*flows[p] ) ;

s.t. max_availability {r in REAG} : flows[r] <= AVAIL[r] ;

var op_cost = sum {p in PROD, rp in REAG_PROD} ( OP_COST[p,rp]/100*flows[rp] ) ;

var raw_cost = sum {r in REAG} ( flows[r]*REAG_COST[r]/100 ) ;

var sales = sum {p in PROD} ( flows[p]*PROFIT[p]/100 ) ;

maximize profit : sales - raw_cost - op_cost ;

#########################

data ;

set REAG := A B C ;
set PROD := E F G ;

param FRAC_CONS:   A      B      C   :=
	     E   0.667  0.333    0
             F   0.667  0.333    0
             G   0.500  0.167  0.333 ;

param REAG_COST := A 1.5 B 2.0 C 2.5 ;

param AVAIL := A 4000 B 3000 C 2500 ;

param OP_COST:  A    B   C   E   F   G  :=
           E   1.0   0   0   0   0   0
           F   0.5   0   0   0   0   0
           G    0    0   0   0   0  1.0 ;

param PROFIT := E 4.0 F 3.3 G 3.8 ;


#########################

option solver "/home/tsantos/SOFTWARES/AMPL-lang/cplex" ;
solve;

display profit ;
display {rp in REAG_PROD} flows[rp] ;