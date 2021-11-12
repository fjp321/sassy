source config.sh

#make filesystems and swap
mkfs.vfat -F 32 ${bootpar}
mkfs.ext4 ${rootpar}
mkswap ${swappar}
swapon ${swappar}

#mount root
# change time
ntpd -q -g

mount ${rootpar} /mnt/gentoo

#change directory into mounted gentoo
cd /mnt/gentoo

#download read and store (into stage3location) where the latest stage 3 tarball for openrc is
wget $gentoomirror/releases/amd64/autobuilds/latest-stage3-amd64-openrc.txt
IFS=' ' read -r stage3location z <<< $(tail -n +3 latest-stage3-amd64-openrc.txt)
IFS='/' read -r z stage3tarball <<< $stage3location
rm latest-stage3-amd64-openrc.txt
wget $gentoomirror/releases/amd64/autobuilds/$stage3location

#unzip tar ball
tar xpvf $stage3tarball --xattrs-include='*.*' --numeric-owner

#add options to make conf file
sed -i 's/COMMON_FLAGS="-O2 -pipe"/COMMON_FLAGS="-O2 -pipe -march=native"/' etc/portage/make.conf
echo -e '\n#MAKEOPTS\nMAKEOPTS="$mkopts"' >> etc/portage/make.conf
echo -e '\n#default mirror for gentoo\nGENTOO_MIRRORS="${gentoomirror}"' >> etc/portage/make.conf
echo -e '\n#video card options for amdgpu\nVIDEO_CARDS="${video_cards}"' >> etc/portage/make.conf
echo -e '\n#input device for x\nINPUT_DEVICES="libinput"' >> etc/portage/make.conf
echo -e '\n#global use flags\nUSE="${useflags_var}"' >> etc/portage/make.conf

#add repos conf to portage
mkdir --parents /mnt/gentoo/etc/portage/repos.conf
cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
cp --dereference /etc/resolv.conf /mnt/gentoo/etc/

#mount necessary file systems
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev

#download next scripts into /mnt/gentoo/
wget https://raw.github.com/fjp321/fuzzy-goggles/main/install2.sh
cp ~/config.sh ./config.sh
chmod 777 install2.sh
chmod 777 config.sh
#should run next part
chroot /mnt/gentoo ./install2.sh
