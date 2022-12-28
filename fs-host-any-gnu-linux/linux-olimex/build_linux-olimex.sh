#!/bin/sh
# "$1" -- if set, skip menu && building bzImage, only dtb and modules
# "$1" = 'i' -- install modules

set +x +e

# goto own directory
cd "${0%/*}" 2>/dev/null || :

LINUX_IMAGE_NAME=zImage_Display-5.10.105.linux

GIT_REPO_MODULES=/home/olecom/SUNXi-Boards/Adani/git-repos/adani-linux-drivers
DST=/home/olecom/SUNXi-Boards/Adani/git-repos/adani-cu-tools/fs-boot-disk-SUN7i-olinuxino-lime2/boot
INITRAMFS=/home/olecom/SUNXi-Boards/Armbian/initramfs-files/initramfs-dir

ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf-
export CROSS_COMPILE ARCH

[ -d 'linux-olimex' ] && cd linux-olimex

SRC=drivers/media/i2c/ov5640.c
GIT=$GIT_REPO_MODULES/i2c-cameras/ov5640.c
test -f "$GIT" || cp "$SRC" "$GIT"
test ! -L "$SRC" \
    -a \
       -f "$GIT" && {
    mv "$SRC" "$SRC.orig"
    ln -s "$GIT" "$SRC"
}

SRC=arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
GIT=$GIT_REPO_MODULES/dts/sun7i-a20-olinuxino-lime2.dts
test -f "$GIT" || cp "$SRC" "$GIT"
test ! -L "$SRC" && {
    mv "$SRC" "$SRC.orig"
    ln -s "$GIT" "$SRC"
}

SRC=drivers/media/platform/sunxi/sun4i-csi
GIT=$GIT_REPO_MODULES/csi-dvp-controllers/sun4i-csi
test -d "$GIT" || cp -r "$SRC" "$GIT"
test ! -L "$SRC" && {
    mv "$SRC" "$SRC.orig"
    ln -s "$GIT" "$SRC"
}

[ -d '.modules-adani-olimex' ] || mkdir '.modules-adani-olimex'

# copy some existing config file manually if needed
[ "$1" ] || make menuconfig

make dtbs
make -j4 modules

[ "$1" ] || {
    make -j4 bzImage
    mv arch/arm/boot/zImage .modules-adani-olimex
}

[ 'i' = "$1" -o -z "$1" ] && {
    make INSTALL_MOD_PATH=.modules-adani-olimex modules_install >/dev/null
    echo '
Copy modules to initramfs'
    rm -rf "$INITRAMFS/lib/modules/"*
    cp -r .modules-adani-olimex/lib/modules/* "$INITRAMFS/lib/modules/"
}

cp arch/arm/boot/dts/sun7i-a20-olinuxino-lime2*.dtb .modules-adani-olimex

echo "
Copy resulting files into: '$DST'"

cd '.modules-adani-olimex'
cp ./lib/modules/*-olimex-*/kernel/drivers/media/i2c/* \
   ./lib/modules/*-olimex-*/kernel/drivers/media/platform/sunxi/sun4i-csi/* \
   *.dtb \
   ../.config \
   "$DST"
cp 'zImage' "$DST/$LINUX_IMAGE_NAME"

echo '
Olimex repo based linux kernel is ready!'

exit
