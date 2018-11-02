---
layout   : post
title    : Especificação dos dados de um problema
author   : Tiago Santos
creation : 02-11-2016
update   : 02-11-2016
email    : tpd.santos@campus.fct.unl.pt
software : ampl
---

## Introdução

Anteriormente vimos como formular um problema em AMPL, tentando torná-lo o mais geral possível, ou seja, utilizar parâmetros em vez de valores concretos principalmente. Depois disso, precisamos de dizer ao programa quais os valores desses parâmetros. É aí que entra a secção `data`.


## Secção `data`

Quando num script ou na linha de comandos digitamos o comando `data`, tudo o que escrevemos a seguir tem de ser apenas dar valores a parâmetros e conjuntos. A sintaxe é um bocado diferente da da formulação de problema, vamos vê-la agora:

```
data ;

set set_name := set_values ;

param param_name := param_values ;
```

A escrita é praticamente igual à da formulação do problema, exceto a parte do `:=`. Ao dar valores a parâmetros e/ou conjuntos, temos de usar sempre o `:=` em vez do `=`. 

O AMPL, visto que há problemas com imensos parâmetros e alguns deles estão associados a diversos conjuntos, criou várias sintaxes para facilitar todos estes problemas. O primeiro caso é o facto de haver muitos parâmetros associados ao mesmo conjunto:

```
data ;

set A := A1 A2 A3 ;

param : P1 , P2 , P3 , P4 , P5 :=
   A1   V1   V1   V1   V1   V1
   A2   V2   V2   V2   V2   V2
   A3   V3   V3   V3   V3   V3  ;
```

`V1`, `V2`, `V3` correspondem apenas a valores fictícios. Ao meter `:` depois de `param` podemos meter, entre vírgulas, todos os parâmetros associados ao mesmo conjunto. Desta forma podemos definir vários parâmetros ao mesmo tempo, poupando espaço e tempo.

Algumas vezes temos conjuntos extensos, e os parâmetros associados a esses seriam também tediosos de dar valores. Para não precisarmos de definir primeiro o conjunto e depois o parâmetro associado a ele, podemos definir os dois ao mesmo tempo:

```
param : A : param_A := A1 V1
                       A2 V2
					   A3 V3
					   A4 V4
					   A5 V5
					   A6 V6 ;
```

Na mesma sintaxe dizemos que os primeiros valores definem o conjunto `A` e os segundos valores definem os valores do parâmetro `param_A`. Desta forma não precisamos de definir primeiro o `set` e depois o `param`, escrevemos tudo dentro do `param`.


