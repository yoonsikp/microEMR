#!/usr/bin/env bash
# stop on all errors
set -euf -o pipefail

# set default nchart configuration directory
if [ -z "${NCHART_CONF+x}" ]; then
    export NCHART_CONF="${HOME}/.nchart"
fi

echo "${NCHART_CONF}"
# crash if configuration directory already exists
mkdir "${NCHART_CONF}"

cp -R ./templates/config/ "${NCHART_CONF}"
