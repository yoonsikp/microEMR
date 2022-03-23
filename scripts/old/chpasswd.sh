#!/usr/bin/env bash
# stop on all errors
set -e


# check https://github.com/turnkeylinux/common/blob/master/overlays/samba-fileserver/usr/lib/inithooks/bin/sambapass.py
ssh localhost -p 2222 "sudo -S smbpasswd -U joel"
