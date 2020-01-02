#!/bin/bash
set -e

UBUNTU_RELEASE=$1
ARCH=$2

if [ "$ARCH" == "armhf" ]; then
    KERNEL_EXTENSION=-lpae
    INITRD_EXTENSION=-generic-lpae
else
    KERNEL_EXTENSION=-generic
    INITRD_EXTENSION=-generic
fi

wget -O ubuntu.img https://cloud-images.ubuntu.com/${UBUNTU_RELEASE}/current/${UBUNTU_RELEASE}-server-cloudimg-${ARCH}.img
wget -O kernel http://cloud-images.ubuntu.com/${UBUNTU_RELEASE}/current/unpacked/${UBUNTU_RELEASE}-server-cloudimg-${ARCH}-vmlinuz${KERNEL_EXTENSION}
wget -O initrd http://cloud-images.ubuntu.com/${UBUNTU_RELEASE}/current/unpacked/${UBUNTU_RELEASE}-server-cloudimg-${ARCH}-initrd${INITRD_EXTENSION}

virt-customize -a ubuntu.img --password root:password:root
