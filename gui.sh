main_user=fjp
useradd -m -G users,wheel,audio,video,input -s /bin/bash ${main_user}
passwd ${main_user}
rm /stage3* /install2.sh /config.sh

#wayland gui
mkdir -p /home/${main_user}/.config
emerge -qv --autounmask-write=y --autounmask-continue=y app-eselect/eselect-repository
eselect repository enable wayland-desktop
emaint sync --repo wayland-desktop
emerge -qv --autounmask-write=y --autounmask-continue=y gui-wm/labwc

emerge -qv --autounmask-write=y --autounmask-continue=y x11-misc/sddm
usermod -a -G video sddm
sed -i 's/DISPLAYMANAGER="xdm"/DISPLAYMANAGER="sddm"/' /etc/conf.d/display-manager
rc-update add display-manager default
rc-update add elogind boot
