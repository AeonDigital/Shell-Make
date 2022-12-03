#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Carrega as ferramentas de uso geral
. "${PWD}/make/makeEnvironment.sh"
. "${PWD}/Shell-Make/assets/standalone.sh"
. "${PWD}/Shell-Make/assets/makeTools.sh"





#
# Mostra log resumido do git
# Use o parametro 'len' para indicar a quantidade de itens a serem mostrados.
gitShowLog() {
  if [ -z ${len+x} ]; then
    len="${MK_GIT_LOG_LENGTH}"
  fi

  git log -${len} --pretty='format:%h | %ad | %s' --date=format:'%d %B | %H:%M'
}




#
# Configura o repositório para armazenar localmente as credenciais do git.
gitConfigLocal() {
  local tmpMsgTitle=""

  if [ ! -d .git ]; then
    tmpMsgTitle="FALHA"
    declare -a arrMessage=()
    arrMessage+=("O diretório atual não é um repositório Git.")
    arrMessage+=("Ação abortada")

    mse_inter_showAlert "f" "${tmpMsgTitle}" "arrMessage"
  else
    tmpMsgTitle="ATENÇÃO"
    declare -a arrMessage=()
    arrMessage+=("Iniciando configuração \"local\" para este repositório.")
    arrMessage+=("As configurações locais atualmente definidas serão perdidas.")

    mse_inter_showAlert "a" "${tmpMsgTitle}" "arrMessage"

    mse_inter_showPrompt "" "ca" "Você confirma esta ação?" "bool"
    if [ "$MSE_GLOBAL_PROMPT_RESULT" == "1" ]; then
      local mseGitCredentialsUsePath="~/.gitcredentials"
      if [ "${XDG_CONFIG_HOME}" != "" ]; then
        mseGitCredentialsUsePath="${XDG_CONFIG_HOME}/git/credentials"
      fi
      mkdir -p "${mseGitCredentialsUsePath}"
      chmod 700 "${mseGitCredentialsUsePath}"


      if [ ! -d "${mseGitCredentialsUsePath}" ]; then
        tmpMsgTitle="FALHA"
        declare -a arrMessage=()
        arrMessage+=("Não foi possível criar o diretório \"${mseGitCredentialsUsePath}\".")
        arrMessage+=("Ação abortada")

        mse_inter_showAlert "f" "${tmpMsgTitle}" "arrMessage"
      else
        local tmpISOK="1";
        local tmpRepo="${PWD##*/}";
        local tmpEmail=$(git config --global --get user.email);
        local tmpName=$(git config --global --get user.name);
        local tmpNick=$(git config --global --get user.nick);

        if [ "${tmpNick}" == "" ]; then
          tmpNick="${tmpEmail%@*}"
        fi


        if [ "${tmpEmail}" != "" ] && [ "${tmpName}" != "" ]; then
          tmpMsgTitle="ATENÇÃO"
          declare -a arrMessage=()
          arrMessage+=("As seguintes configurações serão usadas:")
          arrMessage+=("Repositório: \"${tmpRepo}\"")
          arrMessage+=("Email      : git config --local user.email \"${tmpEmail}\"")
          arrMessage+=("Nome       : git config --local user.name \"${tmpName}\"")
          arrMessage+=("Nick       : git config --local user.nick \"${tmpNick}\"")
          arrMessage+=("")
          arrMessage+=("Se escolher 'não' você poderá definir cada um dos itens acima.")
          arrMessage+=("")
          arrMessage+=("Obs: O 'Nick' será usado para constituir o nome das branchs.")

          mse_inter_showAlert "a" "${tmpMsgTitle}" "arrMessage"
          mse_inter_showPrompt "" "ca" "Você deseja usar as configurações padrões?" "bool"
        else
          MSE_GLOBAL_PROMPT_RESULT="0"
        fi

        if [ "$MSE_GLOBAL_PROMPT_RESULT" == "0" ]; then
          if [ "${tmpISOK}" == "1" ]; then
            declare -a arrMessage=()
            mse_inter_showPrompt "" "ca" "Informe o nome do repositório: " "value" "arrMessage"
            if [ "$MSE_GLOBAL_PROMPT_RESULT" == "" ]; then
              tmpISOK="0"

              tmpMsgTitle="FALHA"
              declare -a arrMessage=()
              arrMessage+=("Este valor não pode ficar vazio.")
              arrMessage+=("Ação abortada")

              mse_inter_showAlert "f" "${tmpMsgTitle}" "arrMessage"
            else
              tmpRepo="$MSE_GLOBAL_PROMPT_RESULT"
            fi
          fi


          if [ "${tmpISOK}" == "1" ]; then
            mse_inter_showPrompt "" "ca" "Informe o \"email\" do seu usuário: " "value"
            if [ "$MSE_GLOBAL_PROMPT_RESULT" == "" ]; then
              tmpISOK="0"

              tmpMsgTitle="FALHA"
              declare -a arrMessage=()
              arrMessage+=("Este valor não pode ficar vazio.")
              arrMessage+=("Ação abortada")

              mse_inter_showAlert "f" "${tmpMsgTitle}" "arrMessage"
            else
              tmpEmail="$MSE_GLOBAL_PROMPT_RESULT"
            fi
          fi


          if [ "${tmpISOK}" == "1" ]; then
            mse_inter_showPrompt "" "ca" "Informe o seu \"nome\" de usuário: " "value"
            if [ "$MSE_GLOBAL_PROMPT_RESULT" == "" ]; then
              tmpISOK="0"

              tmpMsgTitle="FALHA"
              declare -a arrMessage=()
              arrMessage+=("Este valor não pode ficar vazio.")
              arrMessage+=("Ação abortada")

              mse_inter_showAlert "f" "${tmpMsgTitle}" "arrMessage"
            else
              tmpName="$MSE_GLOBAL_PROMPT_RESULT"
            fi
          fi


          if [ "${tmpISOK}" == "1" ]; then
            mse_inter_showPrompt "" "ca" "Informe o \"nick\" do seu usuário: " "value"
            if [ "$MSE_GLOBAL_PROMPT_RESULT" == "" ]; then
              tmpISOK="0"

              tmpMsgTitle="FALHA"
              declare -a arrMessage=()
              arrMessage+=("Este valor não pode ficar vazio.")
              arrMessage+=("Ação abortada")

              mse_inter_showAlert "f" "${tmpMsgTitle}" "arrMessage"
            else
              tmpNick="$MSE_GLOBAL_PROMPT_RESULT"
            fi
          fi
        fi


        if [ "${tmpISOK}" == "1" ]; then
          git config --local user.email "${tmpEmail}"
          git config --local user.name "${tmpName}"
          git config --local user.nick "${tmpNick}"
          git config --local credential.helper "store --file ${mseGitCredentialsUsePath}/${tmpRepo}"

          #
          # Remove arquivo antigo, se existir
          rm -f "${mseGitCredentialsUsePath}/${tmpRepo}"

          tmpMsgTitle="Sucesso"
          declare -a arrMessage=()
          arrMessage+=("Configurações executadas.")
          arrMessage+=("Suas credenciais serão pedidas no próximo pull/push e após serão lidas")
          arrMessage+=("do arquivo de configuração armazenado em ${mseGitCredentialsUsePath}/${tmpRepo}")

          mse_inter_showAlert "s" "${tmpMsgTitle}" "arrMessage"
        fi
      fi
    fi

  fi
}





