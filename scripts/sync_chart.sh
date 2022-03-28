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

# if remote exists attempt pull push

# if remote doesn't exist, check if golden var exists,
# if it doesn't exist fail out
# else, we must create it
# maybe git clone if non-local??
git remote add golden "${NCHART_GOLDEN}"

# git pull if master branch exists on golden
if git -C "${CHARTDIR}" ls-remote --quiet --exit-code golden master; then
    git -C "${CHARTDIR}" pull --no-rebase golden
fi

# git push all branches, if successful set the remote/upstream branches
git -C "${CHARTDIR}" push --all --set-upstream --atomic golden

echo "Synced chart located: ${CHARTDIR}"
