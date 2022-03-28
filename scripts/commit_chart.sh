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

# add everything to staging
git -C "${CHARTDIR}" add --all

# git commit all
git -C "${CHARTDIR}" commit -q --no-edit \
  -m "Updated Chart" --author="${AUTHOR}"

echo "Commited all changes for chart located: ${CHARTDIR}"
