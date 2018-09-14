# *Julia*

|||
|---|---|
| Created | 13-09-2018 |
| Last Updated | 14-09-2018 |

Documentação oficial : *https://docs.julialang.org/en/v0.6.4/*

***

*Julia* é uma linguagem de programação recente, leve e *open-source*. Em muito poucas palavras, é uma espécie de junção entre *MatLab* e *Python*, juntando a facilidade de cálculo numérico do *MatLab* com a flexibilidade dos objetos de *Python*. Esta documentação não supõe bases nenhumas de programação, embora assuma bases de cálculo matricial.


## A REPL (read-eval-print-loop)

A REPL é a linha de comandos utilizada em *Julia*. Nesta linha de comandos é onde fazemos testes, corremos código em separado ou contido num ficheiro.


## Variáveis

O aspeto mais importante de qualquer linguagem de programação é a variável. Uma variável é algo que nos fornece a possibilidade de reutilizar pedaços de código de uma forma fácil, sejam esses pedaços uma simples linha de código ou 10000. No REPL, definir uma variável é tão simples quanto:

```julia
variable = 1
```

Com esta variável definida, podemos fazer inúmeros cálculos com ela:

```julia
variable * 2
variable + 3*variable - variable/2
```

Copiem para o REPL (uma linha de cada vez) e vejam os resultados. Como numa função matemática, as variáveis ajudam-nos a criar programas gerais, que se aplicam a vários casos, sem termos de reescrever os programas já feitos.


## Recursividade

A recursividade é algo muito importante em qualquer linguagem, dá-nos a possibilidade de correr algum código um determinado número de vezes sem termos de o repetir manualmente. Há duas maneiras fazer isto, dependendo dos nossos objetivos, que são os ciclos *for* e *while*.


### Ciclo *for*

É o tipo de ciclo mais utilizado, pois é versátil, embora nem seja sempre o mais adequado. Um exemplo muito simples:

```julia
for i = 1:1:3 
    println(i)
end
```

Neste caso, ao dizermos `for i = 1:1:3`, estamos a dizer que queremos que todo o código entre esta linha e `end` corra três vezes (`1:1:3` significa que a variável `i` irá do 1, de 1 em 1, até ao 3, ou seja, 1, 2 e 3. Se o passo for de 1 em 1, podem omitir o 1 do meio e escrever apenas `for i = 1:3`). A função `println` faz com que o que está dentro dos parênteses seja mostrado na linha de comandos. Este exemplo não faz nada de útil, por isso vejamos outro onde tentamos calcular a sequência de fibonacci:

```julia
number_of_calculations = 5
first_term = 1
second_term = 1

for i = 1:number_of_calculations
    fib = first_term + second_term
	first_term = second_term
	second_term = fib
	println(fib)
end
```

Com este código podemos ver os primeiros valores da sequência de fibonacci, principalmente os primeiros cinco (sem contar com os dois primeiros que são 1). A implementação de um ciclo *for* é extremamente simples e flexível, útil numa infinidade de casos.


### Ciclo *while*

O ciclo *while* é outro exemplo de recursividade mais específico. Neste caso, em vez de especificarmos o número de vezes que se quer correr o código (no exemplo anterior, eram 5), temos de dizer quando é que queremos que *while* pare. Usaremos o exemplo anterior, mas em vez de um *for* utilizaremos um *while*. Para tentarmos replicar exatamente a mesma resposta, temos de saber qual o último valor determinado, que foi 13. Tendo em conta isso, vamos construir o ciclo:

```julia
number_of_calculations = 5
first_term = 1
second_term = 1

while first_term+second_term <= 13
    fib = first_term + second_term
	first_term = second_term
	second_term = fib
	println(fib)
end
```

Deste modo conseguimos replicar o resultado usando outra forma de escrita. Para resolver este problema ambas as formas são igualmente boas, agora o uso de uma ou outra depende dos dados que pretendem introduzir (se o número de cálculos ou o valor final de cálculo) e do programador em si. Há casos em que uma ou outra são mais simples de utilizar, mas não é obrigatório que utilizem sempre a mais simples, utilizem a que gostam mais, desde que resulte (eu pessoalmente tento evitar os ciclos *while*, mas é a minha opinião pessoal).


## Condições

Esta é uma secção é importantíssima, pois não há forma de as escapar. Todo o programa acaba por precisar de tomar decisões, mas somos nós que temos de lhe indicar que decisões tomar.

No exemplo anterior do ciclo *while*, tivemos de tomar uma decisão, quando dizemos que queremos que o código pare de correr quando aquela condição é satisfeita (`first_term+second_term <= 13`). Se não a tomássemos, o programa correria infinitamente até o forçarmos a parar. Existem três principalmente três timos de cláusulas condicionais, a cláusula `case end`, `try catch end` e a `if elseif else end`. Vamo-nos focar apenas na última.


### Cláusulas `if elseif else end`


