Shell-Make
===========

> [Aeon Digital](http://www.aeondigital.com.br)
>
> rianna@aeondigital.com.br

&nbsp;

Traz uma coleção de módulos de comandos ``Make`` contendo um ferramental de auxilio para desenvolvedores.


&nbsp;
&nbsp;


________________________________________________________________________________________________________________________

## Instalação

Instale em seu projeto como um submódulo git:

```shell
  git submodule add "https://github.com/AeonDigital/Shell-Make.git"
  git submodule set-branch --branch main -- "Shell-Make"

  # Cria um diretório 'make' na raiz do seu projeto contendo arquivos de scripts
  # e variáveis que permitem a configuração e personalização para os comandos
  # aqui definidos.
  mkdir -p make
  cp Shell-Make/templates/makeActions.sh make/makeActions.sh 
  cp Shell-Make/templates/makeEnvironment.sh make/makeEnvironment.sh 

  # Se o seu projeto não possui um arquivo '.env' na raiz, use o comando abaixo.
  cp Shell-Make/templates/.env .env 

  # Se já possui este arquivo, use o template fornecido em 'Shell-Make/templates/.env' 
  # como base para adicionar as variáveis de ambientes ali definidas.
```

&nbsp;

Crie/edite o ``Makefile`` na raiz do seu projeto adicionando o seguinte:

```Makefile
  include .env
  include Shell-Make/Makefile
```

&nbsp;
&nbsp;


________________________________________________________________________________________________________________________

## Atualização

De tempos em tempos este projeto pode ser atualizado. Para que sua versão corresponda ao mais recente use:

```shell
  git submodule update --remote
```


&nbsp;
&nbsp;


________________________________________________________________________________________________________________________

## Ativação em um projeto clonado

Se um projeto que você clonou já possui este como um submódulo, para ativá-lo é preciso rodar os comandos abaixo:

```shell
  git submodule init
  git submodule update --remote
```


&nbsp;
&nbsp;


________________________________________________________________________________________________________________________

## Licença

Este software está licenciado sob a [Licença MIT](LICENSE).
