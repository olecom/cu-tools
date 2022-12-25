#!/bin/sh

set -x -e

cd linux-olimex

[ -d '.modules-adani-olimex' ] || mkdir '.modules-adani-olimex'

ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf-
export PATH CROSS_COMPILE ARCH

# copy some existing config file manually
make menuconfig
make dtbs
cp arch/arm/boot/dts/sun7i-a20-olinuxino-lime2*.dtb .modules-adani-olimex

make -j4 bzImage modules
make INSTALL_MOD_PATH=.modules-adani-olimex modules_install

mv arch/arm/boot/zImage .modules-adani-olimex

echo 'Olimex repo based linux kernel is ready!'

exit
