#!/bin/sh -e

ver=2.1.0

for font in \
    Terminus ShareTechMono RobotoMono
do
    if [ ! -d ~/.fonts/$font ] ; then
        mkdir -p "/tmp/${0##*/}"
        cd "/tmp/${0##*/}"
        curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v$ver/$font.zip -o $font.zip
        unzip $font.zip
        rm $font.zip
        mkdir -p ~/.fonts/$font
        mv -f -- *.ttf ~/.fonts/$font/
    fi
done

rm -r "/tmp/${0##*/}"

find ~/.fonts -type d ! -name ~/.fonts | \
while read -r dir ; do
    cd "$dir"
    mkfontscale .
    mkfontdir .
done
