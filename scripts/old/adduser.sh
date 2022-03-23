#!/usr/bin/env bash
# stop on all errors
set -e

cd ./ansible/
ssh -p2222 localhost "sudo -S smbpasswd -a joel"
