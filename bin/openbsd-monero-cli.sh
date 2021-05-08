#!/bin/sh -x

# grabs and builds moenro-cli wallet on openbsd 
# because im too lazy to make port for this

doas pkg_add -D snap cmake gmake zeromq libiconv boost git

git clone https://github.com/monero-project/monero
cd monero
git submodule update --init --force

ulimit -d 2000000

env \
    DEVELOPER_LOCAL_TOOLS=1 \
    BOOST_ROOT=/usr/local \
    gmake release-static
