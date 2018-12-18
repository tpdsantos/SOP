
set PRODS ;
set EQUIPS ordered ;
set MONTHS ordered ;

param NUNITS { EQUIPS } integer >= 0 ;
param NMAINT { EQUIPS , MONTHS } integer >= 0 ;
param PROFIT { PRODS } >= 0 ;
param PROC_TIME { EQUIPS , PRODS } >= 0 ;
param MAX_SALE { MONTHS , PRODS } >= 0 ;
param MONTH_DAYS { MONTHS } integer >= 0 ;

param MONTH_HOURS {m in MONTHS} integer = 16 * MONTH_DAYS[m] ;

#####################################################

var prods {p in PRODS,m in MONTHS} >= 0, <= MAX_SALE[m,p] ;

s.t. prod_calc {e in EQUIPS, m in MONTHS} :
	sum {p in PRODS} PROC_TIME[e,p] * prods[p,m]
        <=
	MONTH_HOURS[m] * (NUNITS[e] - NMAINT[e,m]) ;

var sales = sum {p in PRODS, m in MONTHS} PROFIT[p] * prods[p,m] ;

maximize profit : sales ;

########################################

data ;

set PRODS := P1 P2 P3 P4 P5 P6 P7 ;
set EQUIPS := Mix Dec Reac Sec Col ;
set MONTHS := Jan ;

param NUNITS := Mix   4
                Dec   2
                Reac  3
                Sec   1
                Col   1 ;

param NMAINT : Jan :=
	Mix     1
        Dec     0
        Reac    0
        Sec     0
        Col     0   ;

param PROFIT := P1  10
                P2  60
                P3  80
                P4   4
                P5  11
                P6   9
                P7   3 ;

param PROC_TIME :  P1   P2   P3   P4   P5   P6   P7 :=
	Mix       0.5  0.7  0.0  0.0  0.3  0.2  0.5
        Dec       0.1  0.2  0.0  0.3  0.0  0.2  0.5
        Reac      0.2  0.0  0.8  0.0  0.0  0.0  0.6
        Sec       0.5  0.3  0.0  0.7  1.0  0.0  0.8
        Col       0.0  0.0  1.2  0.0  1.5  0.0  0.9  ;

param MAX_SALE :  P1    P2   P3   P4   P5   P6  P7 :=
	Jan      500  1000  150  300  200  200  90 ;

param MONTH_DAYS := Jan 26 ;

#######################################

option substout 1     ;
option solver   cplex ;

solve ;

display profit ;
display prods  ;
