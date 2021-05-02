FROM alpine:latest
ENV VERSION=2.1.5

ENV LANG=C
ENV LANGUAGE=C
ENV LC_ALL=C
ENV DISPLAY=:0
ENV _JAVA_AWT_WM_NONREPARENTING=1

RUN echo 'nameserver 8.8.8.8' > /etc/resolv.conf

RUN apk update
RUN apk --no-cache upgrade
RUN apk --no-cache add curl msitools
RUN apk --no-cache add \
    --repository https://dl-cdn.alpinelinux.org/alpine/latest-stable/community \
    openjdk8-jre
RUN rm -rf /var/cache/apk/*

RUN adduser --disabled-password osrs
RUN mkdir -p /home/osrs/osrs
RUN chown -R osrs /home/osrs
RUN chmod -R 777 /home/osrs
USER osrs

WORKDIR /tmp
RUN curl -L \
    https://runescape.com/downloads/oldschool.msi \
    --output OldSchool.msi
RUN msiextract OldSchool.msi
RUN install -D -m 777 \
    jagexlauncher/jagexlauncher/bin/jagexappletviewer.jar \
    ~/.local/share/jagexappletviewer.jar
RUN rm -r /tmp/OldSchool.msi /tmp/jagexlauncher

WORKDIR /home/osrs
CMD ["java", \
    "-Duser.home=/home/osrs", \
    "-Djava.class.path=/home/osrs/.local/share/jagexappletviewer.jar", \
    "-Dcom.jagex.config=http://oldschool.runescape.com/jav_config.ws", \
    "jagexappletviewer", \
    "/usr/local/share"]
