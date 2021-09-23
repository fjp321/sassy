#config script and environment
source config.sh
source /etc/profile
export PS1="(chroot) ${PS1}"

#mount to boot
mount ${disk}1 /boot
emerge-webrsync
emerge --sync
