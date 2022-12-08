#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







unset tmpModTitle
unset tmpMacroInfo
declare -a tmpMacroInfo=()


tmpModTitle="Docs"

tmpMacroInfo+=("@macro")
tmpMacroInfo+=("docks-up")
tmpMacroInfo+=("Inicia os containers do projeto baseado no 'docker-compose' e")
tmpMacroInfo+=("prepara o container da aplicação para a extração da documentação técnica.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("docs-config")
tmpMacroInfo+=("Configura a classe de extração de documentação técnica.")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("docs-extract")
tmpMacroInfo+=("Efetua a extração da documentação técnica para o formato 'rst'.")