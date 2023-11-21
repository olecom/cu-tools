#!/bin/sh

set -x

IMG='initramfs-5.10.105-v8-olimex.img'
#IMG='initramfs-6.2.0-rc2-adani-olimex-2023-v5-g41c03ba9beea.img'
DST=/home/olecom/SUNXi-Boards/Adani/git-repos/cu-tools/fs-boot-disk-SUN7i-olinuxino-limeX/boot/

[ -f "./$IMG" ] && rm "$IMG"

cd initramfs-dir || exit 1
#cd initramfs-dir-linux-master || exit 1
find . | cpio --quiet -R 0:0 --device-independent -o -H newc | gzip -9 -n >"../$IMG"
cd ..
cp "$IMG" "$DST"

exit 0

#mkimage -A arm -O linux -T ramdisk -C none -a 0 -e 0 -n uInitrd -d "$P/initrd.img" "$P/uInitrd"
