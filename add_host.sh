#!/bin/bash
RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

HOST=$1
PASS=$2
PORT=22
USER=root

# You ansible directory 
DIR='~/Cooooodiiiing/ansiblyat/'
cd DIR

INVENTORY='./inventory.yml' # Inventory file
I_GROUP='srv_ungroup'       # Inventory group 


DEF_USER=kapitan 
DEF_PASS=$(tr -dc A-za-z0-9_ < /dev/urandom | head -c 16 | xargs)  
echo -e "${GREEN}Adding host $1 with password $2 ${ENDCOLOR}\n"
echo "Creating new ssh file ... "
ssh-keygen -N '' -t rsa -f ~/.ssh/$HOST 
echo -e "${GREEN}[Ok]${ENDCOLOR}\n"

if ! echo -e "exit" | sshpass -p $PASS ssh -o PubkeyAuthentication=no -o PasswordAuthentication=yes -p $PORT $USER@$HOST; then
  echo -e "${RED} Cannot connect to host via ssh!${ENDCOLOR}"
  exit -1
fi

is_python_exsist=$(sshpass -p $PASS ssh -o PubkeyAuthentication=no -o PasswordAuthentication=yes -p $PORT  $USER@$HOST 'command -v python || command -v python3 || /bin/env python3 || echo "PY_NOT_FOUND"')

echo $is_python_exsist

export ANSIBLE_HOST_KEY_CHECKING=False
if [[ $is_python_exsist -eq 'PY_NOT_FOUND' ]] then
  echo "Python not found!"
  if ! ansible-playbook -i $HOST, ./playbook-000-python-install.yml --extra-vars\
    "ansible_user=root\
     ansible_password=$2\
     ansible_ssh_extra_args='-o PubkeyAuthentication=no -o HostKeyAlgorithms=+ssh-rsa -o PasswordAuthentication=yes'"; then
  echo -e "${RED} Ansible error while installing python!${ENDCOLOR}"
  exit -1
  fi
fi

cp ./scripts/00-base-setup.sh                  ./scripts/00-base-setup-$HOST.sh
sed -i "s/%PASSWORD%/\'$DEF_PASS\'/"           ./scripts/00-base-setup-$HOST.sh
sed -i "s/%USER%/$DEF_USER/"                   ./scripts/00-base-setup-$HOST.sh
sed -i  "s/%PORT%/$PORT/"                      ./scripts/00-base-setup-$HOST.sh
KEY=$(cat ~/.ssh/$HOST.pub)
sed -i  "s,%KEY%,'$KEY'," ./scripts/00-base-setup-$HOST.sh

# Run command on host

echo -e "${GREEN}Running script on host ... ${ENDCOLOR}\n"
if ! ansible-playbook -i $HOST, playbook-00-ssh-config.yaml --extra-vars\
    "ansible_user=root\
     ansible_password=$2\
     ansible_ssh_extra_args='-o PubkeyAuthentication=no -o HostKeyAlgorithms=+ssh-rsa -o PasswordAuthentication=yes'"; then
  echo -e "${RED} Ansible error running script!${ENDCOLOR}"
  exit -1
fi
echo -e "${GREEN}[Ok]${ENDCOLOR}\n"


echo -e "${GREEN}Adding machine to the hosts ... ${ENDCOLOR}"
./scripts/utils/addHost.py $HOST -g $I_GROUP -i $INVENTORY -p $DEF_PASS -u $DEF_USER -s $(realpath ~/.ssh/)/$HOST
echo -e "${GREEN}[Ok]${ENDCOLOR}\n"

echo -e "${GREEN}Host $HOST was added sucsessfully! Enjoy you journey!${ENDCOLOR}"







