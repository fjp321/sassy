main_user=fjp
useradd -m -G users,wheel,audio,video,input -s /bin/bash ${main_user}
passwd ${main_user}
rm /stage3* /install2.sh /config.sh

#wayland gui
emerge -qv --autounmask-write=y --autounmask-continue=y gui-wm/wayfire

emerge -qv --autounmask-write=y --autounmask-continue=y x11-misc/sddm
usermod -a -G video sddm
sed -i 's/DISPLAYMANAGER="xdm"/DISPLAYMANAGER="sddm"/' /etc/conf.d/display-manager
rc-update add display-manager default
