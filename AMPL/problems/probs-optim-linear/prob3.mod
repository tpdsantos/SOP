
set PROCS_A ; # conjunto dos processos que envolvem 'A'

param COST_A  >= 0 ; # custo de 'A'
param COST_B  >= 0 ; # custo de 'B'
param YIELD     { PROCS_A } >= 0 ; # rendimento dos processos que envolvem 'A'
param MIN_CAP   { PROCS_A } >= 0 ; # capacidade mínima das matérias primas correspondentes a 'A'
param MAX_CAP   { PROCS_A } >= 0 ; # capacidade máxima das matérias primas correspondentes a 'A'
param MAX_A >= 0 ;
param MAX_B >= 0 ;
param DEMAND_C              >= 0 ; # procura estimada de C
param SALES_C               >= 0 ; # preço de venda de C
param YIELD_C              >= 0 ; # rendimento de C
param cost_fix_A { PROCS_A } >= 0 ;
param cost_var_A { PROCS_A } >= 0 ;
param cost_fix_B >= 0 ;
param cost_var_B >= 0 ;

#####################################

var a { PROCS_A } >= 0 ;

var b = sum {p in PROCS_A} ( a[p] * YIELD[p] ) ;

var bc >= 0 ;

# Para resolver a alínea a), basta correr este programa.
# Para resolver a alínea b), apagar o '#' no início da linha abaixo
#
# include prob3b.ampl
#

var c = (b + bc) * YIELD_C ;

s.t. min_A {p in PROCS_A} : a[p] >= MIN_CAP[p] ;
s.t. max_A {p in PROCS_A} : a[p] <= MAX_CAP[p] ;

s.t. maxA : sum {p in PROCS_A} ( a[p] ) <= MAX_A ;

s.t. maxB : bc <= MAX_B ;

s.t. maxC : c <= DEMAND_C ;

var costs = COST_A * sum {p in PROCS_A} ( a[p] )
          + COST_B * bc
          + sum {p in PROCS_A} ( cost_fix_A[p] + cost_var_A[p]*a[p] ) 
          + cost_fix_B + cost_var_B*(b+bc)
          ;

var sales = SALES_C * c ;

maximize profit : sales - costs ;

#########################################

data ;

set PROCS_A := A1 A2 A3 ;

param COST_A := 400 ;
param COST_B := 500 ;

param MAX_A := 20 ;
param MAX_B := 10 ;

param DEMAND_C := 18  ;
param  SALES_C := 900 ;
param  YIELD_C := 0.9 ;

param cost_fix_B := 90 ;
param cost_var_B := 15 ;

param :      YIELD , MIN_CAP , MAX_CAP , cost_fix_A , cost_var_A :=
	A1    0.95      3         6          50         10
        A2    0.85      3         8          40         7
        A3    0.99      2         5          70         8       ;

######################################

option substout 1 ;
option solver "/home/tsantos/SOFTWARES/ampl-demo/cplex" ;
solve ;

display profit ;
display {p in PROCS_A} a[p] ;
display b, bc, c ;