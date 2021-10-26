main_user=fjp
useradd -m -G users,wheel,audio,video -s /bin/bash ${main_user}
passwd ${main_user}
rm /stage3* /install2.sh /config.sh

#xorg
emerge -qv --autounmask-write=y --autounmask-continue=y x11-base/xorg-drivers
emerge -qv --autounmask-write=y --autounmask-continue=y media-libs/mesa
emerge -qv --autounmask-write=y --autounmask-continue=y media-libs/vulkan-loader
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

#sudo
emerge -qv --autounmask-write=y --autounmask-continue=y app-admin/sudo
echo 'fjp bristlecone /usr/bin/*' >> /etc/sudoers

#wallpapers
wget https://raw.github.com/fjp321/fuzzy-goggles/main/wallpaper1.png
wget https://raw.github.com/fjp321/fuzzy-goggles/main/wallpaper2.png

#vim
emerge -qv --autounmask-write=y --autounmask-continue=y app-editors/vim

# terminal emulator 
emerge -qv --autounmask-write=y --autounmask-continue=y x11-terms/terminator

# file manager spacefm
emerge -qv --autounmask-write=y --autounmask-continue=y x11-misc/spacefm

# word editor
emerge -qv --autounmask-write=y --autounmask-continue=y app-office/abiword

#polybar
emerge -qv --autounmask-write=y --autounmask-continue=y  x11-misc/polybar

#chat client (add discord support)
emerge -qv --autounmask-write=y --autounmask-continue=y  net-im/pidgin

#falkon
emerge -qv --autounmask-write=y --autounmask-continue=y www-client/falkon

#wine
emerge -qv --autounmask-write=y --autounmask-continue=y virtual/wine

#lutris
emerge -qv --autounmask-write=y --autounmask-continue=y games-util/lutris
