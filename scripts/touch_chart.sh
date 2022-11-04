#!/bin/sh
# stop on all errors
set -euf

# UUID validation
UUID="${*}"
scripts/validate_uuid.sh "${UUID}"
CHARTDIR="${NCHART_SCRATCH}/${UUID}"

currentdt="$(date -u +"%Y%m%dT%H%M%SZ")"

touch "${CHARTDIR}"/"${currentdt}"_
