#! /usr/bin/bash

scenario=$1
if [ -z "$scenario" ] ; then
  echo ""
  echo "1. Clean environment (engine-cleanup + engine-setup)"
  echo "2. Create base environment (single host / 2 NFS domains / 2 iSCSI domains)"
  echo "3. Clean(1) + Start engine + Create(2)"
  echo ""
  echo "Which scenario would you like to invoke?"

  read selection
  case $selection in
  1) scenario='clean_env'
     ;;
  2) scenario='create_env'
     ;;
  3) scenario='recreate_env'
     ;;
  *) echo "$selection is not a valid selection"
     exit 1
     ;;
  esac
fi

source /home/derez/git/ansible/hacking/env-setup -i inventory/ovirt
ansible-galaxy install -f -r requirements.yml
ansible-playbook $scenario.yml -i inventory/ovirt --vault-password-file .vault_pass.txt
