#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Carrega as ferramentas de uso geral
. "${PWD}/make/makeEnvironment.sh"
. "${PWD}/Shell-Make/assets/standalone.sh"
. "${PWD}/Shell-Make/assets/makeTools.sh"










#
# Permite evocar uma função deste script a partir de um argumento passado ao chamá-lo.
$*
