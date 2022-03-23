#!/usr/bin/env bash
# stop on all errors
set -euf -o pipefail

# first argument
UUID="${@}"

# validate lowercase UUID
scripts/validate_uuid.sh "${UUID}"

SOURCEDIR="${NCHART_GOLDEN}/${UUID:0:2}/${UUID:2:32}.git/"

# disable executable bit
git clone --quiet --reject-shallow --no-local --no-hardlinks --template=./templates/git/ \
  --config core.filemode=false "${SOURCEDIR}" "${NCHART_SCRATCH}/${UUID}"
