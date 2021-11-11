main_user=fjp
useradd -m -G users,wheel,audio,video,input -s /bin/bash ${main_user}
passwd ${main_user}
rm /stage3* /install2.sh /config.sh

#wayland
emerge gui-wm/wayfire
emerge gui-apps/tuigreet
