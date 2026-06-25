#!/bin/bash

if systemctl is-active --quiet imunify360; then
echo "OK - Imunify360 is running"
exit 0
elif systemctl is-active --quiet imunify-antivirus; then
echo "OK - ImunifyAV is running"
exit 0
else
users=$(w)
logins=$(last | head -n 10)


#echo -e "CRITICAL - Neither Imunify360 nor ImunifyAV is running\n\nCurrent logged users:\n$users\n\nLast logged users:\n$logins"
echo "CRITICAL - Neither Imunify360 nor ImunifyAV is running"
    echo
    echo "Current logged users:"
    echo "$users"
    echo
    echo "Last logged users:"
    echo "$logins"

exit 2




fi
