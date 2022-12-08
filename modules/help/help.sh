#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







unset tmpModTitle
unset tmpMacroInfo
declare -a tmpMacroInfo=()


tmpModTitle="Help"

tmpMacroInfo+=("@macro")
tmpMacroInfo+=("help")
tmpMacroInfo+=("Mostra esta ajuda.")
tmpMacroInfo+=("@param")
tmpMacroInfo+=("module=string")

local tmpStrModuleNames="'"
tmpStrModuleNames+=$(mse_str_join "', '" "arrModuleNames")
tmpStrModuleNames+="'"
tmpMacroInfo+=("Opções: ${tmpStrModuleNames}")

tmpMacroInfo+=("Se vazio ou não definido, mostrará o help de todos os módulos.")