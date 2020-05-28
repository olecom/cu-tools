
set -x
cd linux-sunxi-5.7

# old GCC try:
#PATH=/home/olecom/bin/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf/bin:$PATH
ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf-
export PATH CROSS_COMPILE ARCH

make menuconfig || exit
make dtbs || exit
cp arch/arm/boot/dts/sun7i-a20-olinuxino-lime2*.dtb .modules-adani-olimex

make -j4 bzImage modules || exit
make INSTALL_MOD_PATH=.modules-adani-olimex modules_install || exit

mv arch/arm/boot/zImage .modules-adani-olimex

exit

cd .modules-adani-olimex
mv ../arch/arm/boot/zImage ./
scp zImage root@192.168.1.22:/boot/zImage-5.6.rc4.linux
scp -r lib/modules/5.6.0-rc4-adani-olimex-2020-77350-g6a8c531e7c80-dirty/ root@192.168.1.22:/lib/modules


git clone git://github.com/linux-sunxi/linux-sunxi.git -b sunxi-next --depth=1

apt-get install flex bison gcc-arm-linux-gnueabihf

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- sunxi_defconfig

ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j4 bzImage modules dtbs
ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make INSTALL_MOD_PATH=.modules-adani-olimex modules_install

cp ./arch/arm/boot/zImage .modules-adani-olimex/
cp ./arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dtb .modules-adani-olimex/

: <<'___'

  INSTALL drivers/cpufreq/cpufreq_powersave.ko
  INSTALL drivers/fpga/fpga-mgr.ko
  INSTALL drivers/media/common/videobuf2/videobuf2-common.ko
  INSTALL drivers/media/common/videobuf2/videobuf2-dma-contig.ko
  INSTALL drivers/media/common/videobuf2/videobuf2-memops.ko
  INSTALL drivers/media/common/videobuf2/videobuf2-v4l2.ko
  INSTALL drivers/media/i2c/ov5640.ko
  INSTALL drivers/media/platform/sunxi/sun4i-csi/sun4i-csi.ko
  INSTALL drivers/media/platform/sunxi/sun6i-csi/sun6i-csi.ko
  INSTALL drivers/media/v4l2-core/v4l2-fwnode.ko
  INSTALL fs/ntfs/ntfs.ko
  DEPMOD  5.6.0-rc1adani-olimex-2020-gbdb5d1a70

 CONFIG_CPU_ISOLATION:                                                   │
  │                                                                         │
  │ Make sure that CPUs running critical tasks are not disturbed by         │
  │ any source of "noise" such as unbound workqueues, timers, kthreads...   │
  │ Unbound jobs get offloaded to housekeeping CPUs. This is driven by      │
  │ the "isolcpus=" boot parameter. 

Documentation/driver-api/early-userspace/early_userspace_support.rst>
Documentation/admin-guide/bootconfig.rst

[*]   Media Controller API

┌───────────────────── V4L2 sub-device userspace API ─────────────────────┐
  │ CONFIG_VIDEO_V4L2_SUBDEV_API:                                           │
  │                                                                         │
  │ Enables the V4L2 sub-device pad-level userspace API used to configure   │
  │ video format, size and frame rate between hardware blocks.              │
  │                                                                         │
  │ This API is mostly used by camera interfaces in embedded platforms.     │
  │                                                                         │
  │ Symbol: VIDEO_V4L2_SUBDEV_API [=y]                                      │
 

unctionality on V4L2 drivers ──────────┐
  │ CONFIG_VIDEO_ADV_DEBUG:                                                 │
  │                                                                         │
  │ Say Y here to enable advanced debugging functionality on some           │
  │ V4L devices.                                                            │
  │ In doubt, say N.                                                        │
  │                                                                         │
  │ Symbol: VIDEO_ADV_DEBUG [=y]      

is option.                             │
  │ Symbol: V4L_TEST_DRIVERS [=n]                                           │
  │ Type  : bool                      


[*]   V4L platform devices

┌────────────── Allwinner A10 CMOS Sensor Interface Support ──────────────┐
  │ CONFIG_VIDEO_SUN4I_CSI:                                                 │
  │                                                                         │
  │ This is a V4L2 driver for the Allwinner A10 CSI                         │
  │


───────────── Allwinner V3s Camera Sensor Interface driver ──────────────┐
  │ CONFIG_VIDEO_SUN6I_CSI:                                                 │
  │                                                                         │
  │ Support for the Allwinner Camera Sensor Interface Controller on V3s.    │
  │                                                                         │
  │ Symbol: VIDEO_SUN6I_CSI [=m]                                            │
  │ 


___

