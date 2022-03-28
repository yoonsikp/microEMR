#!/usr/bin/env bash
# stop on all errors
set -euf -o pipefail
set -x

AUTHOR="${NCHART_FULL_NAME} <${NCHART_ACCOUNT_NAME}@${NCHART_ORGANIZATION}>"

# convert to lowercase, remove dashes
NEWUUID="$(uuidgen | tr '[:upper:]' '[:lower:]'  | sed 's/-//g')"
CHARTDIR="${NCHART_SCRATCH}/${NEWUUID}/"

# crash if chart directory already exists
mkdir "${CHARTDIR}"

# initialize chart with git template i.e. chart policy
git init --quiet --initial-branch main \
  --template=./templates/git/scratch "${CHARTDIR}"

# enforce file integrity
git -C "${CHARTDIR}" config user.name "${NCHART_FULL_NAME}"
git -C "${CHARTDIR}" config user.email "${NCHART_ACCOUNT_NAME}@${NCHART_ORGANIZATION}"

# create empty commit
git -C "${CHARTDIR}" commit -q --allow-empty --no-edit \
  -m "Initialized Chart" --author="${AUTHOR}"

echo "Your new chart is located: ${CHARTDIR}.git"
