
# Neste exercício tentamos desenvolver um programa que nos resolva qualquer problema de sudoku,
# precisando apenas dos valores iniciais que todos os sudokus têm. 

set ROWS   := 1..9 ;
set COLS   := 1..9 ;
set DIGITS := 1..9 ;

var b { ROWS , COLS , DIGITS } binary ;

var n { r in ROWS , c in COLS } = sum {d in DIGITS} ( d * b[r,c,d] ) ;

s.t. unique_digits { r in ROWS , c in COLS } : sum { d in DIGITS } b[r,c,d] = 1 ;

s.t. unique_rows { r in ROWS , d in DIGITS } : sum {c in COLS} b[r,c,d] = 1 ;

s.t. unique_cols { c in COLS , d in DIGITS } : sum {r in ROWS} b[r,c,d] = 1 ;

s.t. sub_grid { I in {1,4,7}, J in {1,4,7} , d in DIGITS } :
	sum { i in {0,1,2}, j in {0,1,2} } b[I+i,J+j,d] = 1 ;


set CLUES within { ROWS , COLS } ;

param n0 { CLUES } integer >= 1, <= 9 ;

s.t. fix_vals { (r,c) in CLUES, d in DIGITS } : b[r,c,d] = (if n0[r,c] = d then 1 else 0) ;

###################################

data ;

param : CLUES : n0 := 1 1 2
                      1 4 3
                      2 1 8
                      2 3 4
                      2 5 6
                      2 6 2
                      2 9 3
                      3 2 1
                      3 3 3
                      3 4 8
                      3 7 2
                      4 5 2
                      4 7 3
                      4 8 9
                      5 1 5
                      5 3 7
                      5 7 6
                      5 8 2
                      5 9 1
                      6 2 3
                      6 3 2
                      6 6 6
                      7 2 2
                      7 6 9
                      7 7 1
                      7 8 4
                      8 1 6
                      8 3 1
                      8 4 2
                      8 5 5
                      8 7 8
                      8 9 9
                      9 6 1
                      9 9 2 ;

##################################

option substout 1 ;
option show_stats 1 ;

option solver "/home/tsantos/SOFTWARES/ampl-demo/cplex" ; # `option solver cplex` para quem usa IDE
solve ;

display {r in ROWS, c in COLS} n[r,c] ;



