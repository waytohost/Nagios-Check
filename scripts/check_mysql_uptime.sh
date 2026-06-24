#!/bin/bash

UPTIME=$(mysql -N -s -e "SHOW GLOBAL STATUS LIKE 'Uptime';" 2>/dev/null | awk '{print $2}')

if [ -z "$UPTIME" ]; then
    echo "CRITICAL - MySQL is not responding"
    exit 2
fi

YEARS=$((UPTIME / 31536000))
REMAIN=$((UPTIME % 31536000))

MONTHS=$((REMAIN / 2592000))
REMAIN=$((REMAIN % 2592000))

DAYS=$((REMAIN / 86400))
REMAIN=$((REMAIN % 86400))

HOURS=$((REMAIN / 3600))
REMAIN=$((REMAIN % 3600))

MINUTES=$((REMAIN / 60))

OUTPUT="OK - MySQL uptime:"

[ $YEARS -gt 0 ] && OUTPUT="$OUTPUT ${YEARS}y"
[ $MONTHS -gt 0 ] && OUTPUT="$OUTPUT ${MONTHS}mo"
[ $DAYS -gt 0 ] && OUTPUT="$OUTPUT ${DAYS}d"

OUTPUT="$OUTPUT ${HOURS}h ${MINUTES}m"

echo "$OUTPUT"
exit 0
