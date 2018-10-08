---
layout: post
title: Formular um Problema
author: Tiago Santos
creation: 06-10-2018
update: 06-10-2018
email: tpd.santos@campus.fct.unl.pt
software: ampl
---

Nesta secção falaremos em como formular um problema real, criando restrições, variáveis dependentes e mandar o AMPL minimizar ou maximizar a condição desejada.


## Variáveis dependentes

Na secção anterior aprendemos a declarar variáveis, mais especificamente variáveis independentes (VI). Variáveis dependentes (VD) e independentes funcionam exatamente da mesma forma que numa função. Uma VI é livremente modificada pelo AMPL para atingir o objetivo. Uma VD é dependente do valor das VI, sendo apenas modificada quando a VI é modificada. A sintaxe é muito simples, quase como escrever uma função:

```
var dependent_var = ... 
```

Em que os `...` representam qualquer equação ou fórmula que dependa da/s VI.

As VD servem principalmente para simplificar e tornar legível fórmulas e modelos mais complexos, com muitos termos e dependentes de muitas variáveis.


## Restrições

As restrições são muito importantes em AMPL. Como o nome indica, são maneiras de escrever restriçṍes ao nosss problema, mas tem várias peculiaridades para nos facilitar a vida, por isso vamos abordar as mais usadas. A sintaxe mais simples:

```
s.t. restriction_name : something = solmething_else ;
# or
subject to restriction_name : something = something_else ;
```

`something` e `something_else` podem ser qualquer tipo de fórmula ou equação, podem envolver VI, VD e parâmetros. Onde está `=` pode estar `< > <= >=`. Algo a notar é que, ao contrário de *Julia*, o termo à esquerda do símbolo de comparação não é necessário que seja apenas uma variável, podemos ter expressões complexas em ambos os lados do símbolo.

Muitas das vezes nós temos variáveis associadas a conjuntos, e normalmente queremos restrições para todas as associações das variáveis. Por exemplo, tendo um conjunto de matérias primas e tendo uma variável que é o caudal das matérias primas, queremos determinar o caudal ótimo de matérias primas sabendo que existe um limite máximo de venda de matérias primas por dia. Uma restrição que descreveria este exemplo seria:

```
set RAWMAT ;

var raw_flow { RAWMAT } ;

param raw_max { RAWMAT } ;

s.t. max_raw {r in RAWMAT} : raw_flow[r] <= raw_max[r] ;
```


