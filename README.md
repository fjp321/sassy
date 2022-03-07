# Sassy Bash Script
---

        |\__/,|   (`\
      _.|o o  |_   ) )
    -(((---(((--------

---
## What Is It?

Sassy bash script is a installation script written in bash to automate the three stages of installation of gentoo. It automates the initial mounting of a drive, it downloads and unzips the stage three tar ball onto the drive. It then syncs portage, and downloads initial packages using the portage package manager. It adds a user, adds various programs for the user, such as a cron daemon, system logger, and optionally openbox and lightdm. Finally, the script umounts the drive installed to, cleans up the installation files, and poweroffs. This allows the user to unplug the usb used to install and reboot into the Gentoo OS.

## Usage

Please refer to this usage message

    Usage: install.sh [options]\n"
    Options:\n"
      -w, will run with wifi support
      -d, will run fdisk on specified drive in install.sh, or user specified in query section
      -a, will use USE flags for amd gpu, mutually exclusive with other gpus
      -n, will use USE flags for nvidia gpu, mutually exclusive with other gpus
      -i, will use USE flags for intel gpu, mutually exclusive with other gpus
      -f, will go fast and skip user input, ignores gpu flags
      -h, Print help

The usage of this script requires a usb stick with the [minimal gentoo iso](https://www.gentoo.org/downloads/) written onto it. If you are on windows, please use [rufus](https://rufus.ie/en/). If you are on linux, please use the dd command, or [etcher](https://www.balena.io/etcher/).

Boot onto this usb stick, usually from bios menu.

Now, make sure you have internet connection. If you are connected via ethernet, this should all be ok. If you are connected to the internet via a wifi card, run 

> net-setup

And follow the instructions displayed to connect to the internet. Verify internet connections with 

> ping www.gentoo.org

Now, simply run

> wget https://raw.github.com/fjp321/sassy/main/install.sh

The install.sh scripts should now be downloaded. Peruse install.sh if wanted. The variables at the top between "MODIFY ME" comments will be modified with user input if not ran with -f flag. Modify them yourself if you want to run the script with the fast flag. If you have any questions about any of the variables, please navigate to resources. 

One note regarding timezones: if you don't know your timezone, please just leave the timezone as America/New_York. To update later, run 
> ls /usr/share/zoneinfo

to find your timezone, then edit /etc/timezone to the correct timezone. After editting, run 
> emerge --config sys-libs/timezone-data

After this, it is important to partition the hard drive that is to be used. I use fdisk to partition the drive. If the drive that is chosen is /dev/sda, run 

> fdisk /dev/sda

and update the install.sh script. Alternatively, run 

> bash install.sh -d

The drive should be partitioned to have a 256 MB UEFI partition, a RAM - sized swap space, and the rest for root. The home directory can be made on root or mounted later. 

Now, you are ready to run the bash script! Run

> bash install.sh

with all the options you wish to run. 

At the end of this script, the computer will unmount the drive you installed to and poweroff. Unplug the installation media, and power on. Based on if the gui flag was selected you should see either the command line or lightdm display manager.

## Design Choices

In this installation, I made multiple decisions that I think best benefit the greatest multitude of end users. If you have any disagreements, please fork this repository and make the changes you deem necessary for the benefit of others who may feel similarly. 

### UEFI

I decided to only add support for UEFI systems because I have never encountered a non UEFI system in the wild. 

### Openrc

I decided to use openrc rather than systemd for the init system. This is for multiple reasons. Openrc takes up much less space than systemd. Openrc starts the init scripts, then kills itself. The login management that is useful from systemd can be replicated using elogind, if needed. I have added elogind to this installation, since powering off and logging out is common with personal computers and laptops, the intended target.

### Lightdm

I chose lightdm for the desktop manager because it is lightweight, and allows for multiple users to login. It also allows for further custoimization if the user desires. 

### Xorg

Xorg servers are installed in order to draw windows as a gui. This is the entire point of the installation script, to create a user friendly environment. However, if a gui is not necessary, the make.conf file USE flags should be adjusted and remove the X flag. 

### Openbox

If guis are applicable for the use case necessary, openbox is the best option. It is lightweight and intuitive enough for users to quickly pick up the system. 

### Harfbuzz Circular Dependency

In the install2.sh script, there is a fairly large issue with harfbuzz and freetype: they are dependent on each other to work, are both not installed, and are both needed for the installation. To solve this, I used USE flags to install freetype without the dependency on harfbuzz, then update the world set. 

### Kernel Configuration

For the kernel compilation, I chose to use 
> genkernel all

This is because it provides the simplest configuration to compile for all possible modules and drivers. 

I am working on adding support for a custom kernel through the menu config or a saved file for added flexibility and reduced overhead. 

### GRUB2

I chose GRUB2 for the bootloader, because it is the most supported. Most modern linux systems use GRUB2, and therefore support for GRUB2 when needed is easy to find. 

## Resources

- [disk partitioning](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Disks#Partitioning_the_disk_with_GPT_for_UEFI)
- [make_opts variable](https://wiki.gentoo.org/wiki/MAKEOPTS)
- [video_cards variable](https://wiki.gentoo.org/wiki//etc/portage/make.conf#VIDEO_CARDS)
- [gentoo_mirror](https://wiki.gentoo.org/wiki/GENTOO_MIRRORS)
- [wifi_dev and wpa_supplicant](https://wiki.gentoo.org/wiki/Wpa_supplicant)
