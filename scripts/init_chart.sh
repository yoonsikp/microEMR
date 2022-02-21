#!/usr/bin/env bash
# stop on all errors
set -e

LEEMR_USER="Joel McDonald"
LEEMR_EMAIL="joel@localhost"
LEEMR_GOLDEN="/Volumes/leemr"

# convert to lowercase, remove dashes
NEWUUID=$(uuidgen | tr '[:upper:]' '[:lower:]' | sed 's/-//g')

mkdir -p "${LEEMR_GOLDEN}/${NEWUUID:0:2}"
CHARTDIR="${LEEMR_GOLDEN}/${NEWUUID:0:2}/${NEWUUID:2:32}/"

# crash if chart directory already exists
mkdir "${CHARTDIR}"
mkdir "${CHARTDIR}/git/"

# copy standard chart template
mkdir "${CHARTDIR}/data/"
cp -R chart_template/data/ "${CHARTDIR}/data/"

git init -q --separate-git-dir="${CHARTDIR}/git/" --template=./chart_template/git --initial-branch=master "${CHARTDIR}/data/"
printf "gitdir: ../git\n" >${CHARTDIR}/data/.git

pushd "${CHARTDIR}/data/" > /dev/null
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
git commit -q -a --allow-empty --no-edit -m "Initialized Chart" --author=""
popd > /dev/null

echo "Your new chart is located: ${CHARTDIR}"
