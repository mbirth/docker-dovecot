#!/bin/bash
WHEREAMI=$(dirname $0)
TODAY=$(date +'%Y-%m-%d')
echo "Today: $TODAY"
echo "Location: $WHEREAMI"
docker build -t "dovecot:$TODAY" -t "dovecot:latest" "$WHEREAMI/"

