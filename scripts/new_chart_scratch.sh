#!/usr/bin/env bash
# stop on all errors
set -euf -o pipefail

# get new UUID
NEWUUID="$(./scripts/new_uuid.sh)"
CHARTDIR="${NCHART_SCRATCH}/${NEWUUID}/"

# crash if chart directory already exists
mkdir "${CHARTDIR}"

# initialize git repo with git template, i.e. policies
git init --initial-branch main --template=./templates/git/scratch "${CHARTDIR}"

# set git user details
git -C "${CHARTDIR}" config user.name "${NCHART_NAME}"
git -C "${CHARTDIR}" config user.email "${NCHART_ACCOUNT}@${NCHART_ORG}"

# create commit with empty folder
git -C "${CHARTDIR}" commit --allow-empty --no-edit --message="New Chart"

echo "Successfully created new chart: ${CHARTDIR}"
