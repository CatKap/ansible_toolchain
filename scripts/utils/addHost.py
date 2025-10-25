#!/bin/env python3 
import yaml
import argparse
from sys import stdout

def add_host(host:str, filename = None, group = 'nogroup', ssh_key:str = '', user:str = '', sudo_pass = None):
    new_info = {host:{}}

    if sudo_pass:
        new_info[host].update({'ansible_sudo_pass':sudo_pass})

    if user:
        new_info[host].update({'ansible_user':user})

    if ssh_key:
        new_info[host].update({'ansible_ssh_private_key_file':ssh_key})


    if not filename:
        data = {}
    
    else:
        with open(filename, "r") as f:
            data = yaml.full_load(f)
        if not data:
            data = {}

    try:
        edit_hosts = data[group]['hosts']
        edit_hosts.update(new_info)
    except:
        data.update({group:{'hosts':new_info}})

       
    if not filename:
        yaml.dump(data, stdout)
    else:
        with open(filename, 'w') as f:
            yaml.dump(data, f)



if __name__ == "__main__":
    parser = argparse.ArgumentParser(
                        prog='addHost',
                        description='Add a host to the YAML invenory file',
                        )
    
    parser.add_argument('hostname')
    parser.add_argument('-i', '--inventory', default=None)     # inventory file 
    parser.add_argument('-g', '--group', default='nogroup')    # Host group
    parser.add_argument('-s', '--ssh-key', default='')  # Ssh key
    parser.add_argument('-u', '--user', default='')     # Ssh key
    parser.add_argument('-p', '--password', default='') # Password for user 
    
    
    parser = parser.parse_args()
    add_host(parser.hostname, parser.inventory, parser.group, parser.ssh_key, parser.user, parser.password)
    

    










