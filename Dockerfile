FROM ubuntu:bionic

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV XDG_CONFIG_HOME="/config/xdg"

RUN \
 echo "**** install deps ****" && \
 apt-get update && \
 apt-get install -y \
	p7zip-full \
	initramfs-tools \
	live-boot \
	pixz \
	psmisc \
	transmission-cli && \
 echo "**** install kernel ****" && \
 apt-get install -y \
	linux-image-virtual && \
 echo "**** clean up ****" && \
 mkdir /buildout && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY /root /

ENTRYPOINT [ "/build.sh" ]
