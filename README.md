# SOP

Neste repositório situa-se todo o material utilizado nas aulas de SOP. 

O repositório está separado nas linguagens de programação dadas. Cada linguagem tem duas pastas: a pasta `docs` (de documentação) e a pasta `probs` (de problemas). A pasta `probs` está dividida em pastas cujos nomes são iguais às folhas de exercícios. Dentro dessas pastas estão algumas resoluções dos exercícios, dependendo do objetivo desses exercícios.

Nós decidimos utilizar o Github porque, com alguma prática, é muito mais cómodo e simples que utilizar o Clip (e rápido). Há duas maneiras de utilizar o Github:


## Descarregar a pasta em modo zip

Quando entram na [página Github](https://github.com/tpdsantos/SOP), encontram uma caixa verde do lado direito a dizer *Clone or Download*. Ao clicarem nessa caixa, aparece-vos a hipótese *Download ZIP* que vos permite descarregar o repositório inteiro. A vantagem é que é simples e não necessitam de criar uma conta no Github. A desvantagem é que, se houver atualizações, vocês, ou descarregam novamente a pasta na totalidade, ou descobrem o que há de novo e descarregam os ficheiros individualmente.


## Descarregar o cliente *Git*

O cliente [Git](https://git-scm.com/downloads) é a ferramenta mais utlizada no mundo do Github. Permite-nos criar cópias remotas dos repositórios que queremos seguir e mantê-los sempre atualizados. O seu potencial é maximizado quando se utilza a linha de comandos, mas como queremos fazer coisas muito simples não será necessário, utilizaremos apenas a interface gráfica. 

Depois de descarregar e instalar:

1. procurar no vosso sistema por `git cmd` e abrir o executável
2. configurar git com um nome qualquer `git config --global user.name "Your Name"`
3. configurar git com um email qualquer `git config --global user.email "your@email.com"`
4. escolher diretório onde copiar o repositório. Caso seja no ambiente de trabalho\*, `cd ~/Desktop/`
5. escrever `git clone https://github.com/tpdsantos/SOP.git`
6. escrever `git pull origin master`

\* - o símbolo `~` representa o diretório do utilizador. Em Windows é `C:/Users/username/`, MacOs é `/Users/username/` e em Linux é `/home/username/`.

Depois de fazer isto uma vez, sempre que quiserem aceder à pasta e atualizá-la basta fazerem os passos 1, 4 e 6.

Provavelmente, de uns anos para os outros, ficará cada vez mais estável e provavelmente será aconselhável utilizar o modo zip, mas por enquanto é melhor utilizar o cliente *Git* para terem a certeza que nunca vos falta nada.
