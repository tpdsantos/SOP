
set SEPS  = 1 .. 10                ; # set of separators = { 1, 2, ..., 10 }
set COMPS = { "A", "B", "C", "D" } ; # set of components

param F0             >= 0.0         ; # feed flow rate            (kmol/hr)
param x    { COMPS } >= 0.0, <= 1.0 ; # feed composition          (mole frac)
param alpha { SEPS } >= 0.0         ; # fixed    inv. cost coeff. ($/yr)
param beta  { SEPS } >= 0.0         ; # variable inv. cost coeff. ($.hr/kmol.yr)
param q     { SEPS } >= 0.0         ; # heat duty coeff.          (kJ/mol) 
param CC             >= 0.0         ; # cooling water             (10^3 $.hr/10^6 kJ.yr) 
param CH             >= 0.0         ; # steam                     (10^3 $.hr/10^6 kJ.yr)

var y { SEPS } binary ; # decision variables, one for each separator
var F { SEPS } >= 0.0 ; # inlet flow rates  , one for each separator (kmol/hr)

s.t. MAXF { k in SEPS } : F[k] <= F0 * y[k] ;

# material balances

s.t. F123 : F[1] + F[2] + F[3] = F0 ;

s.t. F45  : F[4] + F[5] = (1 - x["A"]) * F[1] ;

s.t. F67  : F[6] + F[7] = (1 - x["D"]) * F[3];

s.t. F8   : F[8]  = (x["C"] + x["D"]) * F[2] + (x["C"] + x["D"])/(1 - x["A"]) * F[4] ;

s.t. F9   : F[9]  = (x["B"] + x["C"])/(1 - x["A"]) * F[5] + (x["B"] + x["C"])/(1 - x["D"]) * F[6] ;

s.t. F10  : F[10] = (x["A"] + x["B"]) * F[2] + (x["A"] + x["B"])/(1 - x["D"]) * F[7] ;

minimize cost : sum { k in SEPS } ( alpha[k] * y[k] + (beta[k] + (CC + CH)*q[k]) * F[k] ) ;
