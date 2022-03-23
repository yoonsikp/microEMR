#!/usr/bin/env bash
# stop on all errors
set -e

export NCHART_FULL_NAME="Joel McDonald"
export NCHART_ACCOUNT_NAME="joel"
export NCHART_ORGANIZATION="mgh"
export NCHART_GOLDEN="temp/golden"
export NCHART_SCRATCH="temp/scratch/${NCHART_ACCOUNT_NAME}/"

# create user directory in scratch if it doesn't exist
mkdir -p "${NCHART_SCRATCH}"

"$@"
