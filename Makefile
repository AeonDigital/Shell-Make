#
# Aeon Digital
# Rianna Cantarelli <rianna@aeondigital.com.br>
#
.SILENT:


#
# Carrega variáveis e módulos
include make/makeEnvironment.sh

include Shell-Make/modules/database/Makefile
include Shell-Make/modules/docker/Makefile
include Shell-Make/modules/docs/Makefile
include Shell-Make/modules/git/Makefile
include Shell-Make/modules/php/Makefile
include Shell-Make/modules/tests/Makefile