#!/usr/bin/env bash
# stop on all errors
set -e

ssh-keygen -t rsa -b 4096 -f .nchart/id_rsa
