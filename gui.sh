useradd -m -G users,wheel,audio -s /bin/bash fjp
passwd fjp
rm /stage3* /install2.sh /config.sh
# base lxqt base
emerge --autounmask-write=y --autounmask-continue=y lxqt-base/lxqt-meta
# terminal emulator 
emerge --autounmask-write=y --autounmask-continue=y x11-terms/kitty
# file manager thunar
emerge --autounmask-write=y --autounmask-continue=y xfce-base/thunar
# display manager
emerge --autounmask-write=y --autounmask-continue=y x11-misc/sddm
#window manager
emerge --autounmask-write=y --autounmask-continue=y x11-wm/openbox
