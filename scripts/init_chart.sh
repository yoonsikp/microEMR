#!/usr/bin/env bash
# stop on all errors
set -euf -o pipefail
set -x

# first argument
UUID="${@}"

# validate lowercase UUID
scripts/validate_uuid.sh "${UUID}"

CHARTDIR="${NCHART_SCRATCH}/${UUID}"

# copy standard chart template
cp -R templates/root/ "${CHARTDIR}"

echo "Initialized chart located: ${CHARTDIR}"
