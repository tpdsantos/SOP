set SEPS  = 1 .. 10                ; # set of separators = { 1, 2, ..., 10 }
set COMPS = { "A", "B", "C", "D" } ; # set of components

param F0              >= 0.0         ; # feed flow rate            (kmol/hr)
param x     { COMPS } >= 0.0, <= 1.0 ; # feed composition          (mole frac)
param alpha { SEPS  } >= 0.0         ; # fixed    inv. cost coeff. ($/yr)
param beta  { SEPS  } >= 0.0         ; # variable inv. cost coeff. ($.hr/kmol.yr)
param q     { SEPS  } >= 0.0         ; # heat duty coeff.          (kJ/mol) 
param CC              >= 0.0         ; # cooling water             (10^3 $.hr/10^6 kJ.yr) 
param CH              >= 0.0         ; # steam                     (10^3 $.hr/10^6 kJ.yr)

var y { SEPS } binary ; # decision variables, one for each separator
var F { SEPS }        ; # inlet flow rate   , one for each separator (kmol/hr)

# constraints on the network superstructure

s.t. R0  : y[ 1] + y[2] + y[3] = 1 ;
s.t. R1  : y[ 1] = y[4] + y[5]     ;
s.t. R3  : y[ 3] = y[6] + y[7]     ;
s.t. R8  : y[ 8] = y[2] + y[4]     ;
s.t. R9  : y[ 9] = y[5] + y[6]     ;
s.t. R10 : y[10] = y[2] + y[7]     ;

# material balances

s.t. F123 { k in 1..3 } : F[k] = F0 * y[k] ;

s.t. F45  { k in 4..5 } : F[k] = F0 * y[k] * (1-x["A"]) ;

s.t. F67  { k in 6..7 } : F[k] = F0 * y[k] * (1-x["D"]) ;

s.t. F8  : F[ 8] = (x["C"] + x["D"]) * F[2] + (x["C"] + x["D"])/(1 - x["A"]) * F[4] ;

s.t. F9  : F[ 9] = (x["B"] + x["C"])/(1 - x["A"]) * F[5] + (x["B"] + x["C"])/(1 - x["D"]) * F[6] ;

s.t. F10 : F[10] = (x["A"] + x["B"]) * F[2] + (x["A"] + x["B"])/(1 - x["D"]) * F[7] ;

minimize cost : sum { k in SEPS } ( alpha[k] * y[k] + (beta[k] + (CC + CH)*q[k]) * F[k] ) ;
