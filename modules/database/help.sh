#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







unset tmpModTitle
unset tmpMacroInfo
declare -a tmpMacroInfo=()


tmpModTitle="Database"

tmpMacroInfo+=("@macro")
tmpMacroInfo+=("db-check")
tmpMacroInfo+=("Executa todas as verificações definidas para o banco de dados.")
tmpMacroInfo+=("Os testes executados são: db-check-ping db-check-network db-check-credentials.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("db-check-ping")
tmpMacroInfo+=("Verifica se é possível 'pingar' o servidor do banco de dados.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("db-check-network")
tmpMacroInfo+=("Verifica a qualidade da conexão com o banco de dados.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("db-check-credentials")
tmpMacroInfo+=("Verifica o acesso ao banco de dados da aplicação.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("db-show-characterset")
tmpMacroInfo+=("Mostra as configurações de 'character-set' atualmente definida.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("db-show-collation")
tmpMacroInfo+=("Mostra as configurações de 'collation' atualmente definida.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("db-clean")
tmpMacroInfo+=("Remove totalmente o banco de dados da aplicação e inicia um novo totalmente zerado.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("db-start")
tmpMacroInfo+=("Popula o banco de dados para a aplicação com os dados iniciais.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("db-export")
tmpMacroInfo+=("Exporta o backup do banco de dados da aplicação.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("db-bootstrap")
tmpMacroInfo+=("Exporta o backup do banco de dados da aplicação e substitui o atual arquivo bootstrap.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("db-patch")
tmpMacroInfo+=("Executa um patch de correção ou atualização para o banco de dados.")
tmpMacroInfo+=("@param")
tmpMacroInfo+=("file=path")
tmpMacroInfo+=("Arquivo de patch a ser usado")
tmpMacroInfo+=("Informe um caminho relativo a partir de '/etc/database/patch/'")