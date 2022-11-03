#!/bin/sh
# stop on all errors
set -euf

# UUID validation
UUID="${*}"
scripts/validate_uuid.sh "${UUID}"
CHARTDIR="${NCHART_SCRATCH}/${UUID}"

# check if UPSTREAM exists (upstream)
if [ -z "${NCHART_UPSTREAM}" ]; then
    echo "NCHART_UPSTREAM must be valid to delete charts"; exit 1
fi

if [ ! -d "${CHARTDIR}" ]; then
    echo "chart is not open or available"; exit 1
else
    rm -rf "${CHARTDIR}"
fi

echo "chart closed"
