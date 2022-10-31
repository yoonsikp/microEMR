#!/bin/sh
# stop on all errors
set -e

ssh-keygen -t rsa -b 4096 -f "${NCHART_CONF}/id_rsa"

# chmod 600 "${NCHART_SSH_PRIVATE_KEY}"
# chmod 644 "${NCHART_SSH_PUBLIC_KEY}"
