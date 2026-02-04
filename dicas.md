# O ansible funciona por padrão com ssh, então garante que o teu ssh está tudo okay.

# Aqui: 77.42.85.245 ansible_user=root, onde 77.42.85.245 é o nome do host e ansible_user=root é o usuário que o ansible vai usar, as vezes é necessário passar esse usuário porque no meu wsl2 o meu usuário é rigoberto e na minha vps o meu usuário para acessar é root pois eu acesso assim ssh root@77.42.85.245 com o root, se eu não dizer aqui explicitamente, ele vai tentar se conectar com o usuário rigoberto e vai falhar.

# Para rodar o teu playbook(Projeto ansible) você faz assim:  ansible-playbook -i hosts playbook.yaml onde ansible-playbook é o comando, o -i hosts é para você dizer para qual grupo os comandos vão rodar, nesse caso vão rodar para o grupo de máquinas chamadas de producao porque no arquivo playbook nós já colocamos hosts: producao e playbook.yaml é o nome do nosso playbook.

# Quando você roda algo e fica amarelo quer dizer que a tal coisa foi mudada, se fica verde não mudou e se fica vermelho deu erro.

# O ansible galaxy é usado para separar o nosso playbook em roles, ou seja, em pequenos conjuntos de tarefas, para usar o ansible-galaxy, criamos uma pasta roles na raiz do projeto, entramos na pasta e dentro dela usamos o comando:  ansible-galaxy init deploy_backend onde deploy_backend é o nome da role que será criado dentro dessa pasta. Ao rodar esse comando, vai criar uma pasta chamada deploy_backend dentro da pasta roles e dentro da pasta roles terá um monte de arquivos e pastas.

# Para rodar um playbook criado com ansible-galaxy, entramos na pasta roles com cd, entramos na pasta da roles que criamos e executamos: ansible-playbook -i ../hosts main.yaml


# O ansible-vault protege os dados sensíveis, ou seja, você cria uma pasta group_vars na raiz do projeto e dentro dela cria um arquivo all.yml e coloca lá os teus dados sensíveis. Depois disso, na raiz do projeto você dá um: ansible-vault encrypt group_vars/all.yml e ele vai criptografar todos os teus dados sensíveis e ninguém vai conseguir ver (Vai pedir que coloques uma senha). A partir daí, você vai precisar criar um arquivo chamado de .vault_pass em roles, esse arquivo deve estar no gitignore porque ele não deve ir ao git, dentro desse arquivo vais colocar a senha que você digitou no passo anterior. Depois Daí é só usar as variáveis dentro das tasks. A partir disso, para rodar a task agora é com o comando ansible-playbook -i ../hosts main.yaml --vault-pass-file .vault_pass

# Se quisermos editar as senhas criptografadas, entramos na pasta group_vars e fazemos: ansible-vault edit all.yml


_________________________________________________________________________________________________________________________________________

# Para usar o ansible precisamos primeiro ter o ansible instalado, depois disso:
## 1: Criamos uma pasta (Pasta do projeto), dentro dessa pasta criamos um arquivo chamado hosts onde vamos colocar o nosso inventário, ou seja, o grupo de máquinas que vamos usar e aproveitamos também para nesse hosts dizer (se for necessário) qual é o user que o ansible vai usar, que pode ser root.
## 2: Criamos um arquivo chamado de playbook.yaml onde vamos escrever as nossas tasks ou roles.

## 3: Criamos as nossas roles usando o comando ansible-galaxy init NOMO_ROLE, esse comando cria um conjunto de arquivos. Onde nesses arquivos temos a pasta task onde vamos colocar as nossas tasks, temos a pasta templates e files onde podemos colocar nossos arquivos que não estão no git, mas deverão estar no servidor, tal como o .env.

## 4: Caso tenhamos variáveis sensíveis no projeto, então vamos usar o ansible-vault para criptografar os dados sensíveis. Criamos primeiro uma pasta chamada de group_vars (Na raiz do projeto), dentro dessa pasta criamos um arquivo all.yml e dentro desse arquivo vão ficar as nossas variáveis de ambiente (Dados sensíveis), uma vez feito isso, vamos usar o ansible-vault para criptografá-las. Entramos na pasta group_vars e executamos o comando: ansible-vault encrypt group_vars/all.yml, vai pedir uma senha e eu devo guardar essa senha para conseguir ver os dados que foram encriptados. Caso eu queira editar esses dados sensíveis uso o comando: ansible-vault edit all.yml, isso vai abrir um arquivo nano/vim para eu poder editar os dados. Depois disso, na raiz do projeto eu preciso ter um arquivo chamado de .vault_pass, esse arquivo deve estar no gitignore porque ele não pode ir para o git. Dentro desse arquivo você coloca a senha que você digitou anteriormente.

## 5: Você pode usar um comando para rodar o playbook e não precisar memorizar o comando inteiro, para isso, você precisa criar um arquivo na raiz do projeto, esse arquivo pode (ou não) se chamar run-playbook.sh e dentro dele você coloca o comando que você usa para executar o playbook, ele é um script. Depois disso, você precisa dar permissão para executar esse arquivo (Senão, vai dar permission denied), para dar a permissão de execução, você executa o comando: chmod +x run-playbook.sh e a partir daí, se você quiser rodar o playbook, basta estar na pasta raiz do projeto e no terminal fazer: ./run-playbook.sh