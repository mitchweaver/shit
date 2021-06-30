#!/bin/sh

# 4k=192
# 720=96

sed -i 's/192/96/' ~/.Xresources
xrdb load ~/.Xresources

xrandr --output DisplayPort-0 --primary --mode 1280x720 --pos 0x0 --rotate normal --output DisplayPort-1 --mode 1920x1080 --pos 1280x0 --rotate normal --output DisplayPort-2 --off --output HDMI-A-0 --off
