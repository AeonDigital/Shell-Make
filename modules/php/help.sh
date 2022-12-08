#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







unset tmpModTitle
unset tmpMacroInfo
declare -a tmpMacroInfo=()


tmpModTitle="PHP"

tmpMacroInfo+=("@macro")
tmpMacroInfo+=("php-info")
tmpMacroInfo+=("Printa na tela o resultado do comando 'php -i'.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("php-composer-install")
tmpMacroInfo+=("Instala as dependências do projeto usando o 'php composer'.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("php-composer-update")
tmpMacroInfo+=("Atualiza as dependências do projeto usando o 'php composer'.")