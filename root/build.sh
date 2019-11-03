#! /bin/bash

TORRENT="http://releases.ubuntu.com/18.04/ubuntu-18.04.3-desktop-amd64.iso.torrent"

# download iso
tmpfile=$(mktemp)
chmod a+x $tmpfile
echo "killall transmission-cli" > $tmpfile
transmission-cli -f $tmpfile $TORRENT

# extract contents
cd /root/Downloads
7z x ubuntu-*.iso
mv casper/filesystem.squashfs /buildout/
mv /boot/initrd.img-* /buildout/initrd
mv /boot/vmlinuz-* /buildout/vmlinuz
sha256sum ubuntu-*.iso | cut -c1-8 > /buildout/shasum
chmod 777 /buildout/*

exit 0
