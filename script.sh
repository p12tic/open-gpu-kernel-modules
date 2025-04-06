#!/bin/bash

BRANCH=570.133.20

curl -o source.deb https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/nvidia-kernel-open-dkms_$BRANCH-1_amd64.deb

rm -rf source-deb
dpkg-deb -R source.deb source-deb

make modules -j$(nproc)

cp kernel-open/nvidia/nv-pci.c source-deb/usr/src/nvidia-$BRANCH/nvidia/nv-pci.c

cp src/nvidia/_out/Linux_x86_64/nv-kernel.o source-deb/usr/src/nvidia-$BRANCH/nvidia/nv-kernel.o_binary

cp src/nvidia-modeset/_out/Linux_x86_64/nv-modeset-kernel.o source-deb/usr/src/nvidia-$BRANCH/nvidia-modeset/nv-modeset-kernel.o_binary

dpkg-deb -b source-deb nvidia-kernel-open-dkms-p2p_$BRANCH-1_amd64.deb
