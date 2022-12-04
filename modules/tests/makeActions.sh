#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Carrega as ferramentas de uso geral
. "${PWD}/make/makeEnvironment.sh"
. "${PWD}/Shell-Make/assets/standalone.sh"
. "${PWD}/Shell-Make/assets/makeTools.sh"





#
# Executa a bateria de testes
#
# Opcionais
# Use o parametro 'file' para indicar que os testes devem percorrer apenas
# os testes do arquivo especificado.
# Use o parametro 'method' (em adição ao parametro 'file') para indicar que
# apenas este método do referido arquivo deve ser executado.
#
# > make test
# > make test file="path/to/tgtFile.php"
# > make test file="path/to/tgtFile.php" method="tgtMethodName"
performUnitTests() {
  if [ -z ${file+x} ]; then
    docker exec -it ${CONTAINER_WEBSERVER_NAME} vendor/bin/phpunit --configuration "tests/phpunit.xml" --colors=always --verbose --debug
  else
    if [ -z ${method+x} ]; then
      docker exec -it ${CONTAINER_WEBSERVER_NAME} vendor/bin/phpunit "tests/src/${file}" --colors=always --verbose --debug
    else
      docker exec -it ${CONTAINER_WEBSERVER_NAME} vendor/bin/phpunit --filter "::${method}\$" "tests/src/${file}" --colors=always --verbose --debug
    fi;
  fi;
}





#
# Executa a verificação total de cobertura dos testes unitários
#
# Opcionais
# Use o parametro 'file' para efetuar o teste de cobertura sobre apenas 1
# classe de testes.
#
# Use o parametro 'output' para selecionar o tipo de saida que o teste de
# cobertura deve ter. As opções são:
#  - 'text' (padrão) : printa o resultado na tela.
#  - 'html' : Monta a saída dos testes em formato HTML.
#
# > make test-cover
# > make test-cover file="path/to/tgtFile.php"
# > make test-cover output="html"
# > make test-cover file="path/to/tgtFile.php" output="html"
performUnitCoverTests() {
  if [ -z ${file+x} ] && [ -z ${output+x} ]; then
    docker exec -it ${CONTAINER_WEBSERVER_NAME} vendor/bin/phpunit --configuration "tests/phpunit.xml" --colors=always --coverage-text
  else
    if [ -z ${file+x} ]; then
      if [ -z ${output+x} ] || [ ${output} == "text" ]; then
        docker exec -it ${CONTAINER_WEBSERVER_NAME} vendor/bin/phpunit --configuration "tests/phpunit.xml" --colors=always --coverage-text
      elif [ "${output}" == "html" ]; then
        docker exec -it ${CONTAINER_WEBSERVER_NAME} vendor/bin/phpunit --configuration "tests/phpunit.xml" --colors=always --coverage-html "tests/cover"
      else
        mse_inter_showAlert "f" "Parametro 'output' inválido. Use apenas 'text' ou 'html'."
      fi;
    else
      if [ -z ${output+x} ] || [ ${output} == "text" ]; then
        docker exec -it ${CONTAINER_WEBSERVER_NAME} vendor/bin/phpunit "tests/src/${file}" --whitelist="tests/src/${file}" --colors=always --coverage-text
      elif [ "${output}" == "html" ]; then
        docker exec -it ${CONTAINER_WEBSERVER_NAME} vendor/bin/phpunit "tests/src/${file}" --whitelist="tests/src/${file}" --coverage-html "tests/cover-file"
      else
        mse_inter_showAlert "f" "Parametro 'output' inválido. Use apenas 'text' ou 'html'."
      fi;
    fi;
  fi;
}










#
# Permite evocar uma função deste script a partir de um argumento passado ao chamá-lo.
$*
