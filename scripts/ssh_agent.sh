#!/bin/sh
# stop on all errors
set -e

new_ssh_agent () { 
    SSH_AGENT_ENV="$(umask 066; ssh-agent | tee ~/.nchart/ssh_agent)"
    eval "$SSH_AGENT_ENV" >/dev/null 2>&1
    ssh-add -t 1800 "${NCHART_SSH_PRIVATE_KEY}"
}

# if SSH_AGENT_ENV file exists load variables
if SSH_AGENT_ENV="$(cat ~/.nchart/ssh_agent)"; then
    eval "$SSH_AGENT_ENV" >/dev/null 2>&1
    # run new_ssh_agent if ssh-add connection fails (retcode 2)
    RETCODE=0; ssh-add -l >/dev/null 2>&1 || RETCODE="$?"
    if [ "$RETCODE" = 2 ]; then
        new_ssh_agent
    fi
else
    new_ssh_agent
fi
