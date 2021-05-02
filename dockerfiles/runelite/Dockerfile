FROM alpine:latest

ENV VERSION=2.1.5

ENV LANG=C
ENV LANGUAGE=C
ENV LC_ALL=C
ENV DISPLAY=:0
ENV _JAVA_AWT_WM_NONREPARENTING=1

RUN printf '%s\n%s\n' \
        'nameserver 8.8.8.8' \
        'nameserver 1.1.1.1' \
        > /etc/resolv.conf

RUN apk update
RUN apk --no-cache upgrade
RUN apk --no-cache add curl pulseaudio dbus ttf-dejavu
RUN apk --no-cache add \
    --repository https://dl-cdn.alpinelinux.org/alpine/latest-stable/community \
    openjdk11-jre
RUN rm -rf /var/cache/apk/*

# setup pulseaudio access to the host's pulseaudio server
RUN mkdir -p /var/run/dbus
RUN dbus-uuidgen > /var/lib/dbus/machine-id
RUN dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address
COPY client.conf /etc/pulse/client.conf

RUN adduser --uid 1000 \
        -G video -G audio -G pulse -G pulse-access \
        --disabled-password runelite
RUN mkdir -p /home/runelite
RUN chown -R runelite /home/runelite
RUN chmod -R 777 /home/runelite

RUN curl -L "https://github.com/runelite/launcher/releases/download/$VERSION/RuneLite.jar" > /tmp/runelite.jar

USER runelite
COPY entrypoint.sh /
CMD ["sh", "/entrypoint.sh"]
