#!/bin/sh

hour=`date | awk {'print $4'} | cut -d: -f 1`
if [ $hour = '00' ]; then
        lasthour = 24
else

lasthour=`expr $hour - 01`
lasthour=`printf %02d $lasthour`

fi

> /tmp/countpop.txt

grep "`date | awk {'print $2"  "$3'}` $lasthour" /var/log/maillog |egrep -o 'pop3-login: Login: user=<[^ ]+' | sort|uniq -c|sort -nk 1| sed -e 's/pop3-login: Login: user=<//g' -e 's/>,//g' | while read login
do
        num=`echo $login | awk {'print $1'}`
        if [ $num  -gt 120 ]; then
                echo "$login ||" >> /tmp/countpop.txt
        fi
done

count=`cat /tmp/countpop.txt`

if [ "$(echo $count)" ]; then
        echo $count
        exit 2
else
        echo "OK pop login counts are fine"
        exit 0
fi
