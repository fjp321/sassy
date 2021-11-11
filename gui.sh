main_user=fjp
useradd -m -G users,wheel,audio,video -s /bin/bash ${main_user}
passwd ${main_user}
rm /stage3* /install2.sh /config.sh

#wayland
rc-update add elogind boot

