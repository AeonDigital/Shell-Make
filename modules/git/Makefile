#
# Aeon Digital
# Rianna Cantarelli <rianna@aeondigital.com.br>
#
.SILENT:




#
# Configura suas credenciais para o repositório atual
git-config-local:
	make/makeActions.sh makeExecuteBefore "$@"
	Shell-Make/modules/git/makeActions.sh gitConfigLocal
	make/makeActions.sh makeExecuteAfter "$@"

#
# Mostra log resumido do git
# Use o parametro 'len' para indicar a quantidade de itens a serem mostrados.
log:
	make/makeActions.sh makeExecuteBefore "$@"
	Shell-Make/modules/git/makeActions.sh gitShowLog "${MAKECMDGOALS}"
	make/makeActions.sh makeExecuteAfter "$@"





#
# Mostra qual a tag atual do projeto.
tag:
	make/makeActions.sh makeExecuteBefore "$@"
	git describe --abbrev=0 --tags
	make/makeActions.sh makeExecuteAfter "$@"

#
# Redefine a tag atualmente vigente para o commit mais recente
tag-remark:
	make/makeActions.sh makeExecuteBefore "$@"
	Shell-Make/modules/git/makeActions.sh gitTagManagement "remark"
	make/makeActions.sh makeExecuteAfter "$@"

#
# Atualiza o 'patch' da tag atualmente definida
# para a branch principal 'main'.
tag-update:
	make/makeActions.sh makeExecuteBefore "$@"
	Shell-Make/modules/git/makeActions.sh gitTagManagement "version" "patch"
	make/makeActions.sh makeExecuteAfter "$@"

#
# Atualiza o 'minor version' da tag atualmente definida
# para a branch principal 'main'.
tag-update-minor:
	make/makeActions.sh makeExecuteBefore "$@"
	Shell-Make/modules/git/makeActions.sh gitTagManagement "version" "minor"
	make/makeActions.sh makeExecuteAfter "$@"

#
# Atualiza o 'major version' da tag atualmente definida
# para a branch principal 'main'.
tag-update-major:
	make/makeActions.sh makeExecuteBefore "$@"
	Shell-Make/modules/git/makeActions.sh gitTagManagement "version" "major"
	make/makeActions.sh makeExecuteAfter "$@"

#
# Atualiza a 'stability' da tag atualmente definida
# para a branch principal 'main'.
#
# Use o parametro 'stability' para indicar qual será a nova 'stability'.
# use apenas um dos seguintes valores: 'alpha'; 'beta'; 'cr'; 'r'
tag-stability:
	make/makeActions.sh makeExecuteBefore "$@"
	Shell-Make/modules/git/makeActions.sh gitTagManagement "stability" "${stability}"
	make/makeActions.sh makeExecuteAfter "$@"





#
# Inicia uma nova tarefa.
# Trata-se de uma branch com o objetivo de oferecer uma nova capacidade, melhoria ou
# uma correção do que já existe e que será mesclada com a 'main' assim que finalizar.
#
# Para funcionar adequadamente é necessário que, antes, seja feita a configuração local
# do repositório usando o comando 'git-config-local'.
#
# A seguinte sequência de operações será feita:
# - Vai para a branch 'main'
# - Efetua um pull da branch 'main'.
# - Inicia uma nova branch com o nome seguindo o seguinte padrão
#   'type'/'nick'/'id'/'name' indicados.
#
#
# Use o parametro 'type' para definir a natureza da tarefa que será
# desenvolvida dentro da nova branch.
# Escolha entre os valores:
# - a|architecture  : quando as alterações oferecidas envolvem grandes mudanças em partes
#                     críticas do funcionamento do sistema como alterações de dependências
#                     ou da própria arquitetura do sistema.
# - r|refactory     : quando as alterações envolvem alterações profundas de melhoria ou
#                     atualização de tecnologia mas não necessariamente alteram a
#                     arquitetura do software.
# - f|feature       : quando está criando uma funcionalidade que ainda não existe.
# - i|improvement   : para a melhoria de algo que já existe ou de uma feature já entregue.
# - m|maintenance   : para alterações cotidianas que não são exatamente uma nova
#                     funcionalidade ou melhoria. Adequações simples funcionais ou não como
#                     alteração simples de uma função ou adição/alteração de documentação
#                     por exemplo.
#
# - b|bugfix        : para correções de bugs sem urgência de entrega.
# - h|hotfix        : para correção de bugs em modo de urgência.
#
#
# Use o parametro 'id' para definir um código único que identifica esta tarefa.
# Deve ser um valor numérico geralmente relacionado a uma solicitação que motivou a criação
# desta branch.
# Este valor é opcional e pode ficar vazio. Neste caso, será usado o valor 'auto' para indicar
# que trata-se de uma tarefa avulsa e/ou auto motivada.
#
# Use o parametro 'name' para definir o nome da branch.
# todos os caracteres serão convertidos para minúsculas e qualquer espaço será convertido em '-'.
#
task-start:
	make/makeActions.sh makeExecuteBefore "$@"
	Shell-Make/modules/git/makeActions.sh gitTaskStart "${type}" "${datetime}"
	make/makeActions.sh makeExecuteAfter "$@"

