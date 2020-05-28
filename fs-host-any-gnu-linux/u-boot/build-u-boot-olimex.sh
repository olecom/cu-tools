#!/bin/sh
#
# binary is in: //fs-boot-disk-SUN7i-olinuxino-lime2/boot/extlinux/u-boot-sunxi-with-spl.bin
#
# install:
# dd if=u-boot-sunxi-with-spl.bin bs=1024 seek=8 of=/dev/sdb conv=fsync
#

init(){
apt-get install gcc-8-arm-linux-gnueabihf python3-dev python3-distutils dfu-util swig

#git clone --depth 1 https://github.com/OLIMEX/u-boot.git
#cd u-boot

git clone https://github.com/olimage/u-boot-olinuxino.git --depth=1 -b v2020.01
git checkout -b v2020.01

#make A20-OLinuXino-Lime_defconfig

# no changes in this for FAT boot:
make A20-OLinuXino-Lime2_defconfig

}


#cd u-boot-olinuxino
cd u-boot-olimex-dev
#cd u-boot-master || exit 1
make menuconfig
make CROSS_COMPILE=arm-linux-gnueabihf-
mv u-boot-sunxi-with-spl.bin ../
cd -
