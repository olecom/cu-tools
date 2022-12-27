#!/bin/sh

set -x

IMG='initramfs-5.10.105-adani-olimex.img'
DST=/home/olecom/SUNXi-Boards/Adani/git-repos/adani-cu-tools/fs-boot-disk-SUN7i-olinuxino-lime2/boot/

[ -f "./$IMG" ] && rm "$IMG"

cd initramfs-dir || exit 1
find . | cpio --quiet -R 0:0 --device-independent -o -H newc | gzip -9 -n >"../$IMG"
cd ..
cp "$IMG" "$DST"

exit 0

#mkimage -A arm -O linux -T ramdisk -C none -a 0 -e 0 -n uInitrd -d "$P/initrd.img" "$P/uInitrd"
