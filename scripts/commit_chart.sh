#!/usr/bin/env bash
# stop on all errors
set -euf -o pipefail
set -x

# UUID validation
UUID="${@}"
scripts/validate_uuid.sh "${UUID}"
CHARTDIR="${NCHART_SCRATCH}/${UUID}"

# adds all new, modified, and deleted files to git staging
git -C "${CHARTDIR}" add --all

# create commit
git -C "${CHARTDIR}" commit --no-edit --message "Updated Chart"

echo "Commited all changes for chart: ${CHARTDIR}"