#
# Efetua um commit incremental para a tarefa atual.
#
# A seguinte sequência de operações será feita:
# - Todos os arquivos contendo alterações serão movidos para 'stage'.
# - Um commit será criado com as informações indicadas pelo usuário ['prefix'] 'message'.
#
#
# Use o parametro 'prefix' para indicar a natureza da alteração sendo feita.
# Escolha entre os valores:
# - w|wip|work-in-progress
#   indica apenas um incremento genérico à totalidade da tarefa que a branch atual visa resolver.
#   Se o commit envolve mais de uma natureza de tarefas, use este como valor genérico.
#
# - v|view
#   quando a alteração envolve exclusivamente arquivos que compõe a camada de apresentação da
#   aplicação. Pode incluir javascript caso a alteração envolva apenas apresentação e não o
#   processamento dos dados.
#
# - c|ctrl|controller
#   quando a alteração envolve exclusivamente arquivos que compõe a camada de controle/regras de
#   negócio da aplicação. Pode incluir javascript caso a alteração envolva a forma como os dados
#   devam ser processados no cliente.
#
# - m|model
#   quando a alteração envolve exclusivamente arquivos que compõe a camada de modelos de dados
#   ou, o que for equivalente a definição do squema do banco de dados alvo.
#
# - d|db|database
#   quando a alteração envolve alterações que alteram os dados existentes no banco de dados alvo.
#
#
# - f|format
#   alterações que não afetam o funcionamento do código mas sim sua forma. Adição/remoção de
#   espaços em branco, alteração de tabs/espaços e toda sorte de formatação do código fonte com
#   função estética e/ou de padronização de escrita.
#
# - p|perf|performance
#   quando a alteração tem como função primordial melhorar a performance do processamento de uma
#   das várias camadas da arquitetura do software.
#
# - r|refactor
#   toda alteração de código que não corrige um bug e nem adiciona uma nova feature mas visa tornar
#   o mesmo melhor do ponto de vista de desenvolvimento. Agrupamento ou desmembramento de classes
#   e funções caem aqui. Geralmente está associado ao tipo de branch 'architecture'.
#
# - a|aux|auxiliar
#   quando as alterações oferecidas não lidam com a aplicação em si mas com processos auxiliares
#   como a troca de bibliotecas ou geradores de documentação ou ainda com a inserção de projetos
#   como o 'Shell-Make' que paralelamente ao projeto ajudam no seu desenvolvimento e organização.
#
#
# - t|test
#   qualquer alteração feita em função da adição de testes, correção dos testes, ajustes e
#   melhorias dos mesmos ou qualquer outra alteração em função destes.
#
# - d|doc|documentation
#   quando a alteração envolve exclusivamente informações de documentação, seja documentação
#   técnica ou arquivos de documentação como um README.
#
# - x|fix
#   quando a alteração envolve a correção de um bug ou a correção de um merge.
#
#
# Use o parametro 'message' para especificar uma mensagem a ser usada no título do commit.
# Caso o prefixo 'wip' esteja sendo usado, este pode ser omitido. Neste caso será usado o valor da
# data e hora do momento em que o comando foi executado usando o formato 'YYYY-MM-DD HH:mm'
# ("+%Y-%m-%d %H:%M").
# Para todos os outros tipos de prefixos é necessário usar algum valor para a mensagem do commit.
task-commit:
	make/makeActions.sh makeExecuteBefore "$@"
	Shell-Make/modules/git/makeActions.sh gitCommit "${prefix}" "${message}"
	make/makeActions.sh makeExecuteAfter "$@"

#
# Efetua o 'push' dos commits locais para o repositório remoto.
task-push:
	make/makeActions.sh makeExecuteBefore "$@"
	Shell-Make/modules/git/makeActions.sh gitPush
	make/makeActions.sh makeExecuteAfter "$@"

#
# Finaliza a tarefa entregando o resultado da tarefa no servidor remoto.
# Não pode haver alterações não comitadas para esta ação funcionar.
#
# A seguinte sequência de operações será feita:
# - Envia todos os commits não enviados ainda para o servidor remoto
# - Alterna para a branch 'main'.
# - Efetua um 'pull' na mesma para obter seu estado atual.
# - Efetua um 'merge' da tarefa finalizada com a branch 'main'.
# - Efetua um 'push' das alterações para o servidor remoto.
#
# ATENÇÃO
# O 'merge' só será feito se a variável de ambiente 'MK_GIT_TASK_FINISH_MERGE'
# estiver especificada com o valor '1'. De outra forma, a entrega remota será
# feita mas o merge ficará a cargo de uma outra ação como um Pull Request, ou
# uma revisão de outro desenvolvedor.
task-finish:
	make/makeActions.sh makeExecuteBefore "$@"
	Shell-Make/modules/git/makeActions.sh gitTaskFinish
	make/makeActions.sh makeExecuteAfter "$@"
