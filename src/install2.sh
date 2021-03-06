#!/bin/bash
source /etc/profile
source config.sh

trap "pkill -P $$" EXIT

#network function
network () {
	#emerge wireless internet tools
	emerge -qv --autounmask-write=y --autounmask-continue=y net-wireless/wpa_supplicant
	ln -s /etc/init.d/net.lo /etc/init.d/net.${wifi_dev}
	echo -e "config.${wifi_dev}=\"dhcp\"\nmodules=\"wpa_supplicant\"" >> /etc/conf.d/net
	echo -e "ctrl_interface=/var/run/wpa_supplicant\nctrl_interface_group=0\nnap_scan=1\nnetwork={\n\tssid=\"${wifi_ssid}\"\n\tpsk=\"${wifi_pass}\"\n\tprioirt=5\n}" >> /etc/wpa_supplicant/wpa_supplicant.conf
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

#mount to boot
mount ${bootpar} /boot
#update bins
emerge-webrsync
#set profile to desktop
eselect profile set 5

#fix circ deps
USE="-harfbuzz" emerge --autounmask-write=y --autounmask-continue=y --oneshot media-libs/freetype
#update world
emerge -qv --update --deep --changed-use --autounmask-write=y --autounmask-continue=y @world

#set accept license to all
echo -e ACCEPT_LICENSE=\"*\" >> /etc/portage/make.conf

#set timezone to newyork, america
echo ${timezone} > /etc/timezone
emerge -qv --config sys-libs/timezone-data

#set locale
echo en_US ISO-8859-1 >> /etc/locale.gen
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
eselect locale set 6
env-update && source /etc/profile

#genkernel all !!add custom kernel support!!
emerge -qv --autounmask-write=y --autounmask-continue=y sys-kernel/gentoo-sources
eselect kernel set 1
emerge -qv --autounmask-write=y --autounmask-continue=y sys-kernel/genkernel
#setup fstab
echo -e "${bootpar}\t/boot\text4\tdefaults,noatime\t0 2" >> /etc/fstab
genkernel all
emerge -qv sys-kernel/linux-firmware
#continue fstab setup
echo -e "${swappar}\tnone\tswap\tsw\t0 0" >> /etc/fstab
echo -e "${rootpar}\t/\text4\trw,noatime\t0 1" >> /etc/fstab

#networking portion
if [ $wifi_flag = 1 ]
then 
	network
fi

#set host name
sed -i 's/hostname="localhost"/hostname="/${hostname}"/' /etc/conf.d/hostname

#emerge system logger, cron daemon, mlocate for file indexing, fs tools, dhcpd to get internet and ip assignment, lynx, git, gentoolkit
emerge -qv --autounmask-write=y --autounmask-continue=y app-admin/sysklogd net-misc/dhcpcd sys-process/dcron sys-apps/mlocate sys-fs/e2fsprogs sys-fs/dosfstools dev-vcs/git lynx gentoolkit

#add tools to rc
rc-update add dhcpcd default
rc-update add sysklogd default
rc-update add dcron default
crontab /etc/crontab

# set up grub
echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
emerge -qv --autounmask-write=y --autounmask-continue=y sys-boot/grub:2
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg

#set root passwd
echo "THIS IS ROOT PASSWD"
passwd

useradd --create-home --groups tty,users,wheel,portage,lp,adm,audio,cdrom,disk,usb,video,cron --shell /bin/bash --comment "${main_user}" ${main_user}
echo "THIS IS ${main_user} PASSWD"
passwd ${main_user}

if [ $gui_flag = 1 ]
then
	emerge -qv --autounmask-write=y --autounmask-continue=y x11-base/xorg-server x11-drivers/xf86-input-evdev firefox neofetch x11-terms/st calcurse feh dev-python/pip libreoffice app-editors/vim neomutt app-eselect/eselect-repository lightdm openbox x11-misc/lightdm-mini-greeter
	mkdir /etc/share/wallpapers && cd /etc/share/wallpapers
	wget https://raw.github.com/fjp321/sassy/main/extra/cyber_porsche.png
	wget https://raw.github.com/fjp321/sassy/main/extra/cyber_porsche_blur.png
	
fi
