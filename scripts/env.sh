#!/usr/bin/env bash
# stop on all errors
set -e

export NCHART_CONF="~/.nchart"
export NCHART_NAME="Joel McDonald"
export NCHART_ACCOUNT="joel"
export NCHART_ORG="mgh"
export NCHART_SSH_PRIVATE_KEY="${NCHART_CONF}/id_rsa"
export NCHART_SSH_PUBLIC_KEY="${NCHART_CONF}/id_rsa.pub"
# chmod 600 "${NCHART_SSH_PRIVATE_KEY}"
# chmod 644 "${NCHART_SSH_PUBLIC_KEY}"

# export NCHART_GOLDEN="ssh://[user@]localhost:2222/golden/"
export NCHART_GOLDEN="temp/golden"

export NCHART_GOLDEN_SSH="0"

if expr "${NCHART_GOLDEN}" : ".*://"; then
    if expr "${NCHART_GOLDEN}" : "ssh://" || expr "${NCHART_GOLDEN}" : "git://"; then
        export NCHART_GOLDEN_SSH="1"
    else
        echo "non-ssh protocols not currently supported"; exit 1
    fi
fi

# scp-like syntax for ssh is valid
if expr "${NCHART_GOLDEN}" : "[^/]*:"; then
    export NCHART_GOLDEN_SSH="1"
fi

export NCHART_SCRATCH="temp/scratch/${NCHART_ACCOUNT}/"

# start ssh-agent
if [ "${NCHART_GOLDEN_SSH}" == 1 ]; then
    source ./scripts/ssh_agent.sh
fi

# create user directory in scratch if it doesn't exist
mkdir -p "${NCHART_SCRATCH}"

export GIT_SSH_COMMAND="ssh -i '${NCHART_SSH_PRIVATE_KEY}' -o 'IdentitiesOnly yes' -o 'AddKeysToAgent yes'"
# git config core.askPass
"$@" 
