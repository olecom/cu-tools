https://linux-sunxi.org/Mainline_U-Boot#Booting_with_extlinux.conf

Look at what place we have SD Flash card: cat /proc/partitions
Normal look:
...
   8    16  15558144 sdb
   8    17     15360 sdb1   E:\


u-boot install to a SD Flash card:
dd if=./u-boot-sunxi-with-spl.bin of=/dev/sdb bs=1024 seek=8

u-boot SPI Flash install:
root@raspberrypi:/home/pi/A20-boot# sunxi-fel -p spiflash-write 0 u-boot-sunxi-with-spl.bin
100% [================================================]   463 kB,   32.5 kB/s
build config needs: CONFIG_SPL_SPI_SUNXI=y

U-Boot u-boot-sunxi-with-spl*.bin files files are in: fs-host-any-gnu-linux/u-boot/
