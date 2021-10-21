source config.sh

#mount to boot
mount ${bootpar} /boot
#update bins
emerge-webrsync
emerge --sync
eselect profile set 5
#fix circ deps
USE="abi_x86_32" emerge -v1 sys-libs/zlib
USE="-* abi_x86_32" emerge --verbose --oneshot --nodeps media-libs/harfbuzz
USE="-* abi_x86_32" emerge --verbose --oneshot --nodeps media-libs/freetype
USE="-* truetype harfbuzz abi_x86_32" emerge --verbose --oneshot media-libs/freetype
emerge --verbose --oneshot media-libs/freetype
#update world
emerge --verbose --update --deep --changed-use --autounmask-write=y --autounmask-continue=y @world

echo ACCEPT_LICENSE=\"*\" >> /etc/portage/make.conf
echo America/New_York > /etc/timezone
emerge --config sys-libs/timezone-data
echo en_US ISO-8859-1 >> /etc/locale.gen
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
eselect locale set 6
env-update && source /etc/profile
emerge --autounmask-write=y --autounmask-continue=y sys-kernel/gentoo-sources
eselect kernel set 1
emerge --autounmask-write=y --autounmask-continue=y sys-kernel/genkernel
