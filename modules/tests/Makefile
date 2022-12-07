#
# Aeon Digital
# Rianna Cantarelli <rianna@aeondigital.com.br>
#
.SILENT:




#
# Executa a bateria de testes
#
# Opcionais
# Use o parametro 'file' para indicar que os testes devem percorrer apenas
# os testes do arquivo especificado.
# Use o parametro 'method' (em adição ao parametro 'file') para indicar que
# apenas este método do referido arquivo deve ser executado.
#
# > make test
# > make test file="path/to/tgtFile.php"
# > make test file="path/to/tgtFile.php" method="tgtMethodName"
test:
	make/makeActions.sh makeExecuteBefore "$@"
	Shell-Make/modules/tests/makeActions.sh performUnitTests "${MAKECMDGOALS}"
	make/makeActions.sh makeExecuteAfter "$@"

#
# Executa a verificação total de cobertura dos testes unitários
#
# Opcionais
# Use o parametro 'file' para efetuar o teste de cobertura sobre apenas 1
# classe de testes.
#
# Use o parametro 'output' para selecionar o tipo de saida que o teste de
# cobertura deve ter. As opções são:
#  - 'text' (padrão) : printa o resultado na tela.
#  - 'html' : Monta a saída dos testes em formato HTML.
#
# > make test-cover
# > make test-cover file="path/to/tgtFile.php"
# > make test-cover output="html"
# > make test-cover file="path/to/tgtFile.php" output="html"
test-cover:
	make/makeActions.sh makeExecuteBefore "$@"
	Shell-Make/modules/tests/makeActions.sh performUnitCoverTests "${MAKECMDGOALS}"
	make/makeActions.sh makeExecuteAfter "$@"
