#!/bin/sh

# return a random mac address
getmac() {
    for i in python3 pip3 ; do
        if ! command -v $i >/dev/null ; then
            >&2 echo "install $i stupid!"
            exit 1
        fi
    done
    pip3 -q install --user randmac >/dev/null 2>&1
    python3 -c 'import randmac ; print(randmac.RandMac("00:00:00:00:00:00"))'
}

mkdir -p jagexcache

command -v sudo >/dev/null && sudo=sudo
$sudo docker build --tag osrs .
$sudo docker run --rm -d \
    --name osrs \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /etc/localtime:/etc/localtime:ro \
    --dns 8.8.8.8 \
    --mac-address "$(getmac)" \
    --mount type=bind,source="$PWD"/jagexcache,target=/home/osrs/jagexcache \
    osrs
