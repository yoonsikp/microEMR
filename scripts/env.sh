#!/usr/bin/env bash
# stop on all errors
set -e

export NCHART_FULLNAME="Joel McDonald"
export NCHART_ACCOUNT="joel"
export NCHART_DOMAIN="mgh"
export NCHART_SCRATCH="/Users/yoonsik/nchartdemo/${NCHART_ACCOUNT}/"
# export NCHART_GOLDEN="ssh://git@server:2222/golden/"
export NCHART_GOLDEN="temp/golden"

# look for valid SSH string
export NCHART_USE_SSH="0"
if expr "${NCHART_GOLDEN}" : ".*://" > /dev/null; then
    if expr "${NCHART_GOLDEN}" : "ssh://" > /dev/null; then
        export NCHART_USE_SSH="1"
    else
        echo "non-ssh protocols not currently supported"; exit 1
    fi
# scp-like syntax for ssh is also valid
elif expr "${NCHART_GOLDEN}" : "[^/]*:" > /dev/null; then
    export NCHART_USE_SSH="1"
fi

export NCHART_SSH_PRIVATE_KEY="${NCHART_CONF}/id_rsa"
export NCHART_SSH_PUBLIC_KEY="${NCHART_CONF}/id_rsa.pub"
# chmod 600 "${NCHART_SSH_PRIVATE_KEY}"
# chmod 644 "${NCHART_SSH_PUBLIC_KEY}"

# start ssh-agent
if [ "${NCHART_USE_SSH}" = 1 ]; then
    # i.e. source ./scripts/ssh_agent.sh
    . ./scripts/ssh_agent.sh
fi

# make sure ${NCHART_SSH_PRIVATE_KEY} is properly escaped
export GIT_SSH_COMMAND="ssh -i \"${NCHART_SSH_PRIVATE_KEY}\" -o \"IdentitiesOnly yes\" -o \"AddKeysToAgent yes\""

# git config core.askPass
