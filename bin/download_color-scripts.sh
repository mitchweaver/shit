#!/bin/sh

git clone https://github.com/stark/color-scripts /tmp/color-scripts
mv /tmp/color-scripts/color-scripts/* ~/.local/bin/
rm ~/.local/bin/pacman
