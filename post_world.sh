source config.sh
echo -e ACCEPT_LICENSE=\"*\" >> /etc/portage/make.conf
echo America/New_York > /etc/timezone
emerge --config sys-libs/timezone-data
echo en_US ISO-8859-1 >> /etc/locale.gen
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
eselect locale set 6
env-update && source /etc/profile
emerge --autounmask-write=y --autounmask-continue=y sys-kernel/gentoo-sources
eselect kernel set 1
emerge --autounmask-write=y --autounmask-continue=y sys-kernel/genkernel
echo -e "${bootpar}\t/boot\text4\tdefaults,noatime\t0 2" >> /etc/fstab
genkernel all
emerge --autounmask-write=y --autounmask-continue=y sys-kernel/linux-firmware
echo -e "${swappar}\tnone\tswap\tsw\t0 0" >> /etc/fstab
echo -e "${rootpar}\t/\text4\trw,noatime\t0 1" >> /etc/fstab
sed -i 's/hostname="localhost"/hostname="bristlecone"/' /etc/conf.d/hostname
emerge --autounmask-write=y --autounmask-continue=y app-admin/sysklogd sys-process/cronie sys-apps/mlocate sys-fs/e2fsprogs sys-fs/dosftools net-misc/dhcpcd net-wireless/iw net-wireless/wpa_supplicant
rc-update add sysklogd default
rc-update add cronie default
echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
emerge --autounmask-write=y --autounmask-continue=y sys-boot/grub:2
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