#
# Gerencia as ações de controle de tags do git para o projeto.
gitTagManagement() {
  GIT_ACTIVE_BRANCH=$(git branch --show-current)



  #
  # Identifica se a branch atual refere-se ao 'main'
  if [ "${GIT_ACTIVE_BRANCH}" != "main" ]; then
    tmpMsgTitle="ATENÇÃO"
    declare -a arrMessage=()
    arrMessage+=("Alterne para a branch principal \"main\".")
    arrMessage+=(":: git checkout main")

    mse_inter_showAlert "a" "${tmpMsgTitle}" "arrMessage"
  else
    #
    # Identifica se existem alterações não comitadas
    if [ $(git status --porcelain | wc -l) -gt "0" ] && [ 1 == 2 ]; then
      tmpMsgTitle="ATENÇÃO"
      declare -a arrMessage=()
      arrMessage+=("Foram encontradas alterações não comitadas.")
      arrMessage+=("Efetue o commit das alterações para prosseguir")
      arrMessage+=(":: git add .")
      arrMessage+=(":: git commit -m \"message\"")
      arrMessage+=(":: git push origin main")

      mse_inter_showAlert "a" "${tmpMsgTitle}" "arrMessage"
    else

      GIT_ATUAL_TAG="0.0.0-alpha"
      if [ "$(git tag)" != "" ]; then
        GIT_ATUAL_TAG=$(git describe --abbrev=0 --tags)
      fi

      TAG_SPLIT=(${GIT_ATUAL_TAG//-/ })
      TAG_RAW_VERSION=(${TAG_SPLIT[0]//[!0-9.]/ })


      VERSION_SPLIT=(${TAG_RAW_VERSION//\./ })

      PROJECT_VERSION_MAJOR=${VERSION_SPLIT[0]}
      PROJECT_VERSION_MINOR=${VERSION_SPLIT[1]}
      PROJECT_VERSION_PATCH=${VERSION_SPLIT[2]}
      PROJECT_VERSION_STABILITY=("-"${TAG_SPLIT[1]})

      PROJECT_ATUAL_VERSION="${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}"

      ISOK=1

      if [ "$1" == "remark" ]; then
        git tag -d "${GIT_ATUAL_TAG}"
        git push --delete origin "${GIT_ATUAL_TAG}"
        git tag "${GIT_ATUAL_TAG}"
        git push --tags origin
      else
        if [ "$1" == "version" ]; then
          if [ "$2" == "patch" ]; then
            PROJECT_VERSION_PATCH=$((PROJECT_VERSION_PATCH+1))
          else
            if [ "$2" == "minor" ]; then
              PROJECT_VERSION_MINOR=$((PROJECT_VERSION_MINOR+1))
              PROJECT_VERSION_PATCH=0
            else
              if [ "$2" == "major" ]; then
                PROJECT_VERSION_MAJOR=$((PROJECT_VERSION_MAJOR+1))
                PROJECT_VERSION_MINOR=0
                PROJECT_VERSION_PATCH=0
              else
                ISOK=0
              fi
            fi
          fi
        elif [ "$1" == "stability" ]; then
          if [ "$2" == "alpha" ] || [ "$2" == "beta" ] || [ "$2" == "cr" ] || [ "$2" == "r" ]; then
            if [ "$2" == "r" ]; then
              PROJECT_VERSION_STABILITY=""
            else
              PROJECT_VERSION_STABILITY="-$2"
            fi
          else
            ISOK=0
          fi
        else
          ISOK=0
        fi



        if [ "${ISOK}" == "0" ]; then
          tmpMsgTitle="FALHA"
          declare -a arrMessage=()
          arrMessage+=("Parametros incorretos: [ ${1}; ${2} ].")
          arrMessage+=("Nenhuma ação foi realizada.")

          mse_inter_showAlert "f" "${tmpMsgTitle}" "arrMessage"
        else
          USE_VERSION="${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}"
          NEW_VERSION="v${USE_VERSION}${PROJECT_VERSION_STABILITY}"

          #
          # Verifica se é necessário atualizar o versionamento da documentação exportada
          CONF="docs/conf.py"
          if [ -f "${CONF}" ]; then
            OLD_SHORT_VERSION="project_short_version = '.*'"
            NEW_SHORT_VERSION="project_short_version = '${USE_VERSION}'"
            sed -i "s/${OLD_SHORT_VERSION}/${NEW_SHORT_VERSION}/" "${CONF}"

            OLD_FULL_VERSION="project_full_version = '.*'"
            NEW_FULL_VERSION="project_full_version = '${NEW_VERSION}'"
            sed -i "s/${OLD_FULL_VERSION}/${NEW_FULL_VERSION}/" "${CONF}"

            if [ $(git status --porcelain | wc -l) -gt "0" ]; then
              git add .
              git commit -m "Atualizado para a versão ${NEW_VERSION}"
              git push origin main
            fi
          fi

          git tag ${NEW_VERSION}
          git push --tags origin
        fi
      fi
    fi
  fi
}





#
# Inicia uma nova branch para a composição de uma tarefa específica.
gitTaskStart() {
  local useType=$(mse_str_trim $(mse_str_toLower "${type}"))
  local useNick=$(mse_str_trim $(git config --local user.nick))
  local useId=$(mse_str_trim $(mse_str_toLower "${id}"))
  local useName="${name}"


  local useTitleMsg=""
  local tmpCheckValue=""
  unset useMsgLines
  declare -a useMsgLines=()


  if [ "${useNick}" == "" ]; then
    useTitleMsg="Nenhum 'nick' de autor foi encontrado."
    useMsgLines+=("${mseNONE}Por favor, execute o comando \"git-config-local\" para configurar")
    useMsgLines+=("${mseNONE}corretamente o seu repositório local.")

    mse_inter_showAlert "e" "${useTitleMsg}" "useMsgLines"
  else

    local tmpAtualBranch=$(git branch --show-current)
    local tmpHasChanges=$(git status --porcelain 2> /dev/null)

    if [ "${tmpHasChanges}" != "" ]; then
      useTitleMsg="Você possui alterações não comitadas na branch atualmente aberta \"${tmpAtualBranch}\'."
      useMsgLines+=("${mseNONE}Faça uma das seguintes ações para prosseguir:")
      useMsgLines+=("${mseNONE}- Comite as alterações")
      useMsgLines+=("${mseNONE}- Descarte as alterações")
      useMsgLines+=("${mseNONE}- Finalize a tarefa da branch atual")

      mse_inter_showAlert "w" "${useTitleMsg}" "useMsgLines"
    else


      #
      # Confere a validade do parametro 'name'
      if [ "${useName}" == "" ]; then
          useTitleMsg="O parametro \"name\" não aceita valores vazios."
          mse_inter_showAlert "e" "${useTitleMsg}"
          useName=""
      else
        if [[ "${useName}" = *[![:ascii:]]* ]]; then
          useTitleMsg="O valor \"${useName=""}\" utiliza caracteres não ascii que não são permitidos para nomes de branchs."
          mse_inter_showAlert "e" "${useTitleMsg}"
          useName=""
        else
          useName=$(mse_str_replace " " "-" "${useName}")
          while [[ "${useName}" == *"--"* ]]; do
            useName=$(mse_str_replace "--" "-" "${useName}")
          done
        fi
      fi


      if [ "${useName}" != "" ]; then
        #
        # Confere a validade do parametro 'type'
        unset usePromptTypes
        declare -A usePromptTypes
        usePromptTypes["a"]="architecture"
        usePromptTypes["r"]="refactory"
        usePromptTypes["f"]="feature"
        usePromptTypes["i"]="improvement"
        usePromptTypes["m"]="maintenance"
        usePromptTypes["b"]="bugfix"
        usePromptTypes["h"]="hotfix"


        if [ "${useType}" != "" ]; then
          local tmpValue=""
          local tmpMatch=0

          for tmpKey in "${!usePromptTypes[@]}"; do
            tmpValue="${usePromptTypes[${tmpKey}]}"

            if [ "${useType}" == "${tmpKey}" ] || [ "${useType}" == "${tmpValue}" ]; then
              useType="${tmpValue}"
              tmpMatch=1
              break
            fi
          done

          if [ "${tmpMatch}" == 0 ]; then
            useTitleMsg="O valor \"${useType}\" é inválido para o parametro \"type\"."
            mse_inter_showAlert "e" "${useTitleMsg}"
            mse_inter_setCursorPosition "top" "1"
            useType=""
          fi
        fi


        if [ "${useType}" == "" ]; then
          useTitleMsg="TYPE::Selecione um dos seguintes valores:"
          mse_inter_showPrompt "" "i" "${useTitleMsg}" "list" "usePromptTypes"
          useType="${usePromptTypes[${MSE_GLOBAL_PROMPT_RESULT}]}"
        fi



        #
        # Confere a validade do parametro 'id'
        if [ "${useId}" == "" ]; then
          useId="auto"
        else
          tmpCheckValue=$(mse_check_isInteger "${useId}")
          if [ "${tmpCheckValue}" == "0" ]; then
            useTitleMsg="O valor \"${useId}\" não é um valor numérico."
            mse_inter_showAlert "e" "${useTitleMsg}"
            useId=""
          fi
        fi



        #
        # Efetivamente cria a nova branch
        if [ "${useType}" != "" ] && [ "${useId}" != "" ] && [ "${useName}" != "" ]; then
          local tmpBranchName="${useType}/${useNick}/${useId}/${useName}"

          useTitleMsg="Confirme a criação da branch \"${tmpBranchName}\""
          mse_inter_showPrompt "" "or" "${useTitleMsg}" "bool"

          if [ "${MSE_GLOBAL_PROMPT_RESULT}" == "1" ]; then
            git checkout "${MK_GIT_DEFAULT_BRANCH}"
            git pull origin "${MK_GIT_DEFAULT_BRANCH}"
            git checkout -b "${tmpBranchName}"
          fi
        fi
      fi
    fi
  fi
}





#
# Inicia uma nova branch para a composição de uma tarefa específica.
gitCommit() {
  local usePrefix=$(mse_str_trim $(mse_str_toLower "${prefix}"))
  local useMessage=$(mse_str_trim "${message}")

  local tmpAtualBranch=$(git branch --show-current)
  local tmpHasChanges=$(git status --porcelain 2> /dev/null)


  if [ "${tmpHasChanges}" == "" ]; then
    useTitleMsg="O repositório não possui alterações para serem commitadas."
    mse_inter_showAlert "e" "${useTitleMsg}"
  else

    local useTitleMsg=""
    unset useMsgLines
    declare -a useMsgLines=()


    unset usePromptPrefix
    declare -A usePromptPrefix
    usePromptPrefix["01"]="w::wip::work-in-progress"
    usePromptPrefix["02"]="v::view"
    usePromptPrefix["03"]="c::ctrl::controller"
    usePromptPrefix["04"]="m::model"
    usePromptPrefix["05"]="db::database"

    usePromptPrefix["06"]="f::format"
    usePromptPrefix["07"]="p::perf::performance"
    usePromptPrefix["08"]="r::refactor"
    usePromptPrefix["09"]="a::aux::auxiliar"

    usePromptPrefix["10"]="t::test"
    usePromptPrefix["11"]="d::doc::documentation"
    usePromptPrefix["12"]="x::fix"


    unset usePrefixMap
    declare -A usePrefixMap
    usePrefixMap["01"]="wip"
    usePrefixMap["02"]="view"
    usePrefixMap["03"]="ctrl"
    usePrefixMap["04"]="model"
    usePrefixMap["05"]="database"

    usePrefixMap["06"]="format"
    usePrefixMap["07"]="perf"
    usePrefixMap["08"]="refactor"
    usePrefixMap["09"]="aux"

    usePrefixMap["10"]="test"
    usePrefixMap["11"]="doc"
    usePrefixMap["12"]="fix"


    if [ "${usePrefix}" != "" ]; then
      local tmpValue=""
      local tmpMatch=0
      local tmpPromptLabel=""


      for tmpKey in "${!usePromptPrefix[@]}"; do
        tmpValue="${usePromptPrefix[${tmpKey}]}"

        mse_str_split "::" "${tmpValue}" "1"
        if [ "${#MSE_GLOBAL_MODULE_SPLIT_RESULT[@]}" -gt "0" ]; then
          for tmpPromptLabel in "${MSE_GLOBAL_MODULE_SPLIT_RESULT[@]}"; do

            if [ "${usePrefix}" == "${tmpKey}" ] || [ "${usePrefix}" == "${tmpPromptLabel}" ]; then
              usePrefix="${tmpKey}"
              tmpMatch=1
              break
            fi
          done
        fi
      done


      if [ "${tmpMatch}" == 0 ]; then
        useTitleMsg="O valor \"${usePrefix}\" é inválido para o parametro \"prefix\"."
        mse_inter_showAlert "e" "${useTitleMsg}"
        mse_inter_setCursorPosition "top" "1"
        usePrefix=""
      fi
    fi


    if [ "${usePrefix}" == "" ]; then
      useTitleMsg="PREFIX::Selecione um dos seguintes valores:"
      mse_inter_showPrompt "" "i" "${useTitleMsg}" "list" "usePromptPrefix"
      usePrefix="${usePrefixMap[${MSE_GLOBAL_PROMPT_RESULT}]}"
    else
      usePrefix="${usePrefixMap[${usePrefix}]}"
    fi





    if [ "${usePrefix}" == "wip" ] && [ "${useMessage}" == "" ]; then
      useMessage=$(date "+%Y-%m-%d %H:%M")
    fi


    if [ "${useMessage}" == "" ]; then
      useTitleMsg="O parametro \"message\" não pode ser vazio para commits com o prefixo \"${usePrefix}\"."
      mse_inter_showAlert "e" "${useTitleMsg}"
      useMessage=""
    fi




    #
    # Efetivamente cria o novo commit e efetua o push do mesmo.
    if [ "${usePrefix}" != "" ] && [ "${useMessage}" != "" ]; then
      local tmpCommitMessage="[ ${usePrefix} ] ${useMessage}"

      useTitleMsg="ATENÇÃO::As seguintes ações serão executadas:"
      useMsgLines+=("${mseNONE}- Todos os arquivos contendo alterações serão movidos para 'stage'.")
      useMsgLines+=("  git add .")
      useMsgLines+=("${mseNONE}- Um novo commit será criado.")
      useMsgLines+=("  git commit -m \"${tmpCommitMessage}\"")

      mse_inter_showAlert "w" "${useTitleMsg}" "useMsgLines"

      useTitleMsg="Você confirma estas ações?"
      mse_inter_showPrompt "" "or" "${useTitleMsg}" "bool"

      if [ "${MSE_GLOBAL_PROMPT_RESULT}" == "1" ]; then
        git add .
        git commit -m "${tmpCommitMessage}"
      fi
    fi
  fi
}





#
# Efetua o push dos commits locais para o repositório remoto.
gitPush() {
  local useNick=$(mse_str_trim $(git config --local user.nick))

  local useTitleMsg=""
  local tmpCheckValue=""
  unset useMsgLines
  declare -a useMsgLines=()


  if [ "${useNick}" == "" ]; then
    useTitleMsg="É preciso configurar localmente suas credenciais para este repositório."
    useMsgLines+=("${mseNONE}Por favor, execute o comando \"git-config-local\" para fazer a configuração.")

    mse_inter_showAlert "e" "${useTitleMsg}" "useMsgLines"
  else
    local tmpAtualBranch=$(git branch --show-current)
    local tmpHasPendingCommits=""

    if [ "${tmpAtualBranch}" == "${MK_GIT_DEFAULT_BRANCH}" ]; then
      tmpHasPendingCommits=$(git log origin/${MK_GIT_DEFAULT_BRANCH}..${MK_GIT_DEFAULT_BRANCH})
    else
      tmpHasPendingCommits=$(git log ${MK_GIT_DEFAULT_BRANCH}..${tmpAtualBranch})
    fi


    if [ "${tmpHasPendingCommits}" == "" ]; then
      useTitleMsg="Não há commits esperando serem comitados para o servidor remoto."
      mse_inter_showAlert "i" "${useTitleMsg}"
    else

      useTitleMsg="ATENÇÃO::As seguintes ações serão executadas:"
      useMsgLines+=("${mseNONE}- Todos os commits locais desta branch serão enviados para o servidor remoto.")
      useMsgLines+=("  git push origin ${tmpAtualBranch}")

      mse_inter_showAlert "w" "${useTitleMsg}" "useMsgLines"

      useTitleMsg="Você confirma esta ação?"
      mse_inter_showPrompt "" "or" "${useTitleMsg}" "bool"

      if [ "${MSE_GLOBAL_PROMPT_RESULT}" == "1" ]; then
        git push origin ${tmpAtualBranch}
      fi
    fi
  fi
}





#
# Finaliza a tarefa entregando o resultado da tarefa no servidor remoto.
gitTaskFinish() {
  local tmpHasChanges=$(git status --porcelain 2> /dev/null)

  local useTitleMsg=""
  local tmpCheckValue=""
  unset useMsgLines
  declare -a useMsgLines=()


  if [ "${tmpHasChanges}" != "" ]; then
    useTitleMsg="Há alterações não comitadas! Commite ou descarte-as para prosseguir."
    mse_inter_showAlert "e" "${useTitleMsg}"
  else
    local tmpAtualBranch=$(git branch --show-current)

    if [ "${tmpAtualBranch}" == "${MK_GIT_DEFAULT_BRANCH}" ]; then
      useTitleMsg="Esta ação não é possível estando na branch principal."
      mse_inter_showAlert "i" "${useTitleMsg}"
    else

      useTitleMsg="ATENÇÃO::As seguintes ações serão executadas:"

      useMsgLines+=("${mseNONE}- Todos os commits não enviados para o servidor remoto serão enviados.")
      useMsgLines+=("  git push origin ${tmpAtualBranch}")
      useMsgLines+=("${mseNONE}- Alterna para a branch principal.")
      useMsgLines+=("  git checkout ${MK_GIT_DEFAULT_BRANCH}")
      useMsgLines+=("${mseNONE}- Resgata todas alterações existentes na branch principal.")
      useMsgLines+=("  git fetch")
      useMsgLines+=("  git pull origin ${MK_GIT_DEFAULT_BRANCH}")
      if [ "${MK_GIT_TASK_FINISH_MERGE}" == "1" ]; then
        useMsgLines+=("${mseNONE}- Promove o merge da tarefa concluída com a branch principal.")
        useMsgLines+=("  git merge main ${tmpAtualBranch} –no-ff")
      fi
      useMsgLines+=("${mseNONE}- Envia todas alterações para a branch principal no servidor remoto.")
      useMsgLines+=("  git push origin ${MK_GIT_DEFAULT_BRANCH}")


      mse_inter_showAlert "w" "${useTitleMsg}" "useMsgLines"

      useTitleMsg="Você confirma estas ações?"
      mse_inter_showPrompt "" "or" "${useTitleMsg}" "bool"

      if [ "${MSE_GLOBAL_PROMPT_RESULT}" == "1" ]; then
        git push origin ${tmpAtualBranch}
        git checkout ${MK_GIT_DEFAULT_BRANCH}
        git fetch
        git pull origin ${MK_GIT_DEFAULT_BRANCH}
        if [ "${MK_GIT_TASK_FINISH_MERGE}" == "1" ]; then
          git merge ${tmpAtualBranch}
        fi
        git push origin ${MK_GIT_DEFAULT_BRANCH}
      fi
    fi

  fi
}


















#
# Permite evocar uma função deste script a partir de um argumento passado ao chamá-lo.
$*
