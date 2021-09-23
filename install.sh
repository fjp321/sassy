source config.sh

#make filesystems and swap
mkfs.vfat -F 32 /dev/sda1
mkfs.ext4 /dev/sda3
mkswap /dev/sda2
swapon /dev/sda2

#mount root
mount /dev/sda3 /mnt/gentoo

#change directory into mounted gentoo
cd /mnt/gentoo

#download read and store (into stage3location) where the latest stage 3 tarball for openrc is
wget $gentoomirror/releases/amd64/autobuilds/latest-stage3-amd64-openrc.txt
IFS=' ' read -r stage3location z <<< $(tail -n +3 latest-stage3-amd64-openrc.txt)
IFS='/' read -r z stage3tarball <<< stage3location
rm latest-stage3-amd64-openrc.txt
wget $gentoomirror/releases/amd64/autobuilds/$stage3location
tar xvpf $stage3tarball
sed -i 's/COMMON_FLAGS="-O2 -pipe"/COMMON_FLAGS="-O2 -pipe = -march=native"/' etc/portage/make.conf
echo MAKEOPTS=\"$makeopts\"
