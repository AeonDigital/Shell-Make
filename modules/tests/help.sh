#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







unset tmpModTitle
unset tmpMacroInfo
declare -a tmpMacroInfo=()


tmpModTitle="Tests"

tmpMacroInfo+=("@macro")
tmpMacroInfo+=("test")
tmpMacroInfo+=("Executa a bateria de testes unitários.")
tmpMacroInfo+=("@param")
tmpMacroInfo+=("file=path")
tmpMacroInfo+=("Opcional; Arquivo de testes a ser executado de forma individual;")
tmpMacroInfo+=("Informe um caminho relativo a partir de '/tests/src'")
tmpMacroInfo+=("@param")
tmpMacroInfo+=("method=name")
tmpMacroInfo+=("Opcional; Nome do método de teste do arquivo alvo que será testado individualmente;")


tmpMacroInfo+=("@macro")
tmpMacroInfo+=("test-cover")
tmpMacroInfo+=("Executa a verificação total de cobertura dos testes unitários")
tmpMacroInfo+=("@param")
tmpMacroInfo+=("file=path")
tmpMacroInfo+=("Opcional; Arquivo de testes cuja cobertura será verificada;")
tmpMacroInfo+=("@param")
tmpMacroInfo+=("output=string")
tmpMacroInfo+=("Opcional; Tipo de saída da informação obtida do teste de cobertura;")
tmpMacroInfo+=("Opções: 'text' | 'html'")