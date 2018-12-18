
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
var F { SEPS }        ; # inlet flow rate   , one for each separator (kmol/hr)

# constraints on the network superstructure

s.t. R0  : y[ 1] + y[2] + y[3] = 1 ;
s.t. R1  : y[ 1] = y[4] + y[5]     ;
s.t. R3  : y[ 3] = y[6] + y[7]     ;
s.t. R8  : y[ 8] = y[2] + y[4]     ;
s.t. R9  : y[ 9] = y[5] + y[6]     ;
s.t. R10 : y[10] = y[2] + y[7]     ;

# material balances

s.t. F123 { k in 1..3 } : F[ k] = F0 * y[ k] ;

s.t. F45  { k in 4..5 } : F[ k] = F0 * y[ k] * (   1   - x["A"]) ;

s.t. F67  { k in 6..7 } : F[ k] = F0 * y[ k] * (   1   - x["D"]) ;

s.t. F8                 : F[ 8] = F0 * y[ 8] * (x["C"] + x["D"]) ;

s.t. F9                 : F[ 9] = F0 * y[ 9] * (x["B"] + x["C"]) ;

s.t. F10                : F[10] = F0 * y[10] * (x["A"] + x["B"]) ;

var costs {k in SEPS} = alpha[k] * y[k] + (beta[k] + (CC + CH)*q[k]) * F[k] ;

minimize investment : sum {k in SEPS} ( costs[k] ) ;

#############################3

data ;

param F0 := 1000.0 ;
param CC :=    1.3 ;
param CH :=   34.0 ;
param x  :=
  A  0.15
  B  0.30
  C  0.35
  D  0.20 ;
param : alpha,  beta,    q :=
  1     145.0   0.42   0.028
  2      52.0   0.12   0.042
  3      76.0   0.25   0.054
  4      25.0   0.78   0.024
  5      44.0   0.11   0.039
  6      38.0   0.14   0.040
  7      66.0   0.21   0.047
  8     112.0   0.39   0.022
  9      37.0   0.08   0.036
 10      58.0   0.19   0.044 ;

###############################

option substout 1 ;
option show_stats 1 ;
option solver cplex ;

solve ;

display investment ;
display y, F ;