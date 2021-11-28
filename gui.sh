main_user=fjp
-create-home --groups tty,users,wheel,portage,lp,adm,audio,cdrom,disk,usb,video,cron --shell /bin/bash --comment "${main_user}" ${main_user}
passwd ${main_user}
rm /stage3* /install2.sh /config.sh

#add use for mesa
echo -e "# required by standard X-server installation\nmedia-libs/mesa xa" >> /etc/portage/package.use/mesa 
emerge --qv --autounmask-write=y --autounmask-continue=y --deep --with-bdeps=y --changed-use --update @world

#xorg
emerge -qv --autounmask-write=y --autounmask-continue=y --oneshot x11-base/xorg-server 
emerge -qv --autounmask-write=y --autounmask-continue=y x11-wm/twm x11-terms/xterm x11-apps/xclock x11-apps/xsetroot x11-apps/xrandr 
echo "#!/bin/sh\nLANG=C twm &\nxsetroot -solid CornflowerBlue &\nxclock -geometry 100x100-1+1 &\nxterm -geometry 80x50+494+51 &\nxterm -geometry 80x20+494-0 &\nexec xterm -geometry 80x66+0+0 -name login" > /home/${main_user}/.xinitrc
chmod 777 /home/${main_user}/.xinitrc
