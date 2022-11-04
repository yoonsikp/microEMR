#!/bin/sh
# stop on all errors
set -euf

# UUID validation
UUID="${*}"
scripts/validate_uuid.sh "${UUID}"
CHARTDIR="${NCHART_SCRATCH}/${UUID}"

# copy default chart template
cp -R policies/default/root/ "${CHARTDIR}"

# add files to git staging
git -C "${CHARTDIR}" add --all

# create initial commit with empty folder
git -C "${CHARTDIR}" commit --allow-empty --no-edit --message="New Chart"

echo "Initialized chart: ${CHARTDIR}"
