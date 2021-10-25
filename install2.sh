source config.sh

#mount to boot
mount ${bootpar} /boot
#update bins
emerge-webrsync
emerge --sync
eselect profile set 5
#fix circ deps
USE="-harfbuzz" emerge -qv --oneshot media-libs/freetype media-libs/harfbuzz =x11-libs/pango-1.48.5-r1
#update world
emerge -qv --ask --update --deep --changed-use --autounmask-write=y --autounmask-continue=y @world
#set accept license to all
echo -e ACCEPT_LICENSE=\"*\" >> /etc/portage/make.conf
#set timezone to newyork, america
echo America/New_York > /etc/timezone
emerge -qv --config sys-libs/timezone-data
#set lcoale
echo en_US ISO-8859-1 >> /etc/locale.gen
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
eselect locale set 6
env-update && source /etc/profile
#genkernel
emerge -qv --autounmask-write=y --autounmask-continue=y sys-kernel/gentoo-sources
eselect kernel set 1
emerge -qv --autounmask-write=y --autounmask-continue=y sys-kernel/genkernel
#setup stab
echo -e "${bootpar}\t/boot\text4\tdefaults,noatime\t0 2" >> /etc/fstab
genkernel all
emerge -qv sys-kernel/linux-firmware
#continue fstab setup
echo -e "${swappar}\tnone\tswap\tsw\t0 0" >> /etc/fstab
echo -e "${rootpar}\t/\text4\trw,noatime\t0 1" >> /etc/fstab
#set host name
sed -i 's/hostname="localhost"/hostname="bristlecone"/' /etc/conf.d/hostname
#emerge system logger
emerge -qv --autounmask-write=y --autounmask-continue=y app-admin/sysklogd 
#emerge cron daemon
emerge -qv --autounmask-write=y --autounmask-continue=y sys-process/dcron
#emerge mlocate for file indexing
emerge -qv --autounmask-write=y --autounmask-continue=y sys-apps/mlocate 
# emerge fs tools 
emerge -qv --autounmask-write=y --autounmask-continue=y sys-fs/e2fsprogs 
emerge -qv --autounmask-write=y --autounmask-continue=y sys-fs/dosftools 
#emerge dhcpd to get internet and ip assignment
emerge -qv --autounmask-write=y --autounmask-continue=y net-misc/dhcpcd 
#emerge wireless internet tools
emerge -qv --autounmask-write=y --autounmask-continue=y net-wireless/iw 
emerge -qv --autounmask-write=y --autounmask-continue=y net-wireless/wpa_supplicant
#add tools to rc
rc-update add sysklogd default
rc-update add dcron default
# set up grub
echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
emerge -qv --autounmask-write=y --autounmask-continue=y sys-boot/grub:2
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
#set root passwd
passwd
