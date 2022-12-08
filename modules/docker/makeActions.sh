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
# Verifica se o container alvo existe
#
# @param string $1
#       Nome do container que será verificado.
#
# @param bool $2
#       Controla o retorno da função.
#       Se omitido ou "0", retornará um valor booleano.
#       Se "1" retornará uma mensagem amigável.
#
# @return
#       Se "$2" = "0" | ""
#       Retornará "1" caso a verificação tenha sido bem sucedida e "0"
#       em caso contrário.
#       Se "$2" = "1"
#       Retornará uma mensagem amigável.
checkIfContainerExists() {
  local tmpResult=""
  if [ "${1}" != "" ]; then
    tmpResult=$(docker ps -q -f name="${1}")
  fi


  if [ "$2" == "1" ]; then
    if [ "${tmpResult}" == "" ]; then
      mse_inter_showAlert "f" "O container não existe ou não está ativo."
    else
      mse_inter_showAlert "s" "O container existe e está ativo."
    fi
  else
    if [ "${tmpResult}" == "" ]; then
      echo "0"
    else
      echo "1"
    fi
  fi
}










#
# Permite evocar uma função deste script a partir de um argumento passado ao chamá-lo.
$*
