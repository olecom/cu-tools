#!/bin/sh

clone() {
# get sources:
# On branch release-20210318-v5.10.23
git clone https://github.com/OLIMEX/linux-olimex --depth=1
# On branch release-20210317
git clone https://github.com/OLIMEX/u-boot-olinuxino --depth=1
}

