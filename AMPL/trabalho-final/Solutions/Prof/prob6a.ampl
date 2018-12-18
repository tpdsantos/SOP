# Sets

set PRODS ;       # set of prods
set EQUIP_TYPES ; # type of equipments
set MONTHS ;      # working months

# Parameters

# profit per product (EUR per unit of product, 1 unit = 25 L)
param prf { PRODS } >= 0.0 ;

# unit processing time per product and per equipment type (h per type of unit)
# unit processing time per product must be greater than zero
param upt { PRODS, EQUIP_TYPES } >= 0.0 ;
check { i in PRODS } : sum { j in EQUIP_TYPES } upt[i,j] > 0.0 ;

# number of units per equipment type (-)
param neq { EQUIP_TYPES } integer >= 0 ;

# number of inactive units per equipment type and month (-)
param nst { j in EQUIP_TYPES, MONTHS } integer >= 0, <= neq[j] ; 

# maximum amount of each product that can be sold per month (-) 
param mxp { PRODS, MONTHS } >= 0.0 ;

# number of working days per month (-)
param nwd { MONTHS } integer > 0 ;

# Derived parameters

# unit processing time per product and month (h per unit of product)
# for prod i, equipment type j, and month k:
# if upt[i,j] = 0 then
#    prod i does not require equipment type j, thus
#    add 0.0 to the unit processing time for prod i in month k 
# else
#    if neq[j] > nst[j,k] then
#       number of available equipment units of type j = neq[j] - nst[j,k],
#       thus add upt[i,j]/(neq[j] > nst[j,k]) to the unit proc time for
#                                             prod i in month k 
#    else
#       prod i cannot be produced because of lack of equipment j, hence add a
#       large number (say 1.E5) to the unit processing time for prod i in month k

param ut { i in PRODS, k in MONTHS } =
      sum { j in EQUIP_TYPES } ( if upt[i,j] > 0.0 then
                                    if neq[j] > nst[j,k] then
                                       upt[i,j] / (neq[j] - nst[j,k])
                                    else
                                       1.E5
                                 else
                                    0.0 ) ;

# Decision variables and constraints

# number of units of each product produced per month (1 unit = 25 L)
var p { i in PRODS, k in MONTHS } >= 0.0, <= mxp[i,k];

# number of processing hours per month
var nph { k in MONTHS } = sum { i in PRODS } ut[i,k] * p[i,k] ;

s.t. MaxDays { k in MONTHS } : nph[k] <= (8+8) * nwd[k] ;

maximize profit : sum { i in PRODS, k in MONTHS } prf[i] * p[i,k] ; 

######################################################################

option substout 1 ;
option show_stats 1 ;
option solver cplex ;

######################################################################

data ;

set PRODS       := P1 P2 P3 P4 P5 P6 P7 ;
set EQUIP_TYPES := MIX DECANT REACT DRYER DISTIL ;
set MONTHS      := JAN ;

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

param nst : JAN :=
MIX          1
DECANT       0
REACT        0
DRYER        0
DISTIL       0 ;

param mxp (tr) : P1    P2   P3   P4   P5   P6   P7 :=
JAN             500  1000  150  300  200  200   90 ;

param nwd :=
JAN   27 ;
