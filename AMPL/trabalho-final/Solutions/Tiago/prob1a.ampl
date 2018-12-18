
set PRODS  ordered ; # conjunto dos produtos
set EQUIPS ordered ; # conjunto dos tipos de equipamentos
set MONTHS ordered ; # conjunto dos meses

set NEED_EQUIPS within { EQUIPS , PRODS } ; # conjunto de equipamentos realmente necessários à produção de cada produto

param STOCK_COST >= 0 ; # custo de armazenamento por unidade e por mês

param MONTH_DAYS {                  MONTHS } integer >= 0 ; # número de dias úteis por mês
param MAX_STOCK  {                  MONTHS }         >= 0 ; # stock mínimo de cada produto em cada mês
param MIN_STOCK  {                  MONTHS }         >= 0 ; # stock máximo de cada produto em cada mês
param PROFIT     {          PRODS          }         >= 0 ; # lucro de cada produto
param NUNITS     { EQUIPS                  } integer >= 0 ; # número de unidades de cada equipamento
param NMAINT     { EQUIPS ,         MONTHS } integer >= 0 ; # número de unidades em manutenção
param MAX_SALE   {          PRODS , MONTHS }         >= 0 ; # restrições de mercado

param PROC_TIME { NEED_EQUIPS             } >= 0 ; # tempo de processamento

param MONTH_HOURS {m in MONTHS} = (8+8) * MONTH_DAYS[m] ; # número de horas úteis por mês

###############################################################

# unidades produzidas de cada produto em cada mês
var gen_prods { PRODS , MONTHS } >= 0 ;


# unidades em stock de cada produto em cada mês
var stock_prods {p in PRODS,m in MONTHS} in [ MIN_STOCK[m] , MAX_STOCK[m] ] ;;


# unidades vendidas por produto e por mês
var sold_prods {p in PRODS,m in MONTHS} in [ 0 , MAX_SALE[p,m] ] ;


# Sabemos que o stock em Janeiro é 0, e o stock de cada mês é a diferença entre
# a quantidade disponível para venda (produzido este mês + stock mês anterior)
# e a quantidade vendida.
s.t. stock_calc {p in PRODS,m in MONTHS} :
	stock_prods[p,m] = gen_prods[p,m] - sold_prods[p,m] + (if m = first(MONTHS) then 0
                                                               else stock_prods[p,prev(m)]);


# caso as unidades disponíveis para venda sejam inferiores aos valores máximos de venda,
# temos de garantir que não vendemos unidades que não temos apenas no primeiro mês, visto que
# essa restrição já está subentendida no cálculo dos stocks dos restantes meses.
s.t. sell_limit_first {p in PRODS} : sold_prods[p,first(MONTHS)] <= gen_prods[p,first(MONTHS)] ;;


# Cada mês tem uma quantidade de horas disponível para trabalhar, significando que cada unidade
# pode trabalhar no máximo essas horas. No entanto, no caso de termos mais que uma unidade de cada
# tipo, o número de horas efetivo que temos para cada tipo de equipamento trabalhar é igual ao
# número de horas mensais vezes o número de unidades de cada equipamento. Ou seja, o tempo que
# dispendemos a usar cada tipo de equipamento para cada produto tem de ser inferior ao número efetivo
# de horas que temos disponível em cada mês.
s.t. production {e in EQUIPS ,m in MONTHS} :
	sum {(e,p) in NEED_EQUIPS} ( PROC_TIME[e,p] * gen_prods[p,m] )
        <=
	MONTH_HOURS[m] * (NUNITS[e] - NMAINT[e,m]) ;


# custos de armazenamento
var costs = sum {p in PRODS,m in MONTHS} ( stock_prods[p,m] ) * STOCK_COST ;


# receitas
var sales = sum {p in PRODS,m in MONTHS} ( sold_prods[p,m] * PROFIT[p] ) ;


# maximização do lucro
maximize profit : sales - costs ;

#######################################

data prob1a.dat ;

#######################################


option substout   1     ;
option show_stats 1     ;
option solver     cplex ;
solve ;

display profit ;
display gen_prods ;