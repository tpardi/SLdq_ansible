#!/bin/bash

COUNT="`cat /etc/motd.count`"

NEWQUOTE=`sed "${COUNT}!d" /etc/mvq.txt`

COUNT=$((COUNT+1))

echo "$NEWQUOTE" >/etc/motd
echo "Count has been up dated to $COUNT"
echo "$COUNT" >/etc/motd.count
