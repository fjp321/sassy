#!/bin/bash

trap "pkill -P $$" EXIT
main(){
        echo "partition disks ..."
        partition
        echo "make filesystems ..."
        make_file_system
        echo "mount root ..."
        mkdir /mnt/build
        mount /dev/$ROOT_PAR /mnt/build
        cd /mnt/build
}

# select the disk
select_disk(){
        DISK_TEMP=''
        DISK=''
        while [ $DISK -eq '']; do
                ACCEPTED_DISKS=$(lsblk -o NAME)
                echo $ACCEPTED_DISKS
                read -p 'select disk to repartition: ' DISK_TEMP
                if [[ $ACCEPTED_DISKS == *"$DISK_TEMP"* ]]; then
                        DISK=$DISK_TEMP
                fi
        done
}

# partition selected disk, will return the partitioned disk
partition(){
        select_disk
        ROOT_PAR=''
        BOOT_PAR=''
        if [[ $DISK == *"sda"* ]]; then
                ROOT_PAR="${DISK}2"
                BOOT_PAR="${DISK}1"
        else
                ROOT_PAR="${DISK}p2"
                BOOT_PAR="${DISK}p1"
        fi
        echo "Partitioning $DISK with partitions $BOOT_PAR, $ROOT_PAR using parted"
        parted /dev/$DISK mklabel gpt mkpart "EFI system partition" fat32 1MiB 513MiB set 1 esp on mkpart "home partition" ext4 513MiB 100%
}

# make fs on partitions
make_file_system () {
        mkfs.fat -F 32 /dev/$BOOT_PAR
        mkfs.ext4 /dev/$ROOT_PAR
}

main
