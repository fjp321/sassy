emerge_flags="-qv --autounmask=y --autounmask-write=y --autounmask-continue=y"
main_user=fjp
useradd --create-home --groups tty,users,wheel,portage,lp,adm,audio,cdrom,disk,usb,video,cron --shell /bin/bash --comment "${main_user}" ${main_user}
passwd ${main_user}
rm /stage3* /install2.sh /config.sh

# set additional use flags
echo -e "net-wireless/gnuradio grc uhd modtool" >> /etc/portage/package.use/gnuradio

#packages for gui as well as ee tools
emerge ${emerge_flags} x11-base/xorg-server x11-drivers/xf86-input-evdev lynx gentoolkit firefox polybar neofetch iverilog alacritty gtkwave dev-vcs/git calcurse media-fonts/hack ripgrep dmenu bspwm feh sxhkd octave lua dev-python/pip rofi dunst picom ncmpcpp gimp blender zathura =app-editors/neovim-0.6.0 mpv youtube-dl neomutt hsetroot vnstat app-eselect/eselect-repository =net-wireless/gnuradio-9999 

# mkdir home directories
mkdir /home/${main_user}/music
mkdir /home/${main_user}/down
mkdir /home/${main_user}/doc
mkdir /home/${main_user}/script
mkdir /home/${main_user}/git
