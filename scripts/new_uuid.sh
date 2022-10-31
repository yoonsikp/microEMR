#!/bin/sh
# stop on all errors
set -euf

# create UUIDv4, convert to lowercase, remove dashes
uuidgen | tr '[:upper:]' '[:lower:]'  | sed 's/-//g'
