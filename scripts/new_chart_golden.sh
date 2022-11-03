#!/bin/sh
# stop on all errors
set -euf

# get new UUID
UUID="$(./scripts/new_uuid.sh)"

UUID_UPPER="$(printf '%s\n' "${UUID}" | cut -c1-2)"
UUID_LOWER="$(printf '%s\n' "${UUID}" | cut -c3-32)"

mkdir -p "${NCHART_UPSTREAM}/${UUID_UPPER}"
CHARTDIR="${NCHART_UPSTREAM}/${UUID_UPPER}/${UUID_LOWER}.git"


# crash if chart directory already exists
mkdir "${CHARTDIR}"

# initialize chart with git template
git init --initial-branch main --bare --template=./policies/default/git/upstream "${CHARTDIR}"

# enforce file integrity
git -C "${CHARTDIR}" config transfer.fsckObjects true
git -C "${CHARTDIR}" config receive.fsckobjects true

# prevent deleting main branch
git -C "${CHARTDIR}" config receive.denyDeletes true

# stop non fast forward push
git -C "${CHARTDIR}" config receive.denyNonFastForwards true

echo "Your new chart is located: ${CHARTDIR}"
