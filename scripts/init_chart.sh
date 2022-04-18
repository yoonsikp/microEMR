#!/usr/bin/env bash
# stop on all errors
set -euf -o pipefail
set -x

# UUID validation
UUID="${@}"
scripts/validate_uuid.sh "${UUID}"
CHARTDIR="${NCHART_SCRATCH}/${UUID}"

# copy standard chart template
cp -R templates/chart/ "${CHARTDIR}"

echo "Initialized chart: ${CHARTDIR}"
