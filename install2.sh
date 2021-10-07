source config.sh

#mount to boot
mount ${disk}1 /boot
emerge-webrsync
emerge --sync
eselect profile set 5
USE="-X -cairo -glib -graphite -harfbuzz -icu -introspection -png -truetype" emerge media-libs/freetype media-libs/harfbuzz
emerge --ask --verbose --update --deep --changed-use @world
