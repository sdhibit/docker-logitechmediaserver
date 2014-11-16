FROM ubuntu:trusty
MAINTAINER Steve Hibit <sdhibit@gmail.com>

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Fix a Debianism of the nobody's uid being 65534
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody

#Set Logitech Media Server Package Information
ENV PKG_NAME logitechmediaserver
ENV PKG_VER 7.8.0

# Install Logitech Media Server
RUN apt-get update && apt-get install -y --force-yes \
  locales \
  wget

# Install Logitech Media Server
RUN wget -O /tmp/${PKG_NAME}.deb http://downloads.slimdevices.com/LogitechMediaServer_v${PKG_VER}/${PKG_NAME}_${PKG_VER}_all.deb \
  && dpkg -i /tmp/${PKG_NAME}.deb

RUN chown -R nobody:users /usr/share/squeezeboxserver/

# Set Locale
ENV LANG en_US.UTF-8
RUN locale-gen $LANG

# Copy start.sh script
ADD start.sh /start.sh

 # apt clean
RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/*

# map /config
VOLUME /state
# map /media 
VOLUME /media

# expose port for http
EXPOSE 9000
# expose port for telnet
EXPOSE 9090
# Expose port
EXPOSE 3483
EXPOSE 3483/udp
#EXPOSE 631

# Run Program
USER nobody
CMD ["/start.sh"]

