#!/usr/bin/env bash
# stop on all errors
set -euf -o pipefail

# create UUIDv4, convert to lowercase, remove dashes
uuidgen | tr '[:upper:]' '[:lower:]'  | sed 's/-//g'
