source config.sh

#mount to boot
mount ${disk}1 /boot
emerge-webrsync
emerge --sync
