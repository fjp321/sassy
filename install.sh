source config.sh

#make filesystems and swap
mkfs.vfat -F 32 /dev/sda1
mkfs.ext4 /dev/sda3
mkswap /dev/sda2
swapon /dev/sda2

#mount root
mount /dev/sda3 /mnt/gentoo

#change directory into mounted gentoo
cd /mnt/gentoo
