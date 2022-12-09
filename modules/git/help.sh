#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







unset tmpModTitle
unset tmpMacroInfo
declare -a tmpMacroInfo=()


tmpModTitle="Git"

tmpMacroInfo+=("@macro")
tmpMacroInfo+=("git-config-local")
tmpMacroInfo+=("Configura suas credenciais para o repositório atual.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("git-log")
tmpMacroInfo+=("Mostra log resumido do git.")
tmpMacroInfo+=("@param")
tmpMacroInfo+=("len=int")
tmpMacroInfo+=("Opcional; Número de itens de log a serem mostrados.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("git-task-start")
tmpMacroInfo+=("Inicia uma nova tarefa (branch).")
tmpMacroInfo+=("@param")
tmpMacroInfo+=("type=string")
tmpMacroInfo+=("Opções: 'a|architecture' | 'r|refactory' | 'f|feature' | 'i|improvement'")
tmpMacroInfo+=("        'm|maintenance'  | 'b|bugfix'    | 'h|hotfix'")
tmpMacroInfo+=("@param")
tmpMacroInfo+=("id=int")
tmpMacroInfo+=("Código único que identifica esta tarefa.")
tmpMacroInfo+=("@param")
tmpMacroInfo+=("name=string")
tmpMacroInfo+=("Nome identificador da tarefa/branch.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("git-task-commit")
tmpMacroInfo+=("Efetua um commit incremental para a tarefa/branch atual.")
tmpMacroInfo+=("@param")
tmpMacroInfo+=("prefix=string")
tmpMacroInfo+=("Opções: 'w|wip|work-in-progress' | 'v|view'   | 'c|ctrl|controller'   | 'm|model'")
tmpMacroInfo+=("        'd|db|database'          | 'f|format' | 'p|perf|performance'  | 'r|refactor'")
tmpMacroInfo+=("        'a|aux|auxiliar'         | 't|test'   | 'd|doc|documentation' | 'x|fix'")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("git-task-push")
tmpMacroInfo+=("Efetua o 'push' dos commits locais para o repositório remoto.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("git-task-finish")
tmpMacroInfo+=("Finaliza a tarefa entregando o resultado da tarefa no servidor remoto.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("git-tag")
tmpMacroInfo+=("Mostra qual a tag atual do projeto.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("git-tag-remark")
tmpMacroInfo+=("Redefine a tag atualmente vigente para o commit mais recente.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("git-tag-update")
tmpMacroInfo+=("Atualiza o 'patch' da tag atualmente definida para a branch principal 'main'.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("git-tag-update-minor")
tmpMacroInfo+=("Atualiza o 'minor version' da tag atualmente definida para a branch principal 'main'.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("git-tag-update-major")
tmpMacroInfo+=("Atualiza o 'major version' da tag atualmente definida para a branch principal 'main'.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("git-tag-stability")
tmpMacroInfo+=("Atualiza a 'stability' da tag atualmente definida para a branch principal 'main'.")
tmpMacroInfo+=("@param")
tmpMacroInfo+=("stability=string")
tmpMacroInfo+=("Opções: 'alpha' | 'beta' | 'cr' | 'r'")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("git-convert-eol-to-lf")
tmpMacroInfo+=("Converte o EOL de todos os arquivos do repositório para LF.")
