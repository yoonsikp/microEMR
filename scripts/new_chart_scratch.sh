#!/bin/sh
# stop on all errors
set -euf

# get new UUID
NEWUUID="$(./scripts/new_uuid.sh)"
CHARTDIR="${NCHART_SCRATCH}/${NEWUUID}/"

# crash if chart directory already exists
mkdir "${CHARTDIR}"

# initialize git repo with git template, i.e. policies
git init --initial-branch main --template=./policies/default/git/scratch "${CHARTDIR}"

# set git user details
git -C "${CHARTDIR}" config user.name "${NCHART_FULLNAME}"
git -C "${CHARTDIR}" config user.email "${NCHART_ACCOUNT}@${NCHART_DOMAIN}"

echo "Successfully created new chart: ${CHARTDIR}"
