---
layout: post
title: Introdução a AMPL
author: Tiago Santos
creation: 03-10-2018
update: 03-10-2018
email: tpd.santos@campus.fct.unl.pt
software: ampl
---

**Documentação Oficial:** a documentação oficial está em formato pdf <a href="https://github.com/tpdsantos/SOP/tree/master/AMPL/docs">aqui</a>, basta carregarem nele e clicar em *Download* no canto superior direito do ficheiro. O ficheiro é relativamente grande, não se admirem se demorar um bocado de tempo, tanto a carregar como a fazer o download.


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

Os conjuntos são a sintaxe mais geral. Um conjunto não é nada mais do que uma sequência de valores para classificar algo. Por exemplo, se temos um problema de otimização em que queremos encontrar o caudal ótimo de entrada de matérias primas numa fábrica, tendo em conta os custos destas, por exemplo, criaríamos um conjunto com todas as matérias primas, como por exemplo:

```
set RAWMAT ;
```

Desta forma criámos um conjunto de todas as matérias primas que entram na fábrica. Mais tarde daremos valores ao conjunto, por enquanto é geral. Deste modo podemos associar variáveis e/ou parâmetros a esse conjunto, para irmos construindo o problema.
