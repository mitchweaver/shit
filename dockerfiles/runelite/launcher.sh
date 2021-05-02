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

# folder for settings/screenshots/cache to be saved
mkdir -p runelite jagexcache

# if using pulseaudio, allow for container to connect to pulseaudio daemon
if pgrep pulseaudio >/dev/null ; then
    # set up pulseaudio to read/write from a socket allowing both users to connect at the same time
    echo 'load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1' | \
    sudo tee -a /etc/pulse/default.pa

    echo 'auto-connect-localhost = yes' | \
    sudo tee -a /etc/pulse/client.conf

    systemctl restart --user pulseaudio
fi

# allow container to access the host's display
xhost +local: >/dev/null

command -v sudo >/dev/null && sudo=sudo
$sudo docker build --tag runelite .
$sudo docker run --rm -d \
    --name runelite \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /etc/localtime:/etc/localtime:ro \
    -v /etc/alsa:/etc/alsa \
    -v /usr/share/alsa:/usr/share/alsa \
    -v "/run/user/$(id -u)/pulse:/run/user/1000/pulse" \
    --dns 8.8.8.8 \
    --mac-address "$(getmac)" \
    --mount type=bind,source="$PWD"/runelite,target=/home/runelite/.runelite \
    --mount type=bind,source="$PWD"/jagexcache,target=/home/runelite/jagexcache \
    runelite
