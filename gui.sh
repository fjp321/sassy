useradd -m -G users,wheel,audio -s /bin/bash fjp
passwd fjp
rm /stage3* /install2.sh /config.sh
#xorg
emerge -qv --autounmask-write=y --autounmask-continue=y x11-base/xorg-drivers
# base xfce base
emerge -qv --autounmask-write=y --autounmask-continue=y xfce-base/xfce4-meta
# terminal emulator 
emerge -qv --autounmask-write=y --autounmask-continue=y x11-terms/kitty
# file manager thunar
emerge -qv --autounmask-write=y --autounmask-continue=y xfce-base/thunar
# display manager
emerge -qv --autounmask-write=y --autounmask-continue=y x11-misc/sddm
#window manager
emerge -qv --autounmask-write=y --autounmask-continue=y x11-wm/openbox
