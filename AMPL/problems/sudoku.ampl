
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

param: CLUES: n0 := 1 7 6
                    1 8 8
                    2 5 7
                    2 6 3
                    2 9 9
                    3 1 3
                    3 3 9
                    3 8 4
                    3 9 5
                    4 1 4
                    4 2 9
                    5 1 8
                    5 3 3
                    5 5 5
                    5 7 9
                    5 9 2
                    6 8 3
                    6 9 6
                    7 1 9
                    7 2 6
                    7 7 3
                    7 9 8
                    8 1 7
                    8 4 6
                    8 5 8
                    9 2 2
                    9 3 8 ;

##################################

option substout 1 ;
option show_stats 1 ;

option solver "/home/tsantos/SOFTWARES/ampl-demo/cplex" ; # `option solver cplex` para quem usa IDE
solve ;

display {r in ROWS, c in COLS} n[r,c] ;



