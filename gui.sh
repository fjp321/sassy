emerge_flags="-qv --autounmask=y --autounmask-write=y --autounmask-continue=y"
main_user=fjp
-create-home --groups tty,users,wheel,portage,lp,adm,audio,cdrom,disk,usb,video,cron --shell /bin/bash --comment "${main_user}" ${main_user}
passwd ${main_user}
rm /stage3* /install2.sh /config.sh

#packages for gui as well as ee tools
emerge ${emerge_flags} x11-base/xorg-server x11-drivers/xf86-input-evdev net-libs/webkit-gtk gentoolkit polybar conky neofetch iverilog alacritty gtkwave dev-vcs/git calcurse media-fonts/hack ripgrep dmenu bspwm feh sxhkd i3lock-color octave dev-python/pip rofi dunst picom cmus gimp alsa jupyter blender neovim zathura x11-misc/lightdm-mini-greeter

# light dm set up
rc-update add dbus default
rc-update add display-manager default
# add sed to replace "DISPLAYMANAGER=\"xdm\"" with "DISPLAYMANAGER=\"lightdm\"" at /etc/conf.d/display-manager
echo -e "greeter-session=lightdm-mini-greeter" >> /etc/lightdm/lightdm.conf
# add sed to replace "user = CHANGE_ME" to "user = ${main_user}"

# for icons, wget at https://github.com/zayronxio/Zafiro-icons/releases/download/1.2/Zafiro-Icons-Dark.tar.xz
mkdir /home/fjp/.local/share/icons
