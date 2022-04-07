# do things as root
emerge -qv --autounmask-write=y --autounmask-continue=y x11-base/xorg-server x11-drivers/xf86-input-evdev firefox neofetch kitty calcurse feh dev-python/pip libreoffice app-editors/vim neomutt app-eselect/eselect-repository lightdm x11-misc/lightdm-mini-greeter xfce4-meta thunar thunar-volman tumbler xfce4-power-manager xfce4-pulseaudio-plugin tint2
mkdir /etc/share/wallpapers && cd /etc/share/wallpapers
wget https://raw.github.com/fjp321/sassy/main/extra/cyber_porsche.png
wget https://raw.github.com/fjp321/sassy/main/extra/cyber_porsche_blur.png
