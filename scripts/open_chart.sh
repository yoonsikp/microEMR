#!/bin/sh
# stop on all errors
set -euf

# UUID validation
UUID="${*}"
scripts/validate_uuid.sh "${UUID}"

# check if upstream exists
if [ -z "${NCHART_UPSTREAM}" ]; then
    echo "NCHART_UPSTREAM must be valid to fetch charts"; exit 1
fi

UUID_UPPER="$(printf '%s\n' "${UUID}" | cut -c1-2)"
UUID_LOWER="$(printf '%s\n' "${UUID}" | cut -c3-32)"

# configure source directory
SOURCEDIR="${NCHART_UPSTREAM}/${UUID_UPPER}/${UUID_LOWER}.git"

CHARTDIR="${NCHART_SCRATCH}/${UUID}/"

# disable executable bit
git clone --quiet --reject-shallow --no-local --no-hardlinks --template=./policies/default/git/scratch \
    --config core.filemode=false "${SOURCEDIR}" "${CHARTDIR}"

# set git user details
git -C "${CHARTDIR}" config user.name "${NCHART_FULLNAME}"
git -C "${CHARTDIR}" config user.email "${NCHART_ACCOUNT}@${NCHART_DOMAIN}"
