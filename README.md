# fuzzy-goggles
bash script to run from installation media to setup gentoo automagically, use [gentoo amd64 wiki as source](https://wiki.gentoo.org/wiki/Handbook:AMD64)

PLEASE test on vm, it still needs testing. 

## Pre script
run net-setup to connect to internet, and ensure that connection is good by pinging www.gentoo.org. or plug into ehternet. net-setup is mostly useful for wireless connections. Next, partition the drive for a bios system. I like to use [fdisk](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Disks#Partitioning_the_disk_with_GPT_for_UEFI). Use fdisk -l to find the drive to partition. Take note of drive partitioned, it will need to be added to config.sh. The config will assume that "/dev/sda" is used, and that the boot system is uefi, not bios.
## Download
Run 

`wget https://raw.github.com/fjp321/fuzzy-goggles/main/install.sh`

and 

`wget https://raw.github.com/fjp321/fuzzy-goggles/main/config.sh`

Then run 
`chmod 777 install.sh config.sh`

to give full permission to the scripts. If this isn't okay with you, the user, then assign permissions as you deem fit. However, lack of executable permission will break things. 
## First
Make sure config.sh is correct, then run

`bash install.sh`
## Next

After install2.sh is finished, enter root passwd, and exit and unmount using

`umount -l /mnt/gentoo/dev{/shm,/pts,}`

`umount -R /mnt/gentoo` 

then reboot.
) to wallpaper used, credits to JustJon the artist!
## Graphics setup

Run 

`wget https://raw.github.com/fjp321/fuzzy-goggles/main/gui.sh`

to get the bash script to emerge the packages for the gui that I use as well as edit config to how I use them.

## Wallpaper
[Link](https://wallhaven.cc/index.php/w/p8ev7e) to wallpaper used, credits to JustJon the artist!

## Important Note
### No Safety Checks
This script is like the wild west, there are **no safety checks**. I highly encourage you, the user, to at least peruse throught the install scripts and config files to make sure things won't break.
### Openrc
This script will create an **openrc** system, no systemd here.
### AMD64 
This script is for **amd64** processors.
### GPU
This script assumes [amd gpus](https://wiki.gentoo.org/wiki/AMDGPU#USE_flags). Check link for compatibility. 
## Todo
- [ ] Update install.sh to exit on bad stage 3 checksum
- [ ] Update install.sh to have arg for not including amd video card support
- [ ] Add custom kernel support rather than genkernel all
- [ ] Add gui set up
- [ ] Update gui.sh to use dotfiles
- [ ] Create fork that works for arm processors (raspberry pis)
