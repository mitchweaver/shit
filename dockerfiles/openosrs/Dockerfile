FROM alpine:latest

ENV VERSION=2.2.0

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
        --disabled-password openosrs
RUN mkdir -p /home/openosrs
RUN chown -R openosrs /home/openosrs
RUN chmod -R 777 /home/openosrs

RUN curl -L "https://github.com/open-osrs/launcher/releases/download/$VERSION/OpenOSRS.jar" > /tmp/openosrs.jar

USER openosrs
COPY entrypoint.sh /
CMD ["sh", "/entrypoint.sh"]
