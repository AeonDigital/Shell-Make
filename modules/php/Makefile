#
# Aeon Digital
# Rianna Cantarelli <rianna@aeondigital.com.br>
#
.SILENT:




#
# Printa na tela o resultado do comando 'php -i'.
# Este comando é o equivalente em comand-line ao resultado obtido com o
# comando 'phpinfo();'
php-info:
	make/makeActions.sh makeExecuteBefore "$@"
	docker exec -it ${CONTAINER_WEBSERVER_NAME} php -i
	make/makeActions.sh makeExecuteAfter "$@"

#
# Instala as dependências do projeto
# usando o 'php composer'
php-composer-install:
	make/makeActions.sh makeExecuteBefore "$@"
	docker exec -it ${CONTAINER_WEBSERVER_NAME} composer install --prefer-dist
	make/makeActions.sh makeExecuteAfter "$@"

#
# Atualiza as dependências do projeto
# usando o 'php composer'
php-composer-update:
	make/makeActions.sh makeExecuteBefore "$@"
	docker exec -it ${CONTAINER_WEBSERVER_NAME} composer update --prefer-dist
	make/makeActions.sh makeExecuteAfter "$@"