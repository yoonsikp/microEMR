#!/usr/bin/env bash
# stop on all errors
set -e

cd ./ansible/
ansible local_vm -m command -a uptime -i ./inventories

ansible-playbook server_base.yml -i ./inventories -K -e='@../config.json'

ansible-playbook server_configure.yml -i ./inventories -K -e='@../config.json'
