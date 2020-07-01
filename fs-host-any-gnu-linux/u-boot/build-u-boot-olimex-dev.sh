info(){
https://linux-sunxi.org/U-Boot#Compile_U-Boot
https://www.olimex.com/wiki/ArmbianHowTo#Building_u-boot


https://linux-sunxi.org/FEL/USBBoot#Using_sunxi-fel_on_Windows
https://packages.msys2.org/package/mingw-w64-x86_64-libusb
https://zadig.akeo.ie/

http://tftpd32.jounin.net/tftpd32_download.html

git clone --depth 1 https://github.com/OLIMEX/u-boot.git
cd u-boot

# for SPI Flash boot critical to check: CONFIG_SPL_SPI_SUNXI=y
# * default:
# CONFIG_DRAM_CLK=384
# CONFIG_DRAM_MBUS_CLK=300
# * new
# CONFIG_DRAM_CLK=528
# CONFIG_DRAM_MBUS_CLK=352

make A20-OLinuXino_defconfig
make menuconfig
make CROSS_COMPILE=arm-linux-gnueabihf-
}
# install:
set -x
dd if=`echo u-boot-sunxi-with-spl.bin*` of=/dev/sdb bs=1024 seek=8 conv=fsync
