
useradd -m -G users,wheel,audio -s /bin/bash fjp
passwd fjp
rm /stage3* /install2.sh /config.sh
##install lxde
# base lxde gtk theme
emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxappearance
#default config files
emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxde-common 
#icon library for lxde
emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxde-icon-theme
#lxmenu app menu manaage
emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxmenu-data
#keyboard mouse config
emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxinput
#polybar bar
emerge --autounmask-write=y --autounmask-continue=y x11-misc/polybar
#graphical interface for resie 
emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxrandr
#session manager, shitdown reboot suspend etc
emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxsession 
#starup applications
emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxsession-edit 
#edit application shortcuts
emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxshortcut
#task manager
emerge --autounmask-write=y --autounmask-continue=y lxde-base/lxtask
# terminal emulator 
emerge --autounmask-write=y --autounmask-continue=y x11-terms/kitty
# file manager thunar
emerge --autounmask-write=y --autounmask-continue=y xfce-base/thunar
# display manager
emerge --autounmask-write=y --autounmask-continue=y x11-misc/sddm
#window manager
emerge --autounmask-write=y --autounmask-continue=y x11-wm/openbox
