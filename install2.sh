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
