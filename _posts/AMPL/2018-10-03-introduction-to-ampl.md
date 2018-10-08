---
layout: post
title: Introdução a AMPL
author: Tiago Santos
creation: 03-10-2018
update: 06-10-2018
email: tpd.santos@campus.fct.unl.pt
software: ampl
---


## Premissa da linguagem

A linguagem AMPL é bastante distinta das outras linguagens mais populares no que toca à sua premissa principal. Ela não foi criada para ser flexível nem para ser versátil, foi criada para resolver um determinado tipo de problemas da forma mais eficiente e rápida possível, e faz exatamente isso, sacrificando a versatilidade.

Tendo em conta isso, a linguagem AMPL foi criada especificamente para facilitar a formulação de problemas de otimização. Falando pessoalmente, acho que as pessoas sem conhecimentos de programação têm mais facilidade em adaptar-se à sintaxe, visto que é bastante diferente de todas as outras linguagens (eu, que quando aprendi vinha de MatLab, tive algumas dificuldades em percebê-la). Embora, no início, não pareça muito intuitiva, com um bocadinho de prática é muito fácil de se adaptar.

Este tipo de linguagem não tem nada a ver com *MatLab* nem *Python*. Uma das pequenas coisas que têm em comum é o facto de podermos criar vetores. É uma linguagem baseada em conjuntos: quando criamos um conjunto, seja ele qual for (já mostraremos exemplos), ele podser atribuído a qualquer parâmetro ou variável criados. Uma outra grande diferença é o facto de ser **100% declarativa**, o que significa que, antes de utilizarem uma variável ou um parâmetro quando estão a construir um modelo, essa variável ou parâmetro tem de ser explicitamente declarado, têm que dizer que é um parâmetro, a que conjunto pertence (pode ser a nenhum conjunto) e de que tipo (se são símbolos, números, etc). Não é possível criar variáveis intermediárias não declaradas.

Outros dois pontos muito importantes são: 

- todas as linhas de código têm de acabar com `;`. AMPL ignora todos os espaços em branco, temos de o informar especificamente que a nossa linha de código acabou.
- devido ao ponto interior, a boa notícia é que podemos dividir linhas de código compridas (fórmulas complexas com muitos termos, por exemplo) por várias linhas, aumentando assim legibilidade dos nossos programas. Mais tarde veremos como tirar proveito dessa obrigatoriedade.

Tomando isto em conta, vamos passar à prática:


## Sintaxe básica

Nesta secção falaremos nos elementos básicos de AMPL, como conjuntos, variáveis, parâmetros, fórmulas e restrições. 


### Conjuntos

Os conjuntos são a sintaxe mais geral e mais utilizada. Um conjunto não é nada mais do que uma sequência de valores para classificar algo. Por exemplo, se temos um problema de otimização em que queremos encontrar o caudal ótimo de entrada de matérias primas numa fábrica, tendo em conta os custos destas, por exemplo, criaríamos um conjunto com todas as matérias primas, como por exemplo:

```
set RAWMAT ;
```

Desta forma criámos um conjunto, declarado pelo comando `set`, chamado `RAWMAT` que engloba todas as matérias primas que entram na fábrica. Mais tarde daremos valores ao conjunto, por enquanto é geral. Deste modo podemos associar variáveis e/ou parâmetros a esse conjunto, para irmos construindo o problema. Se a ordem é importante, basta escrever `ordered` à frente:

```
set RAWMAT ordered ;
```


### Variáveis

Visto que queremos achar o caudal ótimo de matérias primas, temos de criar uma variável associada ao conjunto das matérias primas:

```
var raw_flow { RAWMAT } >= 0.0 ; 
```

Nesta sintaxe temos várias nuances. O comando `var` serve para explicitar uma variável e o que está entre chavetas é o conjunto que queremos associar à variável. Não há limite para o número de associações, uma variável ou parâmetro pode estar associado a qualquer número de conjuntos. Suponhamos que cada matéria prima é vendida por fábricas diferentes, podemos fazer isto:

```
set RAWMAT ;
set FACTORIES ;

var raw_flow { RAWMAT, FACTORIES } >= 0 ;
```

Neste caso criámos uma variável associada a cada matéria prima e a cada fábrica. Outra maneira de explicar isto é pensando em matrizes: uma variável associada a dois conjuntos é idêntica a uma matriz com duas dimensões, em que cada fábrica (as colunas da matriz) vende todas as matérias primas (as linhas da matriz) necessárias à nossa fábrica, por exemplo. Ao escrevermos `>= 0` estamos apenas a dizer que a variável não pode tomar valores negativos.


### Parâmetros

Parâmetros são constantes durante todo o programa. Podem ser rendimentos de reações, custos de matérias prima, custos de operação, etc. Para definir um basta:

```
param RAW_COST { RAWMAT } >= 0 ;
```

Assim ficou definido um parâmetro que engloba os custos das matérias primas.


### Tipos

A maior parte das variáveis e parâmetros são reais, podem tomar qualquer valor decimal. No entanto, algumas vezes queremos definir variáveis apenas como inteiras ou binárias. Para definirmos como inteiras:

```
var raw_flow { RAWMAT, FACTORIES } >= 0 integer ;
param RAW_COST { RAWMAT } >= 0 integer ;
```

Assim estas instâncias apenas podem tomar valores inteiros.

No caso de valores binários, quase sempre são utilizados apenas em variáveis, as chamadas variáveis de decisão. Suponhamos que temos vários equipamentos disponíveis numa fábrica, cada um com um tempo de trabalho e limpeza diferentes, com unidades em meses. Como maximizar o lucro anual sabendo que a disponibilidade dos equipamentos varia em cada mês? Com este problema podemos utilizar as variáveis binárias:

```
set EQUIPS ;
set MONTHS ;

var avail_equip { EQUIPS, MONTH } binary ; # avail de availability
```

Desta forma podemos "ligar" e/ou "desligar" equipamentos em cada mês, visto que uma variável binária, como o nome indica, só pode tomar os valores 0 ou 1.

Assim acaba esta secção. Na próxima falaremos em como criar um problema.
