#!/usr/bin/env bash
# stop on all errors
set -euf -o pipefail
set -x

AUTHOR="${NCHART_FULL_NAME} <${NCHART_ACCOUNT_NAME}@${NCHART_ORGANIZATION}>"

# first argument
UUID="${@}"

# validate lowercase UUID
scripts/validate_uuid.sh "${UUID}"

CHARTDIR="${NCHART_SCRATCH}/${UUID}"

# git pull
git -C "${CHARTDIR}" pull

# git push
git -C "${CHARTDIR}" push --atomic

echo "Synced chart located: ${CHARTDIR}"
