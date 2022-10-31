#!/bin/sh
# stop on all errors
set -euf

# UUID validation
UUID="${*}"
scripts/validate_uuid.sh "${UUID}"
CHARTDIR="${NCHART_SCRATCH}/${UUID}"

# check if golden exists (upstream)
if [ -z "${NCHART_GOLDEN}" ]; then
    echo "NCHART_GOLDEN must be valid to delete charts"; exit 1
fi

if [ ! -d "${CHARTDIR}" ]; then
    echo "chart is not open or available"; exit 1
else
    rm -rf "${CHARTDIR}"
fi

echo "chart closed"
