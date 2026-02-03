# O ansible funciona por padrão com ssh, então garante que o teu ssh está tudo okay.

# Aqui: 77.42.85.245 ansible_user=root, onde 77.42.85.245 é o nome do host e ansible_user=root é o usuário que o ansible vai usar, as vezes é necessário passar esse usuário porque no meu wsl2 o meu usuário é rigoberto e na minha vps o meu usuário para acessar é root pois eu acesso assim ssh root@77.42.85.245 com o root, se eu não dizer aqui explicitamente, ele vai tentar se conectar com o usuário rigoberto e vai falhar.

# Para rodar o teu playbook(Projeto ansible) você faz assim:  ansible-playbook -i hosts playbook.yaml onde ansible-playbook é o comando, o -i hosts é para você dizer para qual grupo os comandos vão rodar, nesse caso vão rodar para o grupo de máquinas chamadas de producao porque no arquivo playbook nós já colocamos hosts: producao e playbook.yaml é o nome do nosso playbook.

# Quando você roda algo e fica amarelo quer dizer que a tal coisa foi mudada, se fica verde não mudou e se fica vermelho deu erro.

# O ansible galaxy é usado para separar o nosso playbook em roles, ou seja, em pequenos conjuntos de tarefas, para usar o ansible-galaxy, criamos uma pasta roles na raiz do projeto, entramos na pasta e dentro dela usamos o comando:  ansible-galaxy init deploy_backend onde deploy_backend é o nome da role que será criado dentro dessa pasta. Ao rodar esse comando, vai criar uma pasta chamada deploy_backend dentro da pasta roles e dentro da pasta roles terá um monte de arquivos e pastas.

# Para rodar um playbook criado com ansible-galaxy, entramos na pasta roles com cd, entramos na pasta da roles que criamos e executamos: ansible-playbook -i ../hosts main.yaml