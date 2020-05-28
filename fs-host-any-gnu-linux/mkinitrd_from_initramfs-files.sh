#!/bin/sh
# Armbian generated "initramfs" on any host GNU/Linux
# unpack, modify
# pack all back: by this script
#

set -x

#IMG='initramfs-5.4.20-sunxi.img'

IMG='initramfs-5.7.0-rc1-adani-olimex.img'

P=$PWD
#cd "$1" || exit 1

[ -f "./$IMG" ] || {
    cd initramfs-dir || exit 1
    find . | cpio --quiet -R 0:0 --device-independent -o -H newc | gzip -9 -n >"../$IMG"
    exit 0
}

[ -f "$P/uInitrd" ] || {
    mkimage -A arm -O linux -T ramdisk -C none -a 0 -e 0 -n uInitrd -d "$P/initrd.img" "$P/uInitrd"
}
