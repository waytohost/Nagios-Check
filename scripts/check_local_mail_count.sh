#!/bin/sh

datevar=`date -I --date="1 hour ago"`

hourvar=`date +%H --date="1 hour ago"`
> /tmp/countlocal.txt


grep -A10000 "$datevar $hourvar" /var/log/exim_mainlog | grep "<=" | grep "U=" | grep -v mailnull | grep -v "root@" | grep -v "`cat /usr/local/nagios/libexec/check_local_mail_count.whitelist`" | awk -F"<= " '{split($2,a," ");print a[1]}'  |cut -d: -f 1|sort|uniq -c|sort -nk 1 |  while read localcount
do
        num=`echo $localcount | awk {'print $1'}`
        if [ $num  -gt 200 ]; then
                echo $localcount >> /tmp/countlocal.txt
        fi
done

count=`cat /tmp/countlocal.txt`

if [ "$(echo $count)" ]; then
        echo "$count"
        exit 2
else
        echo "OK SMTP local mail counts are fine"
        exit 0
fi
