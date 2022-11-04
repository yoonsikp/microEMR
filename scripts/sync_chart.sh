#!/bin/sh
# stop on all errors
set -euf

# UUID validation
UUID="${@}"; scripts/validate_uuid.sh "${UUID}"
CHARTDIR="${NCHART_SCRATCH}/${UUID}"

# check if upstream exists
if [ -z "${NCHART_UPSTREAM}" ]; then
    echo "NCHART_UPSTREAM must be valid to sync charts"; exit 1
fi

# if remote doesn't exist, we must create it
# maybe git clone to init if non-local??

UUID_UPPER="$(printf '%s\n' "${UUID}" | cut -c1-2)"
UUID_LOWER="$(printf '%s\n' "${UUID}" | cut -c3-32)"

# configure source directory
SOURCEDIR="${NCHART_UPSTREAM}/${UUID_UPPER}/${UUID_LOWER}.git"

# check if upstream remote already exists
if ! git -C "${CHARTDIR}" remote | grep -l -x "upstream"; then
    git -C "${CHARTDIR}" remote add upstream "${SOURCEDIR}"
fi

# if remote exists attempt pull push

# git pull if main branch exists on upstream
if git -C "${CHARTDIR}" ls-remote --quiet --exit-code upstream main; then
    git -C "${CHARTDIR}" pull --no-rebase upstream main
fi

# # git push all branches, if successful set the remote/upstream branches
# git -C "${CHARTDIR}" push --all --set-upstream --atomic upstream

# git push master, if successful set the remote/upstream branches
git -C "${CHARTDIR}" push --set-upstream --atomic upstream main

echo "Synced chart: ${CHARTDIR}"
