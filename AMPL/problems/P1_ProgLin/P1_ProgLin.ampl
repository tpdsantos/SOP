
set PRODS ;

param CRUDE_COST          >= 0 ;
param NEEDS     { PRODS } >= 0 ;
param PRICE     { PRODS } >= 0 ;

########################################

var prods {p in PRODS} >= 0 , <= NEEDS[p]/30 ;


##### BALANÇO COLUNA DE DESTILAÇÃO #####

set DEST_OUT ;

param MAX_DEST                  >= 0       ;
param OP_COST_DEST              >= 0       ;
param DEST_REND    { DEST_OUT } >= 0, <= 1 ;

var crude  >= 0 , <= MAX_DEST ;
var dest_out {do in DEST_OUT}  = crude * DEST_REND[do] ;


##### BALANÇO UNIDADE DE CRACKING #####

set CRACK_IN  ;
set CRACK_OUT ;

param OP_COST_CRACK { CRACK_IN  } >= 0 ;
param CRACK_MAX     { CRACK_IN  } >= 0 ;
param CRACK_REND    { CRACK_OUT } >= 0 ;

var crack_in {ci in CRACK_IN } >= 0 , <= CRACK_MAX[ci] ;
var crack_out {co in CRACK_OUT} = sum {ci in CRACK_IN} ( crack_in[ci] ) * CRACK_REND[co] ;


##### BALANÇO AO BLENDING DE FUEL ÓLEO #####

set BLEND_IN ;

var blend_in { BLEND_IN } >= 0 ;

s.t. fuel_oil : prods['Fuel'] = sum {bi in BLEND_IN} ( blend_in[bi] ) ;

s.t. blend_res {iv in {'Res'}}: blend_in[iv] = dest_out[iv] ;


##### BALANÇO NAFTA #####

param iv1 symbolic := 'Naf' ;

var inter_nafta >= 0 ;

s.t. nafta_mass_balance : dest_out[iv1] = inter_nafta + prods[iv1] ;


##### BALANÇO GASOLINA #####

param iv2 symbolic := 'Gas' ;

s.t. gas_mass_balance : inter_nafta + crack_out[iv2] = prods[iv2] ;
s.t. nafta_restraint  : inter_nafta = crack_out[iv2] ;


##### BALANÇO DESTILADO MÉDIO #####

param iv3 symbolic := 'DM' ;

var inter_dm >= 0 ;

s.t. dm_mass_balance : dest_out[iv3] = blend_in[iv3] + inter_dm ;


##### BALANÇO DESTILADO PESADO #####

param iv4 symbolic := 'DP' ;

s.t. dp_mass_balance : dest_out[iv4] = blend_in[iv4] + crack_in[iv4] ;


##### BALANÇO GASÓLEO #####

param iv5 symbolic := 'Diesel' ;

var inter_diesel >= 0 ;

s.t. diesel_mass_balance : crack_out[iv5] = blend_in[iv5] + inter_diesel ;


##### BALANÇO ÓLEO COMBUSTÍVEL #####

param iv6 symbolic := 'Oil' ;

s.t. oil_mass_balance : prods[iv6] = inter_dm + inter_diesel ;
s.t. ratio_restraint  : inter_dm = 0.75 * (inter_dm+inter_diesel) ;


##### BALANÇO JET FUEL #####

param iv7 symbolic := 'Jet' ;

s.t. jet_mass_balance : prods[iv7] = dest_out[iv7] ;


##### DETERMINAÇÃO DE VALORES FINANCEIROS #####

var costs = CRUDE_COST * crude
          + OP_COST_DEST * crude
          + sum {ci in CRACK_IN} ( crack_in[ci] * OP_COST_CRACK[ci] )
          ;

var sales = sum {p in PRODS} ( PRICE[p] * prods[p] ) ;

maximize profit : sales - costs ;

##############################################

data ;

set PRODS     := Gas Naf Jet Oil Fuel ;

param CRUDE_COST := 7.5 ;

param :        NEEDS , PRICE :=
	Gas    81000    18.5
        Naf    33000     8.0
        Jet    69000    12.5
        Oil    51000    14.5
        Fuel  285000     6.0  ;

set DEST_OUT  := Naf Jet DM DP Res ;
param MAX_DEST := 15000 ;
param OP_COST_DEST := 0.5 ;
param DEST_REND := Naf 0.13
                   Jet 0.15
                   DM  0.22
                   DP  0.20
                   Res 0.30 ;


set CRACK_IN  := DP ;
set CRACK_OUT := Gas Diesel Waste ;

param :     OP_COST_CRACK , CRACK_MAX :=
	DP     1.5           2500      ;

param CRACK_REND := Gas    0.40
                    Diesel 0.55
                    Waste  0.05 ;

set BLEND_IN := Res DP DM Diesel ;

##############################################

option substout 1 ;
option show_stats 1 ;
option solver "/home/tsantos/SOFTWARES/ampl-demo/cplex" ;
solve ;

display profit ;
display {p in PRODS} prods[p] ;
display crude ;
display {p in CRACK_IN} crack_in[p] ;
display {p in BLEND_IN} blend_in[p] ;