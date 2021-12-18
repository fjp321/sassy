emerge_flags="-qv --autounmask=y --autounmask-write=y --autounmask-continue=y"
main_user=fjp
-create-home --groups tty,users,wheel,portage,lp,adm,audio,cdrom,disk,usb,video,cron --shell /bin/bash --comment "${main_user}" ${main_user}
passwd ${main_user}
rm /stage3* /install2.sh /config.sh

#add use for mesa
echo -e "# required by standard X-server installation\nmedia-libs/mesa xa" >> /etc/portage/package.use/mesa 
emerge --qv --autounmask-write=y --autounmask-continue=y --deep --with-bdeps=y --changed-use --update @world

#packages for gui as well as ee tools
emerge ${emerge_flags} x11-base/xorg-server polybar iverilog kitty gtkwave www-client/otter dev-vcs/git calcurse media-fonts/hack ripgrep dmenu bspwm feh sxhkd dmenu i3lock octave dev-python/pip app-eselect/eselect-repository rofi dunst picom cmus gimp alsa jupyter
