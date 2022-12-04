#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Carrega as ferramentas de uso geral
. "${PWD}/make/makeEnvironment.sh"
. "${PWD}/Shell-Make/assets/standalone.sh"
. "${PWD}/Shell-Make/assets/makeTools.sh"





#
# Entra no bash do container principal do projeto
#
# Informe um parametro 'cont' para indicar em qual container deseja entrar.
#   Valores aceitos são: web|db
#   Se nenhum valor for informado, entrará no 'web'
openContainerBash() {
  if [ -z ${cont+x} ]; then
    cont="web";
  fi;

  if [ "${cont}" == "web" ]; then
    docker exec -it ${CONTAINER_WEBSERVER_NAME} /bin/bash;
  elif [ "${cont}" == "db" ]; then
    docker exec -it ${CONTAINER_DBSERVER_NAME} /bin/bash;
  else
    mse_inter_showAlert "f" "Parametro cont=\"${cont}\" inválido; use \"web\" ou \"db\"."
  fi;
}





#
# Retorna o IP da rede usado pelos containers
getContainersIP() {
  local tmpIP=""
  local tmpMsgTitle="IP dos Containers"
  declare -a arrMessage=()


  if [ "${CONTAINER_WEBSERVER_NAME}" != "" ]; then
    tmpIP=$(docker inspect ${CONTAINER_WEBSERVER_NAME} | grep -oP -m1 '(?<="IPAddress": ")[a-f0-9.:]+')
    arrMessage+=("Web-Server : ${tmpIP}")
  fi
  if [ "${CONTAINER_DBSERVER_NAME}" != "" ]; then
    tmpIP=$(docker inspect ${CONTAINER_DBSERVER_NAME} | grep -oP -m1 '(?<="IPAddress": ")[a-f0-9.:]+')
    arrMessage+=("DB-Server  : ${tmpIP}")
  fi

  mse_inter_showAlert "a" "${tmpMsgTitle}" "arrMessage"
}




