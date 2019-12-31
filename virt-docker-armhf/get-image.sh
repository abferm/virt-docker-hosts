#!/bin/bash
set -e

UBUNTU_RELEASE=bionic

wget -O ubuntu.img https://cloud-images.ubuntu.com/${UBUNTU_RELEASE}/current/${UBUNTU_RELEASE}-server-cloudimg-armhf.img
wget -O kernel http://cloud-images.ubuntu.com/${UBUNTU_RELEASE}/current/unpacked/${UBUNTU_RELEASE}-server-cloudimg-armhf-vmlinuz-lpae
wget -O initrd http://cloud-images.ubuntu.com/${UBUNTU_RELEASE}/current/unpacked/${UBUNTU_RELEASE}-server-cloudimg-armhf-initrd-generic-lpae

# sudo virt-copy-in -a ubuntu.img sshd_config /etc/ssh/

sudo virt-customize -a ubuntu.img --password root:password:root
