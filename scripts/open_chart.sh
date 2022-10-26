#!/usr/bin/env bash
# stop on all errors
set -euf -o pipefail

# UUID validation
UUID="${@}"
scripts/validate_uuid.sh "${UUID}"

# check if golden exists (upstream)
if [ -z "${NCHART_GOLDEN}" ]; then
    echo "NCHART_GOLDEN must be valid to fetch charts"; exit 1
fi

# configure source directory
SOURCEDIR="${NCHART_GOLDEN}/${UUID:0:2}/${UUID:2:32}.git"

# disable executable bit
git clone --quiet --reject-shallow --no-local --no-hardlinks --template=./templates/git/scratch \
    --config core.filemode=false "${SOURCEDIR}" "${NCHART_SCRATCH}/${UUID}"
