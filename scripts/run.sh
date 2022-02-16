#!/usr/bin/env bash
# stop on all errors
set -e

cd ./ansible/
ansible local_vm -m command -a uptime -i ./inventories
