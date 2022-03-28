#!/usr/bin/env bash
# stop on all errors
set -e

export NCHART_FULL_NAME="Joel McDonald"
export NCHART_ACCOUNT_NAME="joel"
export NCHART_ORGANIZATION="mgh"
export NCHART_GOLDEN="temp/golden"
export NCHART_GOLDEN_FILE="1"
# export NCHART_GOLDEN="ssh://[user@]localhost:2222/golden/"
export NCHART_SCRATCH="temp/scratch/${NCHART_ACCOUNT_NAME}/"

# # Prevent Directory Traversal
# if echo "${NCHART_ACCOUNT_NAME}" | grep --fixed-strings --quiet "../"; then
#     echo "Directory Traversal"; exit 1
# fi

# create user directory in scratch if it doesn't exist
mkdir -p "${NCHART_SCRATCH}"

"$@"
