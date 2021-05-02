FROM ubuntu:latest

RUN apt update && apt upgrade -y --no-install-recommends

RUN apt install -y --no-install-recommends \
    dbus-x11 \
    dunst \
    hunspell-en-us \
    python3-dbus \
    software-properties-common \
    libx11-xcb1 \
    gconf2 \
    libgtk2.0-0 \
    libgtk-3-0 \
    libxtst6 \
    libnss3 \
    libasound2 \
    libgconf-2-4 \
    libappindicator1 \
    wget \
    pulseaudio \
    fonts-noto-cjk \
    fonts-noto-color-emoji

RUN apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

RUN wget 'https://discord.com/api/download?platform=linux&format=tar.gz' \
        -O /tmp/discord.tar.gz && \
    mkdir -p /opt && \
    tar -C /opt -xvzf /tmp/discord.tar.gz && \
    rm /tmp/discord.tar.gz

RUN fc-cache -fv

ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb

RUN useradd -N -G audio,video discord
USER discord
CMD ["/opt/Discord/Discord"]
