#!/usr/bin/env bash
#ansible-playbook -i hosts --vault-pass-file=.vault_pass playbook.yaml
# Como temos o arquivo ansible.cfg, podemos simplificar o comando acima, sem precisar passar o inventário:
ansible-playbook --vault-pass-file=.vault_pass playbook.yaml