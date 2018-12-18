-*///////////////**-set PRODS ordered ;

param NSEPS >= 0 ; # número de separadores disponíveis

set SEPS = 1..NSEPS ; # conjunto dos separadores

param F0 >= 0 ; # caudal de alimentação
param Cc >= 0 ; # custo da água de arrefecimento
param Ch >= 0 ; # custo do vapor

param FRACS { PRODS } >= 0, <= 1 ; # frações molares de cada produto no caudal de alimentação

param FIX_COST { SEPS } >= 0 ; # custo de investimento fixo
param VAR_COST { SEPS } >= 0 ; # custo de investimento variável
param CAL_COEF { SEPS } >= 0 ; # coeficiente de potência calorífica

####################################################

var bin { SEPS } binary ; # variável que vai decidir quais os separadores a utilizar
var F { SEPS } >= 0 ; # caudais de entrada de cada separador


# balanços de massa
s.t. F123 {k in 1..3} : F[k ] = F0 * bin[k] ;
s.t. F67 {k in {6,7}} : F[k ] = F0 * bin[k ] * (    1       - FRACS['A'] ) ;
s.t. F45 {k in {4,5}} : F[k ] = F0 * bin[k ] * (    1       - FRACS['D'] ) ;
s.t. F10              : F[10] = F0 * bin[10] * ( FRACS['C'] + FRACS['D'] ) ;
s.t. F9               : F[9 ] = F0 * bin[9 ] * ( FRACS['B'] + FRACS['C'] ) ;
s.t. F8               : F[8 ] = F0 * bin[8 ] * ( FRACS['A'] + FRACS['B'] ) ;


# balanços às variáveis binárias
s.t. bin_bal1 : sum{k in 1..3} ( bin[k] ) = 1 ;
s.t. bin_bal2 : bin[6] + bin[7] = bin[1] ;
s.t. bin_bal3 : bin[4] + bin[5] = bin[3] ;
s.t. bin_bal4 : bin[6] + bin[2] = bin[10] ;
s.t. bin_bal5 : bin[7] + bin[4] = bin[9] ;
s.t. bin_bal6 : bin[2] + bin[5] = bin[8] ;


# cálculo dos custos
var costs {k in SEPS} = FIX_COST[k] * bin[k] + ( VAR_COST[k] + (Cc + Ch)*CAL_COEF[k] ) * F[k] ;

minimize investment : sum{k in SEPS} ( costs[k] ) ;

####################################################

data prob2.dat

####################################################

option substout   1     ;
option show_stats 1     ;
option solver     cplex ;

solve ;

display investment ;
display bin, F ;