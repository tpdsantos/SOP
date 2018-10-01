---
title: Introdução a Julia
author: Tiago Santos
creation: 13-09-2018 
update: 21-09-2018
layout: post
email: tpd.santos@campus.fct.unl.pt
---

**Documentação oficial :** *https://docs.julialang.org/en/v0.6.4/*


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
first_term = 0
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
first_term = 0
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

No exemplo anterior do ciclo *while*, tivemos de tomar uma decisão, quando dizemos que queremos que o código pare de correr quando a condição `first_term+second_term <= 13` é satisfeita. Se não a tomássemos, o programa correria infinitamente até o forçarmos a parar. Existem principalmente três tipos de cláusulas condicionais, a cláusula `case end`, `try catch end` e a `if elseif else end`. Vamo-nos focar apenas na última.


### Cláusulas `if elseif else end`

É impossível fugir a condições, e a mais versátil e simples é a cláusula `if`. Funciona praticamente como falamos, se aparecer "x" acontece "y", senão acontece "z". Em linguagem de programação ficaria algo assim:

```julia
x = 1
if x == 1
    y = 2
else
    y = 3
end
```

Obviamente que isto é extremamente simples e não tem utilidade quase nenhuma na vida real, mas um exemplo simples é sempre o melhor para se entender os conceitos básicos. 

Reparem que não há nenhum erro nas igualdades, ter `==` e `=` é diferente. `==` é usado para comparar e `=` é para definir uma variável. Por exemplo, `x == y` seria utilizado para comparar os valores de `x` e `y`, tendo como resultado verdadeiro ou falso, e `x = y` faz com que a variável `x` tenha o mesmo valor que `y`.

Agora vamos tentar fazer recriar o ciclo *while* feito anteriormente utilizando um ciclo *for* e uma cláusula *if*:

```julia
first_term = 0
second_term = 1

for i = 1:10000
    fib = second_term + first_term
    first_term = second_term
    second_term = fib
    println(fib)
    if first_term+second_term > 13
        break
    end
end
```

Neste bocado já vemos várias coisas novas, por isso vê-las-emos uma a uma: logo na linha 4, `for i = 1:10000`, porquê um número tão grande? Obviamente era desnecessário, mas teoricamente não sabemos quantos ciclos são necessários para a condição que pusemos se satisfazer, por isso pus um número muito grande para ter a certeza que o ciclo não acaba antes da nossa condição ser satisfeita.

Na linha 8 temos a nossa condição, `if first_term+second_term > 13`. O código entre o `if` e o `end` só é avaliado caso a nossa condição seja verdadeira. O `break` significa apenas que queremos forçar o ciclo *for* a acabar, não interessa se faltam ciclos ou não, obtendo-se assim o mesmo resultado dos anteriores exemplos.


## Vetores

Outra das enormes potencialidades de uma linguagem de programação como *Julia* é a sua capacidade para trabalhar com vetores e matrizes. Continuando com o mesmo exemplo da sequência de fibonacci, não seria melhor, em vez de estarmos sempre a definir valores diferentes para as mesmas variáveis, guardar todos os valores num vetor? Uma sequência pode ser considerada um simples vetor, não? Vamos ver então:

```julia
fib = [0,1] # primeiro e segundo termos da sequência

while sum(fib[end-1:end]) <= 13
    push!(fib,sum(fib[end-1:end]))
end
display(fib)
```

Parece mais estranho, mas é muito mais conciso, para além de mais flexível. Usando vetores conseguimos reduzir o número de linhas de código e guardar os dados da sequência, no caso de precisarmos deles. Vamos então esmiufrar este bocado:

Na linha 1 definimos que a nossa variável `fib` é um vetor já com dois valores. O vetor mais simples é simplesmente `var = []` que define a variável como um vetor com zero entradas. 

Na linha 3, na parte `fib[end-1:end]`, temos uma nova sintaxe, que é o que eu gosto de chamar em português de "fatiação", a minha tradução literal do inglês *slicing*. Claro que esta palavra não existe (ou será que existe??) mas refere-se ao facto de podermos utilizar "fatias" de um vetor e criar outro. O que está dentro dos parênteses retos são índices das entradas do vetor, por exemplo, `fib[1]` dá-nos o valor 0 e fib[2] dá-nos o valor 1. A entrada `end` representa o índice da última entrada do vetor. 

Na linha 4 temos uma nova função, a função `push!`. Esta função serve para adicionarmos elementos a um vetor existente. Se `var = [1,2,3]`, então `push!(var,4)` tem como resultado `[1,2,3,4]`. Sendo assim estamos a somar os dois últimos valores de `fib` e a adicionar o resultado a `fib`.

**NOTA:** Para quem está familiarizado com *MatLab* e/ou *Python*, *Julia* tem uma pequena mas significativa diferença, quando se define um vetor ele vem em modo coluna e não em modo linha. Em *MatLab*, `[1,2,3] == [1 2 3]`, mas em *Julia* é diferente, porque o primeiro é uma coluna e o segundo é uma linha.

Podemos também resolver este problema com um ciclo *for*:

```julia
fib = [0,1]

for i = 1:5
    push!(fib,sum(fib[end-1:end]))
end
display(fib)
```

Usar vetores é uma arma muito poderosa, por isso sempre que possam utilizem, se acharem que for útil, obviamente.


## Funções

Este é o último capítulo antes de passarmos aos scripts, e que capítulo é este... Tudo é feito através de funções, funções são os que nos permitem reutilizar código, escrever algo uma vez e nunca mais precisar tocar nele, simplesmente enviar novos argumentos para dentro dela e ter diferentes respostas.

No último exemplo dado, se eu quisesse experimentar o mesmo código várias vezes, com diferentes números de ciclos, teria de copiar, colar no REPL e mudar `for i = 1:5` para `for i = 1:random_number`, e isso é tedioso e consome demasiado tempo. Se colocássemos esse código numa função seria tudo mais simples! Vamos ver:

```julia
function fibonacci(n)
    fib = [0,1]
    for i = 1:n
        push!( fib , sum( fib[end-1:end] ) )
    end
    return fib
end
```

Aqui temos várias coisas para detalhar:

Na linha 1, em `fibonacci(n)` definimos o nome da função (fibonacci) e o nome dos argumentos necessários passar à função para ela fazer o seu trabalho (neste caso é só necessário um, mas se fossem precisos mais bastava separá-los por vírgulas, por exemplo `function fibonacci(arg1,arg2,arg3) end`)

Na linha 6, a sintaxe `return fib` significa que a função, depois de fazer os cálculos, vai-nos devolver o vetor `fib`.

Neste caso, se quisermos fazer cinco cálculos, como nos exemplos anteriores, basta escrever no REPL `fibonacci(5)` e o mesmo resultado aparecer-vos-á.

Até agora nós temos descartado os primeiros dois valores da sequência, por exemplo, se queremos determinar cinco valores, na realidade estamos a determinar sete, visto que os dois primeiros são dados. Imaginando que o nosso objetivo é obter exatamente cinco valores da sequência, temos de alterar o exemplo anterior:

```julia
function fibonacci(n)
    fib = [0,1]
    if n == 1
        return fib[1]
    elseif n == 2
        return fib
    else
        for i = 1:n-2
            push!( fib , sum(fib[end-1:end]) )
        end
        return fib
    end
end
```

Esta já é uma função mais complexa, onde está implementado tudo o que demos até agora, ciclos, condições, vetores e funções.
