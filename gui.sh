emerge --autounmask-write=y --autounmask-continue=y x11-base/xorg-drivers
env-update
source /etc/profile
emerge --autounmask-write=y --autounmask-continue=y gui-libs/display-manager-init
emerge --autounmask-write=y --autounmask-continue=y x11-misc/lightdm
rc-update add display-manager default
