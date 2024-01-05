#!/bin/sh
# "$1" -- if set, skip menu && building bzImage, only dtb and modules
# "$1" = 'd' name csi driver as dummy in cu-tools directory
# "$1" = 'i' -- install modules

set +e

# goto own directory
cd "${0%/*}" 2>/dev/null || :

LINUX_IMAGE_NAME=zImage-5.10.105-v8.linux

GIT_REPO_MODULES=/home/olecom/SUNXi-Boards/Adani/git-repos/cu-linux-drivers
DST=/home/olecom/SUNXi-Boards/Adani/git-repos/cu-tools/fs-boot-disk-SUN7i-olinuxino-limeX/boot
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

[ -d '.modules-olimex' ] || mkdir '.modules-olimex'

# copy some existing config file manually if needed
[ "$1" ] || make menuconfig

make dtbs
make -j4 modules

[ "$1" ] || {
    make -j4 bzImage && cp 'arch/arm/boot/zImage' "$DST/$LINUX_IMAGE_NAME"
}

[ 'i' = "$1" -o 'd' = "$1" -o -z "$1" ] && {
    rm -rf "$INITRAMFS/lib/modules/"* .modules-olimex/lib/modules/*
    make INSTALL_MOD_PATH=.modules-olimex modules_install >/dev/null
    echo '
Copy modules to initramfs'
    cp -r .modules-olimex/lib/modules/* "$INITRAMFS/lib/modules/"
}

cp arch/arm/boot/dts/sun7i-a20-olinuxino-lime*.dtb .modules-olimex

echo "
Copy resulting files into: '$DST'"

cd '.modules-olimex'
cp ./lib/modules/*/kernel/drivers/media/i2c/* \
   ./lib/modules/*/kernel/drivers/media/platform/sunxi/sun4i-csi/* \
   *.dtb \
   "$DST"
cp ../.config /home/olecom/SUNXi-Boards/Adani/git-repos/cu-tools/fs-host-any-gnu-linux/linux-olimex/

test 'd' = "$1" && mv "$DST/sun4i-csi.ko" "$DST/sun4i-csi_dummy.ko"

echo '
Olimex repo based linux kernel is ready!'

exit
