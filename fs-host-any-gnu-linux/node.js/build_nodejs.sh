#!/bin/sh

V='v10.9.0'
set -x -e

# apt-get install g++-arm-linux-gnueabihf libc6-dev:i386 g++-multilib

[ -d install ] || mkdir install

[ -d node-$V ] || {
curl -RLO https://nodejs.org/dist/$V/node-$V.tar.xz
tar xvJf node-$V.tar.xz
}
cd node-$V

#exit

PATH=/home/olecom/bin/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf/bin:$PATH

env \
CC=arm-linux-gnueabihf-gcc \
CXX=arm-linux-gnueabihf-g++ \
CC_host="gcc -m32" \
CXX_host="g++ -m32" \
./configure \
--prefix=../install \
--dest-cpu=arm \
--cross-compiling \
--dest-os=linux \
--with-arm-float-abi=hard --with-arm-fpu=neon \
--without-intl \
--without-node-snapshot \
--without-node-code-cache \
--without-dtrace \
--without-etw \
--without-npm \
--without-report \
--without-ssl || exit

env \
CC=arm-linux-gnueabihf-gcc \
CXX=arm-linux-gnueabihf-g++ \
CC_host="gcc -m32" \
CXX_host="g++ -m32" \
make -j4

echo "$?"