#
# Mostra um help inicial para o usuário
makeHelp() {
  local tmpModule="${module,,}"
  local tmpMsgTitle="Comandos disponíveis"
  declare -a arrMessage=()


  if [ "${tmpModule}" == "" ] || [ "${tmpModule}" == "docker" ]; then
    arrMessage+=("${mseNONE}:: ${mseBLUE}Docker${mseNONE}")
    arrMessage+=("${mseNONE}- ${mseYELLOW}up${mseNONE}      : Inicia os containers do projeto baseado no 'docker-compose'.")
    arrMessage+=("${mseNONE}- ${mseYELLOW}stop${mseNONE}    : Desativa os containers do projeto e os mantem inativos para futuro uso.")
    arrMessage+=("${mseNONE}- ${mseYELLOW}start ${mseNONE}  : Reativa os containers do projeto.")
    arrMessage+=("${mseNONE}- ${mseYELLOW}down${mseNONE}    : Encerra os containers do projeto e remove os containers e componentes.")
    arrMessage+=("")
    arrMessage+=("${mseNONE}- ${mseYELLOW}bash${mseNONE}    : Entra no bash do container principal do projeto.")
    arrMessage+=("${mseNONE}- ${mseYELLOW}get-ip${mseNONE}  : Retorna o IP da rede usado pelos containers.")
    arrMessage+=("")
    arrMessage+=("${mseNONE}- ${mseYELLOW}php-composer-install${mseNONE}  : Instala as dependências do projeto usando o 'php composer'.")
    arrMessage+=("${mseNONE}- ${mseYELLOW}php-composer-update${mseNONE}   : Atualiza as dependências do projeto usando o 'php composer'.")

    arrMessage+=("")
    arrMessage+=("")
  fi


  if [ "${tmpModule}" == "" ] || [ "${tmpModule}" == "git" ]; then
    arrMessage+=("${mseNONE}:: ${mseBLUE}Git${mseNONE}")
    arrMessage+=("${mseNONE}- ${mseYELLOW}git-config-local${mseNONE}  : Configura suas credenciais para o repositório atual.")
    arrMessage+=("")
    arrMessage+=("${mseNONE}- ${mseYELLOW}log${mseNONE} : Mostra log resumido do git.")
    arrMessage+=("${mseNONE}  └ ${mseDCYAN}@param${mseNONE} len=int")
    arrMessage+=("${mseNONE}    Opcional; Número de itens de log a serem mostrados.")
    arrMessage+=("")
    arrMessage+=("${mseNONE}- ${mseYELLOW}task-start${mseNONE}        : Inicia uma nova tarefa (branch).")
    arrMessage+=("${mseNONE}  └ ${mseDCYAN}@param${mseNONE} type=string")
    arrMessage+=("${mseNONE}    Opções: 'a|architecture' | 'r|refactory' | 'f|feature' | 'i|improvement'")
    arrMessage+=("${mseNONE}            'm|maintenance'  | 'b|bugfix'    | 'h|hotfix'")
    arrMessage+=("${mseNONE}  └ ${mseDCYAN}@param${mseNONE} id=int")
    arrMessage+=("${mseNONE}    Código único que identifica esta tarefa.")
    arrMessage+=("${mseNONE}  └ ${mseDCYAN}@param${mseNONE} name=string")
    arrMessage+=("${mseNONE}    Nome identificador da tarefa/branch.")
    arrMessage+=("")
    arrMessage+=("${mseNONE}- ${mseYELLOW}task-commit${mseNONE}       : Efetua um commit incremental para a tarefa/branch atual.")
    arrMessage+=("${mseNONE}  └ ${mseDCYAN}@param${mseNONE} prefix=string")
    arrMessage+=("${mseNONE}    Opções: 'w|wip|work-in-progress' | 'v|view'   | 'c|ctrl|controller'   | 'm|model'")
    arrMessage+=("${mseNONE}            'd|db|database'          | 'f|format' | 'p|perf|performance'  | 'r|refactor'")
    arrMessage+=("${mseNONE}            'a|aux|auxiliar'         | 't|test'   | 'd|doc|documentation' | 'x|fix'")
    arrMessage+=("")
    arrMessage+=("${mseNONE}- ${mseYELLOW}task-push${mseNONE}         : Efetua o 'push' dos commits locais para o repositório remoto.")
    arrMessage+=("")
    arrMessage+=("${mseNONE}- ${mseYELLOW}task-finish${mseNONE}       : Finaliza a tarefa entregando o resultado da tarefa no servidor remoto.")
    arrMessage+=("")
    arrMessage+=("${mseNONE}- ${mseYELLOW}tag${mseNONE}               : Mostra qual a tag atual do projeto.")
    arrMessage+=("${mseNONE}- ${mseYELLOW}tag-remark${mseNONE}        : Redefine a tag atualmente vigente para o commit mais recente.")
    arrMessage+=("${mseNONE}- ${mseYELLOW}tag-update${mseNONE}        : Atualiza o 'patch' da tag atualmente definida para a branch principal 'main'.")
    arrMessage+=("${mseNONE}- ${mseYELLOW}tag-update-minor${mseNONE}  : Atualiza o 'minor version' da tag atualmente definida para a branch principal 'main'.")
    arrMessage+=("${mseNONE}- ${mseYELLOW}tag-update-major${mseNONE}  : Atualiza o 'major version' da tag atualmente definida para a branch principal 'main'.")
    arrMessage+=("${mseNONE}- ${mseYELLOW}tag-stability${mseNONE}     : Atualiza a 'stability' da tag atualmente definida para a branch principal 'main'.")
    arrMessage+=("${mseNONE}  └ ${mseDCYAN}@param${mseNONE} stability=string")
    arrMessage+=("${mseNONE}    Opções: 'alpha' | 'beta' | 'cr' | 'r'")

    arrMessage+=("")
    arrMessage+=("")
  fi


  if [ "${tmpModule}" == "" ] || [ "${tmpModule}" == "database" ]; then
    arrMessage+=("${mseNONE}:: ${mseBLUE}Database${mseNONE}")
    arrMessage+=("${mseNONE}- ${mseYELLOW}db-check${mseNONE}  : Executa todas as verificações definidas para o banco de dados.")
    arrMessage+=("${mseNONE}              Os testes executados são: db-check-ping db-check-network db-check-credentials")
    arrMessage+=("")
    arrMessage+=("${mseNONE}- ${mseYELLOW}db-show-characterset${mseNONE}  : Mostra as configurações de 'character-set' atualmente definida.")
    arrMessage+=("${mseNONE}- ${mseYELLOW}db-show-collation${mseNONE}     : Mostra as configurações de 'collation' atualmente definida.")
    arrMessage+=("")
    arrMessage+=("${mseNONE}- ${mseYELLOW}db-clean${mseNONE}      : Remove totalmente o banco de dados da aplicação.")
    arrMessage+=("${mseNONE}- ${mseYELLOW}db-start${mseNONE}      : Inicia um novo banco de dados para a aplicação.")
    arrMessage+=("${mseNONE}- ${mseYELLOW}db-export${mseNONE}     : Exporta o backup do banco de dados da aplicação.")
    arrMessage+=("${mseNONE}- ${mseYELLOW}db-bootstrap${mseNONE}  : Exporta o backup do banco de dados da aplicação e substitui o atual arquivo bootstrap.")
    arrMessage+=("${mseNONE}- ${mseYELLOW}db-patch${mseNONE}      : Executa um patch de correção ou atualização para o banco de dados.")
    arrMessage+=("${mseNONE}  └ ${mseDCYAN}@param${mseNONE} file=path")
    arrMessage+=("${mseNONE}    Arquivo de patch a ser usado")
    arrMessage+=("${mseNONE}    Informe um caminho relativo a partir de '/etc/database/patch/'")

    arrMessage+=("")
    arrMessage+=("")
  fi


  if [ "${tmpModule}" == "" ] || [ "${tmpModule}" == "tests" ]; then
    arrMessage+=("${mseNONE}:: ${mseBLUE}Tests${mseNONE}")
    arrMessage+=("${mseNONE}- ${mseYELLOW}test${mseNONE} : Executa a bateria de testes unitários.")
    arrMessage+=("${mseNONE}  └ ${mseDCYAN}@param${mseNONE} file=path")
    arrMessage+=("${mseNONE}    Opcional; Arquivo de testes a ser executado de forma individual;")
    arrMessage+=("${mseNONE}    Informe um caminho relativo a partir de '/tests/src'")
    arrMessage+=("${mseNONE}  └ ${mseDCYAN}@param${mseNONE} method=name")
    arrMessage+=("${mseNONE}    Opcional; Nome do método de teste do arquivo alvo que será testado individualmente;")

    arrMessage+=("")
    arrMessage+=("")
  fi


  arrMessage+=("${mseNONE}:: ${mseBLUE}Help${mseNONE}")
  arrMessage+=("${mseNONE}- ${mseYELLOW}help${mseNONE} : Mostra esta ajuda.")
  arrMessage+=("${mseNONE}  └ ${mseDCYAN}@param${mseNONE} module=string")
  arrMessage+=("${mseNONE}    Opções: 'docker' | 'git' | 'database' | 'tests'")
  arrMessage+=("${mseNONE}    Se vazio ou não definido, mostrará o help de todos os módulos.")


  mse_inter_showAlert "a" "${tmpMsgTitle}" "arrMessage"
}





#
# Permite evocar uma função deste script a partir de um argumento passado ao chamá-lo.
$*
