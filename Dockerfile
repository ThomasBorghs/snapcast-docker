FROM node:16.19-bullseye
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libasound2 \
    alsa-utils \
    alsa-topology-conf \
    alsa-ucm-conf
#    alsa-tools \
#    alsaplayer-common \
#    alsaplayer-alsa \
#    alsaplayer-daemon
#    kmod \

#    libasound2-plugins \


#    alsa-base \

#    alsa-source \
#    linux-headers-2.6.32-5-common \
#    linux-headers-2.6.32-5-686

#RUN wget "https://www.alsa-project.org/files/files/pub/driver/alsa-driver-1.0.25.tar.bz2" -O /usr/src/alsa-driver-1.0.25.tar.bz2
#RUN tar xvfj alsa-driver-1.0.25.tar.bz2
#WORKDIR /usr/src/modules/alsa-driver
#RUN dpkg-reconfigure alsa-source
#RUN fakeroot debian/rules binary_modules KSRC=/usr/src/linux-headers-2.6.32-5-686 KVERS=2.6.32-5-686
#RUN dpkg --install /usr/src/modules/alsa-modules-2.6.32-5-686_1.0.23+dfsg-2_i386.deb

RUN wget "https://github.com/badaix/snapcast/releases/download/v0.26.0/snapserver_0.26.0-1_amd64.deb" -O /tmp/snapserver.deb
RUN dpkg -i --force-all /tmp/snapserver.deb
RUN apt-get -f install -y

RUN wget "https://plexamp.plex.tv/headless/Plexamp-Linux-headless-v4.6.1.tar.bz2" -O /tmp/Plexamp-Linux-headless-v4.6.1.tar.bz2
RUN tar -xf /tmp/Plexamp-Linux-headless-v4.6.1.tar.bz2 -C /

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 32500/tcp
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]