#!/bin/sh
# stop on all errors
set -euf

# UUID validation
UUID="${*}"
scripts/validate_uuid.sh "${UUID}"
CHARTDIR="${NCHART_SCRATCH}/${UUID}"

# adds all new, modified, and deleted files to git staging
git -C "${CHARTDIR}" add --all

# create commit
if git -C "${CHARTDIR}" commit --no-edit --message "Updated Chart"; then
    echo "Commited all changes for chart: ${CHARTDIR}"
else
    echo "No changes to commit"
fi
