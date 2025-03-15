#!/bin/bash

PASS=%PASSWORD%
USER=%USER%
SSH_KEY=%KEY%
PORT=%PORT%
# This script provides basic setup for server
# 
useradd -m $USER 
echo "$USER:$PASS" | chpasswd 

# Add a user to the sudo
chmod +w /etc/sudoers 
echo "$USER ALL=(ALL:ALL) ALL" >> /etc/sudoers
chmod -w /etc/sudoers
mkdir -p /home/$USER/.ssh/
echo $SSH_KEY >> /home/$USER/.ssh/authorized_keys

# Set up ssh
sed -r -i "s/#?Port \d+/Port $PORT/" /etc/ssh/sshd_config
sed -r -i "s/#?PermitRootLogin .*/PermitRootLogin no/" /etc/ssh/sshd_config
sed -r -i "s/#?PasswordAuthentication .*/PasswordAuthentication no/" /etc/ssh/sshd_config

rm $0





