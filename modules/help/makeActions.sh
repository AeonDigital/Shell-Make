#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Carrega as ferramentas de uso geral
. "${PWD}/.env"
. "${PWD}/make/makeEnvironment.sh"
. "${PWD}/Shell-Make/assets/standalone.sh"
. "${PWD}/Shell-Make/assets/makeTools.sh"





#
# Mostra um help inicial para o usuário
makeHelp() {
  local tmpModule="${module,,}"
  local tmpMsgTitle="Comandos disponíveis"
  declare -a arrMessage=()
  declare -a arrModuleNames=()


  local tmpPathToModules=$(find ${PWD}/Shell-Make/modules/* -type d)
  local tmpModulePath=""
  local tmpModuleName=""
  local tmpShowHelp="1"

  while read tmpModulePath; do
    tmpModuleName="$(basename -- ${tmpModulePath})"

    if [ "${tmpModuleName}" != "help" ]; then
      if [ "${tmpModule}" == "" ] || [ "${tmpModule}" == "${tmpModuleName}" ]; then
        makeHelpModuleInfo "${tmpModuleName}"
        tmpShowHelp="0"
      fi

      arrModuleNames+=("${tmpModuleName}")
    fi

  done <<< ${tmpPathToModules}


  if [ "${tmpShowHelp}" == "1" ]; then
    makeHelpModuleInfo "help"
  fi

  mse_inter_showAlert "a" "${tmpMsgTitle}" "arrMessage"
}



#
# Carrega os dados de ajuda de um módulo e monta as informações
# de forma amigável.
makeHelpModuleInfo() {
  if [ -f "${PWD}/Shell-Make/modules/${1}/help.sh" ]; then
    . "${PWD}/Shell-Make/modules/${1}/help.sh"

    arrMessage+=("${mseNONE}:: ${mseBLUE}${tmpModTitle}${mseNONE}")
    arrMessage+=("")

    local tmpDataType=""
    local tmpGetLine="0"

    local tmpAtualMacro=""
    local tmpAtualParamName=""
    local tmpAtualParamType=""


    for tmpData in "${tmpMacroInfo[@]}"; do

      case "${tmpData}" in
        "@macro")
          tmpDataType="macro"
          tmpGetLine="0"
        ;;
        "@desc")
          tmpDataType="desc"
          tmpGetLine="0"
        ;;
        "@param")
          tmpDataType="param"
          tmpGetLine="0"
        ;;
        *)
          tmpGetLine="1"
        ;;
      esac


      if [ "${tmpGetLine}" == "1" ]; then
        case "${tmpDataType}" in
          "macro")
            if [ "${tmpAtualMacro}" != "" ] && [ "${tmpAtualMacro}" != "${tmpData}" ]; then
              arrMessage+=("")
            fi

            tmpAtualMacro="${tmpData}"
            arrMessage+=("${mseNONE}- ${mseYELLOW}${tmpAtualMacro}${mseNONE}")
            tmpDataType="desc"
          ;;
          "desc")
            arrMessage+=("${mseNONE}  ${tmpData}")
          ;;
          "param")
            arrMessage+=("${mseNONE}  └ ${mseDCYAN}@param${mseNONE} ${tmpData}")
            tmpDataType="param-desc"
          ;;
          "param-desc")
            arrMessage+=("${mseNONE}    ${tmpData}")
          ;;
        esac
      fi
    done


    arrMessage+=("")
    arrMessage+=("")
  fi
}










#
# Permite evocar uma função deste script a partir de um argumento passado ao chamá-lo.
$*