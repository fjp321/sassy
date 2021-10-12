source config.sh

#mount to boot
mount ${disk}1 /boot
emerge-webrsync
emerge --sync
eselect profile set 5
USE="abi_x86_32" emerge -v1 sys-libs/zlib
USE="-* abi_x86_32" emerge --verbose --oneshot --nodeps media-libs/harfbuzz
USE="-* abi_x86_32" emerge --verbose --oneshot --nodeps media-libs/freetype
USE="-* truetype harfbuzz abi_x86_32" emerge --verbose --oneshot media-libs/freetype
emerge --verbose --oneshot media-libs/freetype
emerge --verbose --update --deep --changed-use --autounmask-write=y @world
