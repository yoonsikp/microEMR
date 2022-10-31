#!/bin/sh
# stop on all errors
set -euf

# UUID validation
UUID="${*}"
scripts/validate_uuid.sh "${UUID}"

# check if golden exists (upstream)
if [ -z "${NCHART_GOLDEN}" ]; then
    echo "NCHART_GOLDEN must be valid to fetch charts"; exit 1
fi

UUID_UPPER="$(printf '%s\n' "${UUID}" | cut -c1-2)"
UUID_LOWER="$(printf '%s\n' "${UUID}" | cut -c3-32)"

# configure source directory
SOURCEDIR="${NCHART_GOLDEN}/${UUID_UPPER}/${UUID_LOWER}.git"

# disable executable bit
git clone --quiet --reject-shallow --no-local --no-hardlinks --template=./templates/git/scratch \
    --config core.filemode=false "${SOURCEDIR}" "${NCHART_SCRATCH}/${UUID}"
