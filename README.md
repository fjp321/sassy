# fuzzy-goggles
bash script to run from installation media to setup gentoo automagically, use [gentoo amd64 wiki as source](https://wiki.gentoo.org/wiki/Handbook:AMD64)
## Pre script
run net-setup to connect to internet, and ensure that connection is good by pinging www.gentoo.org. 
Next, partition the drive for a uefi system. I like to use [fdisk](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Disks#Partitioning_the_disk_with_GPT_for_UEFI). Use fdisk -l to find the drive to partition. Take note of drive partitioned, it will need to be added to config.sh. The config will assume that "/dev/sda" is used, and that the boot system is uefi, not bios.
## Download
Run 

`wget https://raw.github.com/fjp321/main/install.sh`

and 

`wget https://raw.github.com/fjp321/main/config.sh`

Then run 

`chmod 777 install.sh config.sh`

to give full permission to the scripts. If this isn't okay with you, the user, then assign permissions as you deem fit. However, lack of executable permission will break things. 
## First
Make sure config.sh is correct, then run

`bash install.sh`
## Next
After install bash is finished, you, the user, will need to change root to /mnt/gentoo. The commands are as follows:

`chroot /mnt/gentoo /bin/bash`

`source /etc/profile`

`export PS1="(chroot) ${PS1}"`

Then run 

`bash install2.sh` 

to continue.

## Important Note
### No Safety Checks
This script is like the wild west, there are **no safety checks**. I highly encourage you, the user, to at least peruse throught the install scripts and config files to make sure things won't break.
### Openrc
This script will create an **openrc** system, no systemd here.
### AMD64 
This script is for **amd64** processors.
## Todo
- [ ] Update install.sh to exit on bad stage 3 checksum
