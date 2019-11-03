FROM ubuntu:bionic

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV XDG_CONFIG_HOME="/config/xdg"

# add local files
COPY /root /

RUN \
 echo "**** install deps ****" && \
 apt-get update && \
 apt-get install -y \
	casper \
	curl \
	initramfs-tools \
	p7zip-full \
	patch \
	pixz \
	psmisc \
	transmission-cli \
	wget && \
 echo "**** patch casper ****" && \
 patch /usr/share/initramfs-tools/scripts/casper < /patch && \
 echo "**** install kernel ****" && \
 apt-get install -y \
	linux-image-virtual && \
 echo "**** clean up ****" && \
 mkdir /buildout && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

ENTRYPOINT [ "/build.sh" ]
