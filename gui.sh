
useradd -m -G users,wheel,audio -s /bin/bash fjp
passwd fjp
rm /stage3* /install2.sh /config.sh
emerge --autounmask-write=y --autounmask-continue=y vim
emerge --autounmask-write=y --autounmask-continue=y x11-base/xorg-drivers
env-update
source /etc/profile
emerge --autounmask-write=y --autounmask-continue=y gui-libs/display-manager-init
emerge --autounmask-write=y --autounmask-continue=y x11-misc/lightdm
rc-update add dbus default
rc-update add display-manager default
emerge --autounmask-write=y --autounmask-continue=y x11-wm/openbox
mkdir -p /home/fjp/.config/openbox/ 
cp /etc/xdg/openbox/* /home/fjp/.config/openbox/
mkdir /home/fjp/wallpapers
cd /home/fjp/wallpapers
wget https://resi.ze-robot.com/dl/to/towards-the-sky-1920%C3%971080.jpg
mv towards-the-sky-1920x1080.jpg wallpaper1.jpg
cp /etc/bash/bashrc /home/fjp/.bashrc
echo 'export XSESSION=openbox' >> /home/fjp/.bashrc
