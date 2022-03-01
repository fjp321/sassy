emerge_flags="-qv --autounmask=y --autounmask-write=y --autounmask-continue=y"
main_user=fjp
useradd --create-home --groups tty,users,wheel,portage,lp,adm,audio,cdrom,disk,usb,video,cron --shell /bin/bash --comment "${main_user}" ${main_user}
passwd ${main_user}
rm /stage3* /install2.sh /config.sh

#packages for gui
emerge ${emerge_flags} x11-base/xorg-server x11-drivers/xf86-input-evdev lynx gentoolkit firefox neofetch x11-terms/st dev-vcs/git calcurse feh dev-python/pip libreoffice app-editors/vim neomutt app-eselect/eselect-repository lightdm openbox

#note; use cordless as client for discord

rc-update add elogind boot
/etc/init.d/elogind/start
