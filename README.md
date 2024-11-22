# Compilador Ruby 
### IFMA - Instituto Federal do Maranhão
### Professor: Varley Santos de Sá
### Alunos:
 - <a href="https://github.com/Pucapuka">Paulo Anderson Gonçalves de Lima</a>
 - <a href="https://github.com/AngCarlos-2">Ângelo Carlos</a>
 - <a href="https://github.com/Araujomann">Lucas Araújo</a> 
 - <a href="">Ester Miriã</a>
 ----
## Como executar
### Dependências
 - Flex - Para compilar o arquivo Lex
 - Bison - Para compilar o arquivo Yacc
 - Gcc - Compilador C para criação do Parser

#### Instalação Ubuntu
 ```
sudo apt update && sudo apt upgrade
sudo apt install flex
sudo apt install bison
flex --version
bison --version
```
#### Instalação MacOS
```
brew update
brew install flex
brew install bison
flex --version
bison --version
```
---
### Executando
#### Automaticamente
```
make (para construção dos componentes)
make clean (para a remoção dos componentes construídos com o make)
```
#### Manualmente
##### 1. Gera o arquvio lex.yy.c a partir do grammar.l
```
flex ./compiler/grammar.l 
```
##### 2. Gera os arquivos grammar.tab.c e grammar.tab.h a partir do grammar.y
```
bison -d ./compiler/grammar.y
```
##### 3. Cria o parser a partir dos arquivos gerados
###### Para MacOS
```
gcc -o cruby grammar.tab.c lex.yy.c -ll
```
###### Para Linux
```
gcc -o cruby grammar.tab.c lex.yy.c -lfl
```
##### 4. Executa o parser, passando um arquivo para análise
```
./cruby < ./samples/<nome do arquivo>.rb
```
------
### Obrigado! Dê estrelinha ⭐️ e manda o pix, em caso de dúvidas, pede pro <a href="https://chatgpt.com">GPT kkkkk</a> 