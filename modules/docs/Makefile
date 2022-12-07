#
# Aeon Digital
# Rianna Cantarelli <rianna@aeondigital.com.br>
#
.SILENT:




#
# Inicia os containers do projeto baseado no 'docker-compose' e
# prepara o container da aplicação para a extração da documentação técnica.
docs-up: up docs-config





#
# Configura a classe de extração de documentação técnica
# Este comando precisa ser rodado apenas 1 vez para cada novo container e apenas
# se o arquivo de configuração ainda não existir.
docs-config:
	make/makeActions.sh makeExecuteBefore "$@"
	docker exec -it ${CONTAINER_WEBSERVER_NAME} mkdir -p docs;
	docker exec -it ${CONTAINER_WEBSERVER_NAME} ./vendor/bin/phpdoc-to-rst config;
	make/makeActions.sh makeExecuteAfter "$@"

#
# Efetua a extração da documentação técnica para o formato 'rst'.
docs-extract:
	make/makeActions.sh makeExecuteBefore "$@"
	docker exec -it ${CONTAINER_WEBSERVER_NAME} ./vendor/bin/phpdoc-to-rst generate docs src --public-only
	make/makeActions.sh makeExecuteAfter "$@"