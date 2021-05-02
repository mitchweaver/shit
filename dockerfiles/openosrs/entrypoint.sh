#!/bin/sh

java -jar /tmp/openosrs.jar

# wait for openosrs to close
while pgrep -f java >/dev/null ; do
    sleep 5
done
