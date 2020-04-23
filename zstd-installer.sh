#!/bin/bash

apt update -qq
apt install -y checkinstall build-essential
cd $(mktemp -d)
wget https://github.com/facebook/zstd/releases/download/v1.4.4/zstd-1.4.4.tar.gz -O zstd.tar.gz
tar -xf zstd.tar.gz
cd zstd-*
make
echo y | checkinstall
if ! grep -qx zstd /etc/initramfs-tools/modules; then echo zstd >> /etc/initramfs-tools/modules; fi
if ! grep -qx zstd_compress /etc/initramfs-tools/modules; then echo zstd_compress >> /etc/initramfs-tools/modules; fi
if ! grep -qx z3fold /etc/initramfs-tools/modules; then echo z3fold >> /etc/initramfs-tools/modules; fi
update-initramfs -u -k all
