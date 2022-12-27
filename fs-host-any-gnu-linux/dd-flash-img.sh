#!/bin/sh

DST=/dev/sdc

cat /proc/partitions
echo "
Run as admin: flash
Destination device: $DST
"
[ flash = "$1" ] && {
    echo "Start flashing $DST? [y/n]"
    read A
    set -x
    [ y = "$A" ] && dd "if=`echo *.img`" "of=$DST" bs=1M conv=fsync
    sync
    set +x
}
