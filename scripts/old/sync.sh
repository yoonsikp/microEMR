#!/usr/bin/env bash
# stop on all errors
set -e

python3 

PERSONAL_DIR=scratch/${NCHART_USER}/${1}
if [ -d ${PERSONAL_DIR} ]
    cp golden/${1} ${PERSONAL_DIR}
else
    echo "Error: Directory {PERSONAL_DIR} already exists"
    exit 1

