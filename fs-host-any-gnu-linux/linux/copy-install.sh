
cd linux-sunxi-5.7/.modules-adani-olimex/

scp zImage root@192.168.1.22:/boot/
scp *.dtb root@192.168.1.22:/boot/dtb

cd lib/modules/5.7.0-rc1-adani-olimex-2020-v1-g8f3d9f354-dirty/
rm build source
scp -r ../5.7.0-rc1-adani-olimex-2020-v1-g8f3d9f354-dirty root@192.168.1.22:/lib/modules/
