#!/usr/bin/env bash
# stop on all errors
set -euf -o pipefail
set -x

# UUID validation
UUID="${@}"; scripts/validate_uuid.sh "${UUID}"
CHARTDIR="${NCHART_SCRATCH}/${UUID}"

# check if golden exists (upstream)
if [ -z "${NCHART_GOLDEN}" ]; then
    echo "NCHART_GOLDEN must be valid to sync charts"; exit 1
fi

# if remote doesn't exist, we must create it
# maybe git clone to init if non-local??

# configure source directory
SOURCEDIR="${NCHART_GOLDEN}/${UUID:0:2}/${UUID:2:32}.git"

git -C "${CHARTDIR}" remote add golden "${SOURCEDIR}"

# if remote exists attempt pull push

# git pull if main branch exists on golden
if git -C "${CHARTDIR}" ls-remote --quiet --exit-code golden main; then
    git -C "${CHARTDIR}" pull --no-rebase golden main
fi

# git push all branches, if successful set the remote/upstream branches
git -C "${CHARTDIR}" push --all --set-upstream --atomic golden

echo "Synced chart: ${CHARTDIR}"
