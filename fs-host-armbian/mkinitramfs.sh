#
# Initial creation of initramfs inside ARM-based distro to bundle all needed libs & binaries
#

KERNEL_VERSION=5.10.105-adani-olimex-2022-v4-g1b955f3ee7ef-dirty
mkinitramfs -o "/root/initramfs-$KERNEL_VERSION" "$KERNEL_VERSION"
