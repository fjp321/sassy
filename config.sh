disk="/dev/nvme0n1" #pre partition i.e. sda*, nvme0n1p*
bootpar="/dev/nvme0n1p1"
swappar="/dev/nvme0n1p2"
rootpar="/dev/nvme0n1p3"
gentoomirror="https://mirrors.rit.edu/gentoo"
mkopts="-j6"
useflags_var="X gtk vulkan bluetooth elogind -systemd -dvd -cdr"
