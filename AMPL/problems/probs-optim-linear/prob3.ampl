
# Este ficheiro chama apenas a resolução de cada alínea.
# Achei melhor este tipo de organização para não se perderem em códigos extensos.
# A resolução das alíneas estão em ficheiros separados, como se pode ver nesta pasta.
#
# Para resolver a alínea a), retirar o '#' do início da linha abaixo:
#
 include prob3a.ampl
#
# Para resolver a alínea b), retirar o '#' do início da linha acima e abaixo:
#
 include prob3b.ampl
#

################################################

option substout 1 ;
option solver "/home/tsantos/SOFTWARES/ampl-demo/cplex" ;
solve ;

display profit ;
display {p in PROCS_A} a[p] ;
display b, bc, c ; 


