#
# Initial creation of initramfs inside ARM-based distro to bundle all needed libs & binaries
#
KERNEL_VERSION=....
mkinitramfs -o "/dev/shm/initramfs-$KERNEL_VERSION" "$KERNEL_VERSION"
