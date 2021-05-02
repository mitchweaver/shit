#!/bin/sh

java -jar /tmp/runelite.jar

# wait for runelite to close
while pgrep -f java >/dev/null ; do
    sleep 10
done
