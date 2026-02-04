#!/usr/bin/env bash
ansible-playbook -i hosts --vault-pass-file=.vault_pass playbook.yaml