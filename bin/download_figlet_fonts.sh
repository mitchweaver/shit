#!/bin/sh

git clone https://github.com/xero/figlet-fonts.git /tmp/figlet-fonts
doas mv -f /tmp/figlet-fonts/* /usr/local/share/figlet/
