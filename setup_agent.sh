#!/bin/bash

# Script for init set up for ansible agent

# Should be running like sudo
#

USER=ansible

if [[ $UID -ne 0 ]]; then
  echo "Insuffisient rights for running script, exiting"
  exit -1
fi

useradd $USER
groupadd ssl

usermod -aG ssl $USER
