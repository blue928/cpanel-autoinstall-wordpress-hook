#!/bin/bash

# Reference: https://support.cpanel.net/hc/en-us/articles/360037044993-How-To-Automatically-Install-WordPress-On-New-Accounts-Updated-for-WP-Toolkit-
# Written for cPanel v94+

TMPFILE="$(mktemp -p /tmp wp-auto-install-XXXXXXXX)"
cat "${1:-/dev/stdin}" > $TMPFILE
USER=$(python3 -c "import sys, json; print(json.load(open('$TMPFILE'))['data']['user'])")
PASS=$(python3 -c "import sys, json; print(json.load(open('$TMPFILE'))['data']['pass'])")
DOMAIN=$(python3 -c "import sys, json; print(json.load(open('$TMPFILE'))['data']['domain'])")
CUSTOMEREMAIL=$(python3 -c "import sys, json; print(json.load(open('$TMPFILE'))['data']['contactemail'])")

## The following variable contains the name of the Package that was assigned to the account.
## It would be possible to add additinal logic to this script so that WordPress is only installed for certain packages
# PACKAGE=$(python -c "import sys, json; print json.load(open('$TMPFILE'))['data']['plan']")

echo $TMPFILE > ./whatgoeshere

#rm -f $TMPFILE

#Softaculous
/usr/local/cpanel/3rdparty/bin/php /usr/local/cpanel/whostmgr/docroot/cgi/softaculous/cli.php \
    --install \
    --panel_user=USER \
    --panel_pass=PASS \
    --soft=26 \
#    --softdirectory=test \
#    --admin_username=admin \
#    --admin_pass=pass

#Wp Toolkit
#wp-toolkit --install -domain-name $DOMAIN -admin-email $CUSTOMEREMAIL