# Sets

set PRODS ;          # set of prods
set EQUIP_TYPES ;    # type of equipments
set MONTHS ordered ; # working months

# Parameters

# profit per product (EUR/unit, 1 unit = 25 L)
param prf { PRODS } >= 0.0 ;

# unit processing time per product and equipment type (h/unit)
param upt { PRODS, EQUIP_TYPES } >= 0.0 ; 

# number of units per equipment type (-)
param neq { EQUIP_TYPES } integer >= 0 ;

# number of inactive units per equipment type and month (-)
param nst { j in EQUIP_TYPES, MONTHS } integer >= 0, <= neq[j] ; 

# maximum amount of each product that can be sold per month (-) 
param mxs { PRODS, MONTHS } >= 0.0 ;

# number of working days per month (-)
param ndy { MONTHS } integer > 0 ;

param mxstock >= 0.0   ; # max stock
param minls   >= 0.0   ; # minimum stock at end
param maxls   >= minls ; # max stock at end
param cstock  >= 0.0   ; # stock cost

# unit processing time per product
param ut { i in PRODS, k in MONTHS } =
      sum { j in EQUIP_TYPES } ( if neq[j] > nst[j,k] then
                                    upt[i,j]/(neq[j] - nst[j,k])
                                 else
                                    1.E5 ) ;

# Decision variables and constraints

# amount of each product produced per month
var Prod { i in PRODS, k in MONTHS } >= 0.0 ;

# amount of each product sold per month
var Sell { i in PRODS, k in MONTHS } >= 0.0, <= mxs[i,k] ;

# amount of each product stocked per month
var Stock { i in PRODS, k in MONTHS } =
    sum { m in MONTHS : ord(m) <= ord(k) } (Prod[i,m] - Sell[i,m]) ;

s.t. FeasibleStock { i in PRODS, k in MONTHS } :
     0.0 <= Stock[i,k] <= mxstock ; 

s.t. LastStock { i in PRODS } :
     minls <= Stock[i,last(MONTHS)] <= maxls ; 

# number of processing days per month
var npd { k in MONTHS } = sum { i in PRODS } ut[i,k] * Prod[i,k] ;

s.t. MaxDays { k in MONTHS } : npd[k] <= (8+8) * ndy[k] ;

maximize profit :
   sum { i in PRODS, k in MONTHS } ( prf[i] * Sell[i,k] - cstock * Stock[i,k] ) ; 


######################################################################

data ;

set PRODS       := P1 P2 P3 P4 P5 P6 P7 ;
set EQUIP_TYPES := MIX DECANT REACT DRYER DISTIL ;
set MONTHS      := JAN FEB MAR APR MAY JUN ;

param mxstock := 100.0 ;
param minls   :=  50.0 ;
param maxls   :=  70.0 ;
param cstock  :=   0.6 ; 

param prf := 
P1     10
P2     60
P3     80
P4      4
P5     11
P6      9
P7      3 ;

param upt (tr) : P1   P2   P3   P4   P5   P6   P7 :=
MIX              0.5  0.7  0    0    0.3  0.2  0.5
DECANT           0.1  0.2  0    0.3  0    0.2  0.5
REACT            0.2  0    0.8  0    0    0    0.6
DRYER            0.5  0.3  0    0.7  1.0  0    0.8
DISTIL           0    0    1.2  0    1.5  0    0.9 ;

param neq :=
MIX     4
DECANT  2
REACT   3
DRYER   1
DISTIL  1 ;

param nst : JAN FEB MAR APR MAY JUN :=
MIX          1   0   0   0   1   0
DECANT       0   0   0   1   1   0
REACT        0   2   0   0   0   1
DRYER        0   0   1   0   0   0
DISTIL       0   0   0   0   0   1 ;

param mxs (tr) : P1    P2   P3   P4   P5   P6   P7 :=
JAN             500  1000  150  300  200  200   90
FEB             600   500  100    0  100  300  140
MAR             300   600    0    0  125  400   90
APR             200   300  200  500   50    0   90
MAY               0   100  250  100  250  300    0
JUN             500   500   50  300  260  500   50 ;

param ndy :=
JAN   26
FEB   25
MAR   27
APR   25
MAY   27
JUN   26 ;


######################################################################

option substout 1 ;
option show_stats 1 ;
option solver cplex ;
solve ;

display Stock ;
display Sell ;