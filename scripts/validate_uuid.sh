#!/usr/bin/env sh
# returns 1 (i.e. raise error) if not a valid lowercase uuid
# regex for expr are already anchored to the beginning of the string, no caret
expr "${@}" : "[a-f0-9]\{32\}$" >/dev/null 2>&1 && exit 0;
exit 1
