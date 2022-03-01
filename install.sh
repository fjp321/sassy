
#!/bin/bash

trap "pkill -P $$" EXIT

disk="/dev/sda" #pre partition i.e. sda*, nvme0n1p*
bootpar="/dev/sda1"
swappar="/dev/sda2"
rootpar="/dev/sda3"
gentoomirror="https://mirrors.rit.edu/gentoo"
mkopts="-j4"
useflags_var="X elogind gmp gtk opengl pulseaudio python sound svg video vulkan -console-kit -systemd"
video_cards="virtualbox"
wifi_dev="wlp1s0"
wifi_ssid="node"
wifi_pass="secret"
hostname="computer"
timezone="America/New_York"
main_user="user"

# command line arg flags
config_flag=0
wifi_flag=0
fdisk_flag=0
amd_flag=0
nvidia_flag=0
intel_flag=0
gui_flag=0
fast_flag=0

# read prompt function
update() {
        read prompt
        if [ ! $prompt = "" ]
        then
                echo $prompt
        else
                echo $1
        fi
}

# help message function
usage() {
        printf "Usage: $0 [options [parameters]]\n"
        printf "Options:\n"
        printf " -w, will run with wifi support\n"
        printf " -d, will run fdisk on specified drive in config.sh\n"
        printf " -a, will use USE flags for amd gpu, mutually exclusive with other gpus\n"
        printf " -n, will use USE flags for nvidia gpu, mutually exclusive with other gpus\n"
        printf " -i, will use USE flags for intel gpu, mutually exclusive with other gpus\n"
        printf " -g, will include installation of openbox and lightdm\n"
        printf " -f, will go fast and skip user input\n"
#       not included yet
#       printf " -k|--kernel, specify genkernel config file, otherwise will run genkernel all\n"
        printf " -h, Print help\n"
}

# error handled exit
exit_abnormal() {
        usage
        exit 1
}

while getopts "dwang" options; do
        case "${options}" in
                w)
                        wifi_arg=1
                        ;;
                d)
                        fdisk_flag=1
                        ;;
                a)
                        amd_flag=1
                        ;;
                n)
                        nvidia_flag=1
                        ;;
                i)
                        intel_flag=1
                        ;;
                g)
                        gui_flag=1
                        ;;
                f)
                        fast_flag=1
                        ;;
                *)
                        exit_abnormal
                        ;;
        esac
done

if [ $amd_flag = 1 ] && [ $nvidia_flag = 0 ] && [ $intel_flag = 0 ] 
then
        video_card="amdgpu radeonsi"
fi
if [ $amd_flag = 0 ] && [ $nvidia_flag = 1 ] && [ $intel_flag = 0 ] 
then
        video_cards="nvidia nouveau"
fi
if [ $amd_flag = 0 ] && [ $nvidia_flag = 0 ] && [ $intel_flag = 1 ] 
then
        video_cards="intel"
fi

