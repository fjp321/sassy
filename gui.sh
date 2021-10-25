useradd -m -G users,wheel,audio -s /bin/bash fjp
passwd ${main_user}
rm /stage3* /install2.sh /config.sh

#xorg
emerge -qv --autounmask-write=y --autounmask-continue=y x11-base/xorg-server
env-update
source /etc/profile

#font 
emerge -qv --autounmask-write=y --autounmask-continue=y media-fonts/liberation-fonts

# display manager
emerge -qv --autounmask-write=y --autounmask-continue=y x11-misc/lightdm

#window manager
emerge -qv --autounmask-write=y --autounmask-continue=y x11-wm/openbox
emerge -qv --autounmask-write=y --autounmask-continue=y x11-misc/menumaker
emerge -qv --autounmask-write=y --autounmask-continue=y x11-misc/obconf
emerge -qv --autounmask-write=y --autounmask-continue=y x11-plugins/docker
emerge -qv --autounmask-write=y --autounmask-continue=y app-admin/sudo
echo '' >>

# terminal emulator 
emerge -qv --autounmask-write=y --autounmask-continue=y x11-terms/terminator

# file manager thunar
emerge -qv --autounmask-write=y --autounmask-continue=y x11-misc/spacefm

# word editor
emerge -qv --autounmask-write=y --autounmask-continue=y app-office/abiword

#polybar
emerge -qv --autounmask-write=y --autounmask-continue=y  x11-misc/polybar

#chat client (add discord support)
emerge -qv --autounmask-write=y --autounmask-continue=y  net-im/pidgin

#firefox
emerge -qv --autounmask-write=y --autounmask-continue=y www-client/firefox www-client/firefox-bin

#Non root xorg needed (https://wiki.gentoo.org/wiki/Non_root_Xorg)

