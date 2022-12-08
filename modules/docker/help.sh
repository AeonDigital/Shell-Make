#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







unset tmpModTitle
unset tmpMacroInfo
declare -a tmpMacroInfo=()


tmpModTitle="Docker"

tmpMacroInfo+=("@macro")
tmpMacroInfo+=("up")
tmpMacroInfo+=("Inicia os containers do projeto baseado no 'docker-compose'.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("stop")
tmpMacroInfo+=("Desativa os containers do projeto e os mantem inativos para futuro uso.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("start")
tmpMacroInfo+=("Reativa os containers do projeto.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("down")
tmpMacroInfo+=("Encerra os containers do projeto e remove os containers e componentes.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("bash")
tmpMacroInfo+=("Entra no bash do container principal do projeto.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("get-ip")
tmpMacroInfo+=("Retorna o IP da rede usado pelos containers.")