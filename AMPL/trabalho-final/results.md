
# Resultados do Trabalho de AMPL


## Problema 1

Tendo em conta que os dias úteis de trabalho podem variar, dependendo de quando se começa a contar, os valores abaixo foram determinados utilizando os seguintes dias úteis:

```
Jan  26
Feb  25
Mar  27
Apr  25
May  27
Jun  26

```

### Alínea a)

```
profit = 241068

gen_prods [*,*]
:    Jan    Feb   Mar     Apr     May   Jun    :=
P1    232   440     0   200       100   450
P2   1000   600     0   300       200   450
P3    150   100   100   200       250     0
P4      0     0     0   147.619   200    80
P5      0     0     0   106.667    58     0
P6    200   300   400     0       300   550
P7      0     0     0     0        50     0
;
```

Em que `gen_prods` é a quantidade de produto produzida.


### Alínea b)

```
profit = 273512

gen_prods [*,*]
:    Jan    Feb      Mar        Apr     May   Jun    :=
P1    232   500   300         248         0   502
P2   1000   500   600         400         0   550
P3    150   100     5.41667   194.583   350     0
P4      0     0     0          50         0     0
P5      0     0   102          81         0     0
P6    200   300   400           0       300   550
P7      0     0     0          50         0     0
;

MONTH_NMAINT [*,*] (tr)
:   Mix Dec Reac Sec Col    :=
Jan   0   1   2    0   0
Feb   0   0   0    0   0
Mar   0   0   0    0   0
Apr   2   0   0    0   0
May   0   0   1    1   0
Jun   0   1   0    0   1
;
```

Em que `gen_prods` é a quantidade de produto produzida e `MONTH_NMAINT` é o número de equipamentos de cada tipo desativados em cada mês.


## Problema 2

```
investment = 3308.33

:  bin    F      :=
1    0      0
2    1   1000
3    0      0
4    0      0
5    0      0
6    0      0
7    0      0
8    1    450
9    0      0
10   1    550
;
```

Em que `investment` é o custo a minimizar, `bin` é a variável binária e `F` é o caudal de entrada de cada separador.


