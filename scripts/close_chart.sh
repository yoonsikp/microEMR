#!/usr/bin/env bash
# stop on all errors
set -euf -o pipefail

# first argument
UUID="${@}"

# validate lowercase UUID
scripts/validate_uuid.sh "${UUID}"

CHARTDIR="${NCHART_SCRATCH}/${UUID}"

if [ ! -d "${CHARTDIR}" ]
then
    echo "chart is not open or available"
    exit 1
else
    rm -rf "${CHARTDIR}"
fi
