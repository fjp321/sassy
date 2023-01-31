#!/bin/bash
source /etc/profile
source config.sh

trap "pkill -P $$" EXIT

#network function
network () {
	echo "emerge wireless internet tools"
	echo "net-wireless/networkmanager wifi" >> /etc/portage/package.use/networkmanager
	emerge -qv --autounmask-write=y --autounmask-continue=y net-wireless/networkmanager
	emerge -qv --autounmask-write=y --autounmask-continue=y gnome-extra/nm-applet
	systemctl start NetworkManager
	systemctl enable NetworkManager
}

# command line arg flags
wifi_flag=0
gui_flag=0

while getopts "gw" options; do
        case "${options}" in
                w)
                        wifi_flag=1
                        ;;
		g)
			gui_flag=1
			;;
        esac
done

echo "mount to boot"
mount ${bootpar} /boot
echo "update bins"
emerge-webrsync
echo "set profile to desktop"
eselect profile set 5

echo "fix circ deps"
USE="-harfbuzz" emerge --autounmask-write=y --autounmask-continue=y --oneshot media-libs/freetype
echo "update world"
emerge -qv --update --deep --changed-use --autounmask-write=y --autounmask-continue=y @world

echo "adds system boot flag to systemd and reinstalls systemd"
mkdir -p /etc/portage/package.use
echo "sys-app/systemd gnuefi" >> /etc/portage/package.use/systemd

echo "set accept license to all"
echo -e ACCEPT_LICENSE=\"*\" >> /etc/portage/make.conf

echo "set timezone to newyork, america"
ln -sf /usr/share/zoneinfo/${timezone} /etc/timezone

echo "set locale"
echo en_US ISO-8859-1 >> /etc/locale.gen
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
eselect locale set 6
env-update && source /etc/profile

echo "genkernel all need to add custom kernel support"
emerge -qv --autounmask-write=y --autounmask-continue=y sys-kernel/gentoo-sources
eselect kernel set 1
emerge -qv --autounmask-write=y --autounmask-continue=y sys-kernel/genkernel
echo "setup fstab"
echo -e "${bootpar}\t/boot\text4\tdefaults,noatime\t0 2" >> /etc/fstab
genkernel all
emerge -qv sys-kernel/linux-firmware
echo "continue fstab setup"
echo -e "${swappar}\tnone\tswap\tsw\t0 0" >> /etc/fstab
echo -e "${rootpar}\t/\text4\trw,noatime\t0 1" >> /etc/fstab

#networking portion
if [ $wifi_flag = 1 ]
then 
	network
fi

echo "set host name"
hostnamectl hostname ${hostname}

echo "emerge system logger, cron daemon, mlocate for file indexing, fs tools, dhcpd to get internet and ip assignment, lynx, git, gentoolkit"
emerge -qv --autounmask-write=y --autounmask-continue=y app-admin/sysklogd net-misc/dhcpcd sys-process/dcron sys-apps/mlocate sys-fs/e2fsprogs sys-fs/dosfstools dev-vcs/git lynx gentoolkit sys-apps/iproute2

ech "add tools to systemd"
systemctl enable --now dhcpcd
systemctl enable --now sysklogd 
systemctl enable --now dcron 
crontab /etc/crontab

echo "set up systemd-boot"
bootctl install

#set root passwd
echo "THIS IS ROOT PASSWD"
passwd

useradd --create-home --groups tty,users,wheel,portage,lp,adm,audio,cdrom,disk,usb,video,cron --shell /bin/bash --comment "${main_user}" ${main_user}
echo "THIS IS ${main_user} PASSWD"
passwd ${main_user}

