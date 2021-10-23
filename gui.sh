
useradd -m -G users,wheel,audio -s /bin/bash fjp
passwd fjp
rm /stage3* /install2.sh /config.sh

emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxappearance

emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxde-common 

emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxde-icon-theme

emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxmenu-data

emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxinput

emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxpanel

emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxrandr

emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxsession 

emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxsession-edit 

emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxshortcut
# 
emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxtask
# terminal emulator 
emerge --autounmask-write=y --autounmask-continue=y x11-terms/kitty
# file manager thunar
emerge --autounmask-write=y --autounmask-continue=y xfce-base/thunar
