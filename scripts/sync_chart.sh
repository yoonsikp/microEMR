#!/bin/sh
# stop on all errors
set -euf

# UUID validation
UUID="${@}"; scripts/validate_uuid.sh "${UUID}"
CHARTDIR="${NCHART_SCRATCH}/${UUID}"

# check if golden exists (upstream)
if [ -z "${NCHART_GOLDEN}" ]; then
    echo "NCHART_GOLDEN must be valid to sync charts"; exit 1
fi

# if remote doesn't exist, we must create it
# maybe git clone to init if non-local??

UUID_UPPER="$(printf '%s\n' "${UUID}" | cut -c1-2)"
UUID_LOWER="$(printf '%s\n' "${UUID}" | cut -c3-32)"

# configure source directory
SOURCEDIR="${NCHART_GOLDEN}/${UUID_UPPER}/${UUID_LOWER}.git"

# check if golden remote already exists
if ! git -C "${CHARTDIR}" remote | grep -l -x "golden"; then
    git -C "${CHARTDIR}" remote add golden "${SOURCEDIR}"
fi

# if remote exists attempt pull push

# git pull if main branch exists on golden
if git -C "${CHARTDIR}" ls-remote --quiet --exit-code golden main; then
    git -C "${CHARTDIR}" pull --no-rebase golden main
fi

# git push all branches, if successful set the remote/upstream branches
git -C "${CHARTDIR}" push --all --set-upstream --atomic golden

echo "Synced chart: ${CHARTDIR}"
