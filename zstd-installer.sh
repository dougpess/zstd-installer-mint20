#!/bin/bash

apt update -qq
apt install -y checkinstall build-essential
cd $(mktemp -d)
wget https://github.com/facebook/zstd/archive/v1.4.8.tar.gz
tar -xf *.tar.gz
cd zstd-*
make
echo y | checkinstall
if ! grep -qx zstd /etc/initramfs-tools/modules; then echo zstd >> /etc/initramfs-tools/modules; fi
if ! grep -qx z3fold /etc/initramfs-tools/modules; then echo z3fold >> /etc/initramfs-tools/modules; fi
update-initramfs -u -k all
