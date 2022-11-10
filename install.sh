#!/bin/sh
# stop on all errors
set -euf

# set default nchart configuration directory
if [ -z "${NCHART_CONF+x}" ]; then
    export NCHART_CONF="${HOME}/.nchart/"
fi

echo "${NCHART_CONF}"
# crash if configuration directory already exists
mkdir "${NCHART_CONF}"

cp -R ./policies/default/config/ "${NCHART_CONF}"
