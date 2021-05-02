#!/bin/sh
#
# creates the virtual network for docker to bind to
#
# This allows docker to be able to be run while the host
# has openvpn running.
#
# NOTE: this has proven to be VERY slow, looking into a fix
#

# re-run script with sudo if we aren't root
if [ "$(id -u)" -ne 0 ] ; then
    sudo "$0"
    exit $?
fi

docker network create localdev --subnet 10.0.1.0/24
