#!/bin/bash

# Reference: https://support.cpanel.net/hc/en-us/articles/360037044993-How-To-Automatically-Install-WordPress-On-New-Accounts-Updated-for-WP-Toolkit-
# Written for cPanel v94+

TMPFILE="$(mktemp -p /tmp wp-auto-install-XXXXXXXX)"
cat "${1:-/dev/stdin}" > $TMPFILE
DOMAIN=$(python -c "import sys, json; print json.load(open('$TMPFILE'))['data']['domain']")
CUSTOMEREMAIL=$(python -c "import sys, json; print json.load(open('$TMPFILE'))['data']['contactemail']")

## The following variable contains the name of the Package that was assigned to the account.
## It would be possible to add additinal logic to this script so that WordPress is only installed for certain packages
# PACKAGE=$(python -c "import sys, json; print json.load(open('$TMPFILE'))['data']['plan']")

rm -f $TMPFILE

wp-toolkit --install -domain-name $DOMAIN -admin-email $CUSTOMEREMAIL