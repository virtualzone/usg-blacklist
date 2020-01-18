#!/bin/bash

TODAY=`date +"%Y-%m-%d"`
CHECK_FILE="/tmp/blacklist6-$TODAY.tmp"

if [ -f $CHECK_FILE ]; then
    echo "Skipping, already run today.";
    exit 0
fi

rm -f /tmp/blacklist6-*.tmp

real_list=`grep -B1 "Dynamic Threat List IPv6" /config/config.boot | head -n 1 | awk '{print $2}'`
[[ -z "$real_list" ]] && { echo "aborting"; exit -1; } || echo "Updating $real_list (IPv6)"

num_items_before=`/sbin/ipset list $real_list | wc -l`

ipset_list='temporary-list'

sudo /sbin/ipset -! destroy $ipset_list
sudo /sbin/ipset create $ipset_list hash:net family inet6

for url in 'https://www.spamhaus.org/drop/dropv6.txt';
do
 echo "Fetching and processing $url"
 curl "$url" | awk '/^[1-9]/ { print $1 }' | xargs -n1 sudo ipset -q add $ipset_list
done

sudo /sbin/ipset swap $ipset_list $real_list
sudo /sbin/ipset destroy $ipset_list

num_items_after=`/sbin/ipset list $real_list | wc -l`

touch $CHECK_FILE

echo "===================================================="
echo "Number of items in set BEFORE update: $num_items_before"
echo "Number of items in set AFTER update:  $num_items_after"
echo "===================================================="