if [ fast_flag = 0 ] 
then

        # specify device
        printf "Specify device to write to (press enter for default /dev/sda) > "
        disk=$(update ${disk})
        
        if [ fdisk_flag = 1 ]
        then
                fdisk ${disk}
        fi
        
        printf "Specify boot partition. (press enter for default ${bootpar}) > "
        bootpar=$(update ${bootpar})
        
        printf "Specify swap partition. (press enter for default ${swappar}) > "
        swappar=$(update ${swappar})

        printf "Specify root partition. (press enter for default ${rootpar}) > "
        rootpar=$(update ${rootpar})

        printf "Specify default mirror to be used, please use most geographically close mirror. A full list of mirrors can be found at https://www.gentoo.org/downloads/mirrors/. (press enter for default ${gentoomirror}) > "
        gentoomirror=$(update ${gentoomirror})

        printf "Specify the number of parallel make jobs. More info can be found at https://wiki.gentoo.org/wiki/MAKEOPTS. (press enter for default ${mkopts}) > "
        mkopts=$(update ${mkopts})

        printf "Change the global USE flags for the system. It is suggested to go with defaults. More info can be found https://wiki.gentoo.org/wiki/USE_flag. (press enter for defaults \"${useflags_var}\") > "
        useflags_var=$(update ${useflags_vars})

        printf "Specify the video card flags to use. More information can be found at https://wiki.gentoo.org/wiki/Xorg/Guide#Make.conf. (press enter for default ${video_cards}) > "
        video_cards=$(update ${video_cards})

        if [ wifi_flag = 1 ]
        then
                printf "Specify the wifi device that is to be used. If you are unsure, please exit this script and run ifconfig. (press enter for default ${wifi_dev}) > "
                wifi_dev=$(update ${wifi_dev})
        
                printf "Specify wifi SSID. (press enter for default ${wifi_ssid}) > "
                wifi_ssid=$(update ${wifi_ssid})
        
                printf "Specify wifi password. (press enter for default ${wifi_pass}) > "
                wifi_pass=$(update ${wifi_pass})
        fi

        printf "Specify hostname. (press enter for default ${hostname}) > "
        hostname=$(update ${hostname})

        printf "Specify timezone. If you are unsure, please proceed with default and reconfigure after the system is installed. (press enter for default ${timezone}) > "
        timezone=$(update ${timezone})

        printf "Specify main username. (press enter for default ${hostname}) > "
        main_user=$(update ${main_user})
fi


# update options into config.sh
echo -e "bootpar=\"${bootpar}\"" >> config.sh
echo -e "swappar=\"${swappar}\"" >> config.sh
echo -e "rootpar=\"${rootpar}\"" >> config.sh
echo -e "hostname=\"${hostname}\"" >> config.sh
echo -e "wifi_dev=\"${wifi_dev}\"" >> config.sh
echo -e "wifi_ssid=\"${wif_ssid}\"" >> config.sh
echo -e "wif_pass=\"${wifi_pass}\"" >> config.sh

#make filesystems and swap
mkfs.fat -F 32 ${bootpar}
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
wget ${gentoomirror}/releases/amd64/autobuilds/latest-stage3-amd64-openrc.txt
IFS=' ' read -r stage3location z <<< $(tail -n +3 latest-stage3-amd64-openrc.txt)
IFS='/' read -r z stage3tarball <<< $stage3location
rm latest-stage3-amd64-openrc.txt
wget ${gentoomirror}/releases/amd64/autobuilds/$stage3location

#unzip tar ball
tar xpvf $stage3tarball --xattrs-include='*.*' --numeric-owner

#add options to make conf file
sed -i 's/COMMON_FLAGS="-O2 -pipe"/COMMON_FLAGS="-O2 -pipe -march=native"/' etc/portage/make.conf
echo -e "\n#MAKEOPTS\nMAKEOPTS=\"${mkopts}\"" >> etc/portage/make.conf
echo -e "\n#default mirror for gentoo\nGENTOO_MIRRORS=\"${gentoomirror}\"" >> etc/portage/make.conf
echo -e "\n#video card options for amdgpu\nVIDEO_CARDS=\"${video_cards}\"" >> etc/portage/make.conf
echo -e "\n#input device for x\nINPUT_DEVICES=\"libinput synaptics\"" >> etc/portage/make.conf
echo -e "\n#global use flags\nUSE=\"${useflags_var}\"" >> etc/portage/make.conf

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
if [ wifi_arg = 1 ] 
then
        if [ gui_arg = 1 ]
        then
                chroot /mnt/gentoo ./install2.sh -wg
        else
                chroot /mnt/gentoo ./install2.sh -w
        fi
else
        if [ gui_arg = 1 ]
        then
                chroot /mnt/gentoo ./install2.sh -g
        else
                chroot /mnt/gentoo ./install2.sh
        fi
fi

rm -rf /mnt/gentoo/stage3* /mnt/gentoo/install2.sh /mnt/gentoo/config.sh

# add reboot support
