
set RAW  ; # conjunto de matérias primas
set PROD ; # conjunto de produtos

param MAX_CAP                  >= 0 ; # capacidade máxima da fábrica
param MAKE_COST                >= 0 ; # custo de fabrico dos produtos
param RAW_COST  { RAW        } >= 0 ; # custo das matérias primas
param MAX_AVAIL { RAW        } >= 0 ; # disponibilidade máxima de cada matéria prima
param PRICE     {       PROD } >= 0 ; # preço de mercado dos produtos
param DEMAND    {       PROD } >= 0 ; # procura dos produtos
param REND      { RAW , PROD } >= 0 ; # rendimento de cada matéria prima

#################################

var raw { RAW } >= 0 ;

var prods {p in PROD} = sum {r in RAW} ( REND[r,p]/100 * raw[r] ) ;

s.t. max_avail {r in RAW} : raw[r] <= MAX_AVAIL[r] * 1000 ;

s.t. max_cap : sum {r in RAW} ( raw[r] ) <= MAX_CAP * 1000 ;

s.t. demand {p in PROD} : prods[p] <= DEMAND[p] ;

var costs = MAKE_COST * sum {r in RAW} ( raw[r] )
          + sum {r in RAW} ( RAW_COST[r] * raw[r] )
          ;

var sales = sum {p in PROD} ( PRICE[p] * prods[p] ) ;

maximize profit : sales - costs ;

####################################

data ;

set RAW  := A1 A2 A3 ;
set PROD := P1 P2    ;

param MAX_CAP   := 22  ;
param MAKE_COST := 0.1 ;

param :     RAW_COST , MAX_AVAIL :=
	A1    0.8        12        
        A2    0.7         8
        A3    0.9        10       ;

param :     PRICE , DEMAND :=
	P1   50      750
        P2   60      500    ;

param REND :      P1    P2 :=
	     A1   5     0
             A2   3     1
             A3   1.5   4   ;

###################################

option solver "/home/tsantos/SOFTWARES/ampl-demo/cplex" ;
solve ;

display profit ;
display {r in RAW} raw[r], {p in PROD} prods[p] ;
