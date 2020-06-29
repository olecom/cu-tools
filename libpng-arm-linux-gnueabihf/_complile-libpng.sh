
get(){
echo 'download sources and unzip them'
tar -xzf zlib-1.2.11.tar.gz
tar -xzf libpng-1.6.37.tar.gz
}


ZLIB_PATH=/home/olecom/SUNXi-Boards/zlib-install
LIBPNG_PATH=/home/olecom/SUNXi-Boards/libpng-install

zlib() {
echo 'compile zlib'
cd zlib-1.2.11

CC=arm-linux-gnueabihf-gcc ./configure --prefix="$ZLIB_PATH" && make && make install

exit

cd ..
}

echo 'compile libpng'

cd libpng-1.6.37

./configure --host=arm-linux-gnueabihf CC=arm-linux-gnueabihf-gcc \
 "CPPFLAGS=-mfpu=neon -I$ZLIB_PATH/include/" "LDFLAGS=-L$ZLIB_PATH/lib/" \
"--prefix=$LIBPNG_PATH" && make && make install

exit
