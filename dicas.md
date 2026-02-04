# O ansible funciona por padrão com ssh, então garante que o teu ssh está tudo okay.

# Aqui: 77.42.85.245 ansible_user=root, onde 77.42.85.245 é o nome do host e ansible_user=root é o usuário que o ansible vai usar, as vezes é necessário passar esse usuário porque no meu wsl2 o meu usuário é rigoberto e na minha vps o meu usuário para acessar é root pois eu acesso assim ssh root@77.42.85.245 com o root, se eu não dizer aqui explicitamente, ele vai tentar se conectar com o usuário rigoberto e vai falhar.

# Para rodar o teu playbook(Projeto ansible) você faz assim:  ansible-playbook -i hosts playbook.yaml onde ansible-playbook é o comando, o -i hosts é para você dizer para qual grupo os comandos vão rodar, nesse caso vão rodar para o grupo de máquinas chamadas de producao porque no arquivo playbook nós já colocamos hosts: producao e playbook.yaml é o nome do nosso playbook.

# Quando você roda algo e fica amarelo quer dizer que a tal coisa foi mudada, se fica verde não mudou e se fica vermelho deu erro.

# O ansible galaxy é usado para separar o nosso playbook em roles, ou seja, em pequenos conjuntos de tarefas, para usar o ansible-galaxy, criamos uma pasta roles na raiz do projeto, entramos na pasta e dentro dela usamos o comando:  ansible-galaxy init deploy_backend onde deploy_backend é o nome da role que será criado dentro dessa pasta. Ao rodar esse comando, vai criar uma pasta chamada deploy_backend dentro da pasta roles e dentro da pasta roles terá um monte de arquivos e pastas.

# Para rodar um playbook criado com ansible-galaxy, entramos na pasta roles com cd, entramos na pasta da roles que criamos e executamos: ansible-playbook -i ../hosts main.yaml


# O ansible-vault protege os dados sensíveis, ou seja, você cria uma pasta group_vars na raiz do projeto e dentro dela cria um arquivo all.yml e coloca lá os teus dados sensíveis. Depois disso, na raiz do projeto você dá um: ansible-vault encrypt group_vars/all.yml e ele vai criptografar todos os teus dados sensíveis e ninguém vai conseguir ver (Vai pedir que coloques uma senha). A partir daí, você vai precisar criar um arquivo chamado de .vault_pass em roles, esse arquivo deve estar no gitignore porque ele não deve ir ao git, dentro desse arquivo vais colocar a senha que você digitou no passo anterior. Depois Daí é só usar as variáveis dentro das tasks. A partir disso, para rodar a task agora é com o comando ansible-playbook -i ../hosts main.yaml --vault-pass-file .vault_pass

# Se quisermos editar as senhas criptografadas, entramos na pasta group_vars e fazemos: ansible-vault edit all.yml