main_user=fjp
useradd -m -G users,wheel,audio,video,input -s /bin/bash ${main_user}
passwd ${main_user}
rm /stage3* /install2.sh /config.sh

#wayland
emerge -qv --autounmask-write=y --autounmask-continue=y gui-wm/wayfire
emerge -qv --autounmask-write=y --autounmask-continue=y gui-apps/tuigreet
