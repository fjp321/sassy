# fuzzy-goggles
bash script to run from installation media to setup gentoo automagically
## Pre script
run net-setup to connect to internet, and ensure that connection is good by pinging www.gentoo.org. 
Next, partition the drive for a uefi system. I like to use [fdisk](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Disks#Partitioning_the_disk_with_GPT_for_UEFI). Use fdisk -l to find the drive to partition. Take note of drive partitioned, it will need to be added to config.sh. The config will assume that "/dev/sda" is used, and that the boot system is uefi, not bios.
