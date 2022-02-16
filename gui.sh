emerge_flags="-qv --autounmask=y --autounmask-write=y --autounmask-continue=y"
main_user=fjp
useradd --create-home --groups tty,users,wheel,portage,lp,adm,audio,cdrom,disk,usb,video,cron --shell /bin/bash --comment "${main_user}" ${main_user}
passwd ${main_user}
rm /stage3* /install2.sh /config.sh

#packages for gui as well as ee tools
emerge ${emerge_flags} x11-base/xorg-server x11-drivers/xf86-input-evdev lynx gentoolkit firefox polybar neofetch iverilog kitty gtkwave dev-vcs/git calcurse ripgrep feh octave lua dev-python/pip ncmpcpp gimp blender libre-of app-editors/neovim mpv youtube-dl neomutt hsetroot vnstat app-eselect/eselect-repository openbox lightdm 

rc-update add elogind boot
/etc/init.d/elogind/start

# mkdir home directories
mkdir /home/${main_user}/music
mkdir /home/${main_user}/down
mkdir /home/${main_user}/doc
mkdir /home/${main_user}/script_dev
mkdir /home/${main_user}/git

su ${main_user}
